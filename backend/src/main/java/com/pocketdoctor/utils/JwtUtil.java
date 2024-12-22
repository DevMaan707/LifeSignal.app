package com.pocketdoctor.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import java.util.Map;
import java.util.function.Function;

@Component
public class JwtUtil {

    private final String SECRET_KEY = "DEgQGJRDtmsuIxiXQxtFlJb/SdCFBBfwyj+P4y302i4=";  // Use a stronger secret key in production

    // Retrieve username from JWT token
    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    // Retrieve expiration date from JWT token
    public Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).getBody();
    }

    private Boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    // Generate token for the user and store it in a file
    public String generateTokenAndStore(Map<String, Object> claims, String subject) {
        String token = Jwts.builder().setClaims(claims).setSubject(subject)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 10))  // 10 hours expiration
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY).compact();

        // Store the JWT in a file
        storeTokenInFile(token, subject);
        return token;
    }

    // Store the token in a file in the user's local directory
    private void storeTokenInFile(String token, String subject) {
        try {
            // Use platform-independent home directory
            String userHome = System.getProperty("user.home");
            String filePath = Paths.get(userHome, "jwt_tokens").toString();

            // Create directory if it doesn't exist
            File directory = new File(filePath);
            if (!directory.exists()) {
                directory.mkdirs();  // Create directory if not exists
            }

            // Define the token file path
            File file = new File(directory, subject + "_token.txt");

            try (FileWriter writer = new FileWriter(file)) {
                writer.write(token);
                System.out.println("JWT token saved to: " + file.getAbsolutePath());
            }

        } catch (IOException e) {
            System.err.println("Error writing token to file: " + e.getMessage());
            e.printStackTrace();  // Handle the exception as needed
        }
    }

    public Boolean validateToken(String token, String username) {
        final String extractedUsername = extractUsername(token);
        return (extractedUsername.equals(username) && !isTokenExpired(token));
    }
}
