package com.pocketdoctor.services;

import com.pocketdoctor.model.PatientData;
import com.pocketdoctor.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
public class UserServices {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JdbcTemplate jdbcTemplate;



    public PatientData registerUser(String name, String email, String type, String mobileno, String otp){


            if(userRepository.findByMobileno(mobileno).isPresent()){
                System.out.println("Duplicate Login");
                return null;
            }

            PatientData patientData = new PatientData();

            patientData.setName(name);
            //userData.setEmail(email)
            patientData.setMobileno(mobileno);
            patientData.setOtp(otp);

            userRepository.save(patientData);
            return patientData;

    }
    
    public boolean authenticateUser(String mobileno, String otp) {
        Optional<PatientData> user = userRepository.findByMobilenoAndOtp(mobileno, otp);

        // Check if user is found and OTP matches
        return user.isPresent();
    }


    public boolean updateOtpInDatabase(String mobileNo, String otp) {
        String sql = "UPDATE patient_info SET otp = ? WHERE mobileno = ?";
        int result = jdbcTemplate.update(sql, otp, mobileNo);
        return result > 0;
    }

    public void saveUser(PatientData patientData) {

        userRepository.save(patientData);
    }

    public void updateUser(PatientData updatedPatientData, String mobileno) {
        // Find the existing user by mobile number
        Optional<PatientData> existingUserOptional = userRepository.findByMobileno(mobileno);

        if (existingUserOptional.isPresent()) {
            PatientData existingUser = existingUserOptional.get();

            // Update the necessary fields from updatedUserData
            existingUser.setName(updatedPatientData.getName());
            existingUser.setOtp(updatedPatientData.getOtp());

            // Save the updated user
            userRepository.save(existingUser);
        } else {
            // Handle case where the user does not exist
            throw new RuntimeException("User with mobile number " + mobileno + " not found.");
        }
    }


    public PatientData findByMobileNo(String mobileno) {

        return userRepository.findByMobileno(mobileno).orElse(null);
    }

    public PatientData findById(String id) {
        return userRepository.findById(Integer.valueOf(id)).orElse(null); // Changed to Long
    }

    //public PatientData findByUsername(String username){
      //  return userRepository.findByUsername(username);
    //}

}