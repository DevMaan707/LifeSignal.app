package com.pocketdoctor.services;

import com.pocketdoctor.model.DoctorData;
import com.pocketdoctor.model.HospitalData;
import com.pocketdoctor.model.PatientData;
import com.pocketdoctor.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class DoctorService {

    @Autowired
    DoctorRepository doctorRepository;

    public DoctorData findByMobileNo(String mobileno) {

        return doctorRepository.findByMobileno(mobileno).orElse(null);
    }
    public DoctorData findByUsernameAndPassword(String username, String password) {

        return doctorRepository.findByUsernameAndPassword(username,password).orElse(null);
    }
    public void saveUser(DoctorData doctorData) {
        doctorRepository.save(doctorData);
    }

    public void updateUser(DoctorData updatedPatientData, String mobileno) {
        // Find the existing user by mobile number
        Optional<DoctorData> existingUserOptional = doctorRepository.findByMobileno(mobileno);

        if (existingUserOptional.isPresent()) {
            DoctorData existingUser = existingUserOptional.get();

            // Update the necessary fields from updatedUserData
            existingUser.setName(updatedPatientData.getName());
            existingUser.setOtp(updatedPatientData.getOtp());

            // Save the updated user
            doctorRepository.save(existingUser);
        } else {
            // Handle case where the user does not exist
            throw new RuntimeException("User with mobile number " + mobileno + " not found.");
        }
    }

    public int getTotalDoctorsByHospital(String hospitalId) {
        return doctorRepository.countByHospitalId(hospitalId);  // Assuming you have this query method in the repository
    }

    public boolean isUsernameVerified(String username) {
        return doctorRepository.existsByUsernameAndVerify(username, true);
    }

}
