package com.pocketdoctor.model;


import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "doctorInfo")
public class DoctorData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;
    String name;
    String mobileno;
    String otp;
    boolean verify;
    String username;
    String password;
    String qualification;
    String specialist;
    String hospitalId;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public DoctorData(){}

    public DoctorData(Integer id, String name, String mobileno, String otp, boolean verify, String username, String password, String qualification, String specialist, String hospitalId) {
        this.id = id;
        this.name = name;
        this.mobileno = mobileno;
        this.otp = otp;
        this.verify = verify;
        this.username = username;
        this.password = password;
        this.qualification = qualification;
        this.specialist = specialist;
        this.hospitalId = hospitalId;
    }


    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        DoctorData that = (DoctorData) o;
        return verify == that.verify && Objects.equals(id, that.id) && Objects.equals(name, that.name) && Objects.equals(mobileno, that.mobileno) && Objects.equals(otp, that.otp) && Objects.equals(username, that.username) && Objects.equals(password, that.password) && Objects.equals(qualification, that.qualification) && Objects.equals(specialist, that.specialist) && Objects.equals(hospitalId, that.hospitalId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, mobileno, otp, verify, username, password, qualification, specialist, hospitalId);
    }

    public DoctorData(String hospitalId, String specialist, String qualification, boolean verify, String otp, String mobileno, String name, Integer id) {
        this.hospitalId = hospitalId;
        this.specialist = specialist;
        this.qualification = qualification;
        this.verify = verify;
        this.otp = otp;
        this.mobileno = mobileno;
        this.name = name;
        this.id = id;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getSpecialist() {
        return specialist;
    }

    public void setSpecialist(String specialist) {
        this.specialist = specialist;
    }

    public String getHospitalId() {
        return hospitalId;
    }

    public void setHospitalId(String hospitalId) {
        this.hospitalId = hospitalId;
    }

    public DoctorData(Integer id, boolean verify, String otp, String mobileno, String name, String hospitalId) {
        this.id = id;
        this.verify = verify;
        this.otp = otp;
        this.mobileno = mobileno;
        this.name = "Dr. "+ name;
        this.hospitalId = hospitalId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = "Dr. "+name;
    }

    public String getMobileno() {
        return mobileno;
    }

    public void setMobileno(String mobileno) {
        this.mobileno = mobileno;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public boolean isVerify() {
        return verify;
    }

    public void setVerify(boolean verify) {
        this.verify = verify;
    }
}
