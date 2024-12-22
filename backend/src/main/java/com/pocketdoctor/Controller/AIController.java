package com.pocketdoctor.Controller;

import com.pocketdoctor.services.AIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ai")
public class AIController {

    @Autowired
    private AIService aiService;

    @PostMapping("/process")
    public String processAI(@RequestBody String input) {
        return aiService.getAIResponse(input);
    }
}
