package com.pocketdoctor.Controller;
import com.pocketdoctor.services.OtpService;
import com.pocketdoctor.services.TwilioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/otp")
public class OtpController {

    @Autowired
    private OtpService otpService;

    @Autowired
    private TwilioService twilioService;


    public String sendOtp(String phoneNumber,String otp) {
        String formattedPhoneNumber = "+91" + phoneNumber;

        //String otp = otpService.generateOtp();

        System.out.println("{Mobile no = "+phoneNumber+" OTP = "+otp+"}");

        return twilioService.sendOtp(formattedPhoneNumber, otp);
    }

    public String sendInfoWithUsername(String phoneNumber,String username, String link) {
        String formattedPhoneNumber = "+91" + phoneNumber;

        //String otp = otpService.generateOtp();

        System.out.println("{Mobile no = "+phoneNumber+" Username = "+username+" Link = "+link+" }");

        return twilioService.sendInfoWithUsername(formattedPhoneNumber, username, link);
    }
}
