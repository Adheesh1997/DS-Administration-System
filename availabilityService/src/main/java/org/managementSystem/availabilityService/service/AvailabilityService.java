package org.managementSystem.availabilityService.service;

import org.managementSystem.availabilityService.entities.Availability;
import org.managementSystem.availabilityService.repositories.AvailabilityRepo;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AvailabilityService {

    @Autowired
    private AvailabilityRepo availabilityRepo;

    public List<Availability> getTheAvailabilitys(){
        List<Availability> availabilitys = new ArrayList<>();
        availabilityRepo.findAll()
                .forEach(availabilitys::add);
        return availabilitys;
    }

    public Availability getAvailabilityById(String id){
        return availabilityRepo.findById(id).get();
    }

    public void addAvailability(Availability availability) {
        availabilityRepo.save(availability);
    }

    public void updateAvailability(String id, Availability availability) {
        availabilityRepo.save(availability);
    }

    public void patchAvailability(String id, Availability availability) {
        availabilityRepo.save(availability);
    }



    public void deleteAvailability(String id) {
        availabilityRepo.deleteById(id);
    }

    public void addQuantity(Availability quantity) {
        availabilityRepo.save(quantity);
    }

    public void updateQuantity(String id, Availability quantity) {
        availabilityRepo.save(quantity);
    }

    public void deleteQuantity(String id) {
        availabilityRepo.deleteById(id);
    }
}
