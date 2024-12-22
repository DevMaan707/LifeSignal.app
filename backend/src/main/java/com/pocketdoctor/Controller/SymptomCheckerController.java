package com.pocketdoctor.Controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

@RestController
public class SymptomCheckerController {

    @Value("${openai.api.key}")
    private String openAiApiKey;

    @PostMapping("/check-symptoms")
    public ResponseEntity<String> checkSymptoms(@RequestBody String symptoms) {
        String apiUrl = "https://api.openai.com/v1/completions"; // For completion
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + openAiApiKey);
        headers.set("Content-Type", "application/json");

        // Correctly formatted prompt
        String prompt = "User has symptoms: " + symptoms + ". What could be the condition?";

        // Ensure valid JSON is being sent
        String jsonBody = "{"
                + "\"model\": \"gpt-4\","
                + "\"prompt\": \"" + prompt + "\","
                + "\"max_tokens\": 150"
                + "}";

        HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.POST, entity, String.class);
        return response;
    }
}
