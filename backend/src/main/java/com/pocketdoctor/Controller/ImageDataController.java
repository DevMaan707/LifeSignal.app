package com.pocketdoctor.Controller;

import com.pocketdoctor.model.ImageData;
import com.pocketdoctor.model.ImageUploadResponse;
import com.pocketdoctor.model.PatientData;
import com.pocketdoctor.services.ImageDataService;
import com.pocketdoctor.services.UserServices;
import com.pocketdoctor.utils.ImageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/image")
public class ImageDataController {

    @Autowired
    private ImageDataService imageDataService;

    @Autowired
    UserServices userServices;

    @PostMapping("/upload")
    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile file, @RequestParam("userId") String userId, @RequestParam("userType") String userType){
        try {
            // Retrieve the file name
            String fileName = file.getOriginalFilename();
            System.out.println("Uploaded file name: " + fileName);

            PatientData patientData = userServices.findById(userId);

            patientData.setProfilename(fileName);
            userServices.saveUser(patientData);

            // Process the file (e.g., compress and save)
            ImageData imageData = ImageData.builder()
                    .name(fileName) // Store the file name
                    .userId(userId)
                    .userType(userType)
                    .type(file.getContentType())
                    .imageData(ImageUtil.compressImage(file.getBytes()))
                    .build();

            imageDataService.saveImage(imageData);

            return ResponseEntity.ok("Image uploaded successfully: " + fileName);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error uploading image");
        }
    }



    @GetMapping(value = "/view/{name}", produces = MediaType.IMAGE_JPEG_VALUE)
    public ResponseEntity<byte[]> getImage(@PathVariable String name) {
        ImageData imageData = imageDataService.getImageByName(name);
        byte[] decompressedImage = ImageUtil.decompressImage(imageData.getImageData());
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(imageData.getType()))
                .body(decompressedImage);
    }


    @GetMapping("/{name}")
    public ResponseEntity<?> getImageByName(@PathVariable("name") String name) {
        try {
            byte[] image = imageDataService.getImage(name);
            return ResponseEntity.status(HttpStatus.OK)
                    .contentType(MediaType.IMAGE_JPEG)
                    .body(image);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
