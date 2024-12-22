package com.pocketdoctor.services;


import com.pocketdoctor.model.DoctorData;
import com.pocketdoctor.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PageService {


    @Autowired
    private DoctorRepository doctorRepository;

    public void updateDoctorPassword(String username, String hospitalId, String newPassword) {
        int rowsUpdated = doctorRepository.updatePassword(newPassword, username, hospitalId);

        if (rowsUpdated > 0) {
            System.out.println("Password updated successfully for username: " + username);
        } else {
            System.out.println("No matching doctor found to update password.");
        }
    }
}
