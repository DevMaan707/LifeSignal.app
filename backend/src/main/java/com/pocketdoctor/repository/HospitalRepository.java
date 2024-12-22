package com.pocketdoctor.repository;

import com.pocketdoctor.model.DoctorData;
import com.pocketdoctor.model.HospitalData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HospitalRepository extends JpaRepository<HospitalData, Integer> {
    Optional<HospitalData> findByUsername(String username); // Return an Optional<HospitalData>

    Optional<HospitalData> findByUsernameAndPassword(String username, String password);

    Optional<HospitalData> findById(Integer id);

    List<HospitalData> findByCity(String city);

    List<HospitalData> findByName(String name);


}
