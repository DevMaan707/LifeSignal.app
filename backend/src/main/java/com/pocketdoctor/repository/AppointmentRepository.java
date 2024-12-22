package com.pocketdoctor.repository;

import com.pocketdoctor.model.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface AppointmentRepository extends JpaRepository<Appointment,Long> {

    int countByHospitalId(String hospitalId);

    Appointment findByPatientId(String patientId);
}
