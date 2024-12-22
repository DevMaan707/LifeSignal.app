package com.pocketdoctor.repository;


import com.pocketdoctor.model.DoctorData;
import com.pocketdoctor.model.PatientData;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<PatientData, Integer> {

    Optional<PatientData> findByMobilenoAndOtp(String mobileno, String otp);

    Optional<PatientData> findByMobileno(String mobile);

    Optional<PatientData> findById(Integer id);

    //PatientData findByUsername(String username);


}