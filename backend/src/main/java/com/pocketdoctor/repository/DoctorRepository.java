package com.pocketdoctor.repository;

import com.pocketdoctor.model.DoctorData;
import com.pocketdoctor.model.PatientData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.print.Doc;
import java.util.List;
import java.util.Optional;

@Repository
public interface DoctorRepository extends JpaRepository<DoctorData, Integer> {

    List<DoctorData> findByHospitalId(String hospitalId);

    Optional<DoctorData> findByMobilenoAndOtp(String mobileno, String otp);

    Optional<DoctorData> findByUsernameAndPassword(String username, String password);

    Optional<DoctorData> findByMobileno(String mobile);

    int countByHospitalId(String hospitalId);

    boolean existsByUsernameAndVerify(String username, boolean verify);

    @Transactional
    @Modifying
    @Query("UPDATE DoctorData d SET d.password = :password, d.verify = true WHERE d.username = :username AND d.hospitalId = :hospitalId")
    int updatePassword(@Param("password") String password,
                       @Param("username") String username,
                       @Param("hospitalId") String hospitalId);
}
