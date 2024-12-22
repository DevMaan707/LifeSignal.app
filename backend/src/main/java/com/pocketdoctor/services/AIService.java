package com.pocketdoctor.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Service
public class AIService {

    @Value("${openai.api.key}")
    private String apiKey;

    @Value("${openai.api.url}")
    private String apiUrl;

    public String getAIResponse(String input) {
        try {
            // Construct the JSON payload
            String jsonPayload = String.format(
                    "{ \"model\": \"text-davinci-003\", \"prompt\": \"%s\", \"max_tokens\": 150, \"temperature\": 0.7 }",
                    input.replace("\"", "\\\"")
            );

            // Debug Payload
            System.out.println("JSON Payload: " + jsonPayload);

            // Build the HTTP request
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(apiUrl))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + apiKey)
                    .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
                    .build();

            // Send the HTTP request
            HttpClient client = HttpClient.newHttpClient();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            // Debug Response
            System.out.println("Status Code: " + response.statusCode());
            System.out.println("Response: " + response.body());

            return response.body();
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return "Error occurred while calling AI API: " + e.getMessage();
        }
    }
}
