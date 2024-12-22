package com.pocketdoctor.services;

import com.pocketdoctor.model.DoctorData;
import com.pocketdoctor.model.HospitalData;
import com.pocketdoctor.repository.DoctorRepository;
import com.pocketdoctor.repository.HospitalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class HospitalService {

    @Autowired
    private HospitalRepository hospitalRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    public List<DoctorData> getDoctorsByHospitalId(String hospitalId) {

        List<DoctorData> verifiedData = new ArrayList<>();
        List<DoctorData> data = doctorRepository.findByHospitalId(hospitalId);

        for(int i=0;i<data.size();i++){

            if(data.get(i).isVerify()){
                verifiedData.add(data.get(i));
            }

        }

        return verifiedData;
    }
    public HospitalData findByUsernameAndPassword(String username,String password) {

        return hospitalRepository.findByUsernameAndPassword(username,password).orElse(null);
    }

    public String getHospitalName(String hospitalId) {
        // Fetch the HospitalData using hospitalId
        return hospitalRepository.findById(Integer.valueOf(hospitalId))
                .map(HospitalData::getName) // Assuming the name field is called `name`
                .orElse("Hospital name not found"); // Handle if no record is found
    }

    public Integer getHospitalId(String username) {
        // Fetch the HospitalData using username
        return hospitalRepository.findByUsername(username)
                .map(HospitalData::getId) // Assuming `getId()` returns the hospital's ID
                .orElse(null); // Return null or throw a custom exception if not found
    }


    public List<HospitalData> findByCity(String city){
        return hospitalRepository.findByCity(city);
    }
    public List<HospitalData> findByName(String name){
        return hospitalRepository.findByName(name);
    }

    public Optional<HospitalData> findById(Integer id){
        return hospitalRepository.findById(id);
    }


}
