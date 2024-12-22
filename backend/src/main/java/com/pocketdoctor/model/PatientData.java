package com.pocketdoctor.model;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Objects;

@Entity
@Table(name = "patientInfo")
public class PatientData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;
    String name;
    //String email;
    @Getter
    @Setter
    String profilename;
    String city;
    String mobileno;
    String otp;
    String type = "Patient";



    public PatientData() {

    }

    public String getType() {
        return type;
    }

    public Integer getId(){
        return id;
    }

    public void setType(String type) {
        this.type = "Patient";
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        PatientData that = (PatientData) o;
        return Objects.equals(id, that.id) && Objects.equals(name, that.name) && Objects.equals(profilename, that.profilename) && Objects.equals(city, that.city) && Objects.equals(mobileno, that.mobileno) && Objects.equals(otp, that.otp) && Objects.equals(type, that.type);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, profilename, city, mobileno, otp, type);
    }

    @Override
    public String toString() {
        return "PatientData{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", profilename='" + profilename + '\'' +
                ", city='" + city + '\'' +
                ", mobileno='" + mobileno + '\'' +
                ", otp='" + otp + '\'' +
                ", type='" + type + '\'' +
                '}';
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getOtp() {
        return otp;


    }

    public void setOtp(String otp) {
        this.otp = otp;
    }



    public String getMobileno() {
        return mobileno;
    }

    public void setMobileno(String mobileno) {
        this.mobileno = mobileno;
    }

    //public String getEmail() {
       // return email;
   // }

    //public void setEmail(String email) {
      //  this.email = email;
    //}

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}
