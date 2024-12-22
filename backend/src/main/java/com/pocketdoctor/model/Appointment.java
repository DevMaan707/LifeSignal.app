package com.pocketdoctor.model;


import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "appointment")
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long appointmentId;
    String patientId;
    String hospitalId;
    String doctorId;
    String appointmentData;

    public Appointment(){}

    public Appointment(Long id, String patientId, String hospitalId, String doctorId, String appointmentData) {
        this.appointmentId = id;
        this.patientId = patientId;
        this.hospitalId = hospitalId;
        this.doctorId = doctorId;
        this.appointmentData = appointmentData;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Appointment that = (Appointment) o;
        return Objects.equals(appointmentId, that.appointmentId) && Objects.equals(patientId, that.patientId) && Objects.equals(hospitalId, that.hospitalId) && Objects.equals(doctorId, that.doctorId) && Objects.equals(appointmentData, that.appointmentData);
    }

    @Override
    public int hashCode() {
        return Objects.hash(appointmentId, patientId, hospitalId, doctorId, appointmentData);
    }

    public Long getId() {
        return appointmentId;
    }

    public void setId(Long id) {
        this.appointmentId = id;
    }

    public String getHospitalId() {
        return hospitalId;
    }

    public void setHospitalId(String hospitalId) {
        this.hospitalId = hospitalId;
    }

    public String getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }

    public String getAppointmentData() {
        return appointmentData;
    }

    public void setAppointmentData(String appointmentData) {
        this.appointmentData = appointmentData;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
}
