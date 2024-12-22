package com.pocketdoctor.services;

import com.pocketdoctor.model.ImageData;
import com.pocketdoctor.model.ImageUploadResponse;
import com.pocketdoctor.repository.ImageDataRepository;
import com.pocketdoctor.utils.ImageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Optional;

@Service
public class ImageDataService {

    @Autowired
    private ImageDataRepository imageDataRepository;

    public void saveImage(ImageData imageData) {
        imageDataRepository.save(imageData);
    }

    public void uploadImage(MultipartFile file) throws IOException {
        // Create ImageData object and compress the file
        ImageData imageData = ImageData.builder()
                .name(file.getOriginalFilename())
                .type(file.getContentType())
                .imageData(ImageUtil.compressImage(file.getBytes())) // Compress image here
                .build();

        saveImage(imageData);
    }

    public ImageData getInfoByImageByName(String name) {
        // Fetch image data by name and decompress the image data
        ImageData image = imageDataRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException("Image not found with name: " + name));

        return ImageData.builder()
                .name(image.getName())
                .type(image.getType())
                .imageData(ImageUtil.decompressImage(image.getImageData()))
                .build();
    }

    public byte[] getImage(String name) {
        // Fetch image binary data by name
        ImageData image = imageDataRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException("Image not found with name: " + name));

        return ImageUtil.decompressImage(image.getImageData());
    }
    public ImageData getImageByName(String name) {
        return imageDataRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException("Image not found with name: " + name));
    }
}
