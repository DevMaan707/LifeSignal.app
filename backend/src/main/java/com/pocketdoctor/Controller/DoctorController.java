package com.pocketdoctor.Controller;

import com.pocketdoctor.model.DoctorData;
import com.pocketdoctor.model.HospitalData;
import com.pocketdoctor.model.PatientData;
import com.pocketdoctor.repository.DoctorRepository;
import com.pocketdoctor.services.DoctorService;
import com.pocketdoctor.services.OtpService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/doctor")
@CrossOrigin(origins = "*")
public class DoctorController {

    private static final Logger logger = LoggerFactory.getLogger(DoctorController.class);

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private OtpService otpService;

    @Autowired
    private OtpController otpController;

    @PostMapping("/add")
    public ResponseEntity<DoctorData> addDoctor(@RequestBody DoctorData doctorData) {

        String otp = otpService.generateOtp();
        
        String link = "http://localhost:8585/api/doctor/create-password/"+doctorData.getUsername();

        try {
            doctorData.setOtp(otp);
            DoctorData savedDoctor = doctorRepository.save(doctorData);
            otpController.sendInfoWithUsername(doctorData.getMobileno(), doctorData.getUsername(),link);
            return new ResponseEntity<>(savedDoctor, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @PostMapping("/add/verify")
    public ResponseEntity<DoctorData> verify(@RequestBody Map<String, String> request) {
        String mobileno = request.get("mobileno");
        String otp = request.get("otp");

        if (mobileno == null || otp == null) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }

        Optional<DoctorData> doctorDataOptional = doctorRepository.findByMobileno(mobileno);

        if (doctorDataOptional.isPresent()) {
            DoctorData doctorData = doctorDataOptional.get();
            if (doctorData.getOtp().equals(otp)) {
                doctorData.setVerify(true);
                doctorRepository.save(doctorData);
                return new ResponseEntity<>(doctorData, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(null, HttpStatus.UNAUTHORIZED);
            }
        } else {
            return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<String> loginDoctor(@RequestBody DoctorData doctorData){
        String username = doctorData.getUsername();
        String password= doctorData.getPassword();
        DoctorData existingUser = doctorService.findByUsernameAndPassword(username,password);

        if(existingUser != null){
            return new ResponseEntity<>("Login successfully", HttpStatus.OK);
        }
        return new ResponseEntity<>("Wrong Password and username", HttpStatus.NO_CONTENT);
    }


}