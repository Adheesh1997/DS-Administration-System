package org.managementSystem.availabilityService.controller;

import org.managementSystem.availabilityService.entities.Availability;
import org.managementSystem.availabilityService.service.AvailabilityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@CrossOrigin
@RestController
@RequestMapping("availability")
public class AvailabilityController {

    @Autowired
    private AvailabilityService availabilityService;

    @GetMapping("getAll")
    public ResponseEntity<List<Availability>> getTheAvailabilitys(){
        List<Availability> allAvailabilitys = availabilityService.getTheAvailabilitys();
        return new ResponseEntity<>(allAvailabilitys, HttpStatus.OK);
    }

    @GetMapping("get/{id}")
    public ResponseEntity<Availability> getAvailability(@PathVariable String id){
        Availability expectedAvailability = availabilityService.getAvailabilityById(id);
        return new ResponseEntity<>(expectedAvailability, HttpStatus.OK);

    }

    @PostMapping("setAvailability")
    public void addAvailability(@RequestBody Availability availability){
        availabilityService.addAvailability(availability);
    }

    @PutMapping("updateAvailability/{id}")
    public void updateAvailability(@RequestBody Availability availability ,@PathVariable String id){
        availabilityService.updateAvailability(id, availability);
    }

    @PatchMapping("patchAvailability/{id}")
    public void patchAvailability(@RequestBody Availability availability ,@PathVariable String id){
        availabilityService.patchAvailability(id, availability);
    }

    @DeleteMapping("deleteAvailability/{id}")
    public void deleteAvailability(@PathVariable String id){
        availabilityService.deleteAvailability(id);
    }

    @PostMapping("setQuantity")
    public void addQuantity(@RequestBody Availability quantity){
        availabilityService.addQuantity(quantity);
    }

    @PutMapping("updateQuantity/{id}")
    public void updateQuantity(@RequestBody Availability quantity ,@PathVariable String id){
        availabilityService.updateQuantity(id, quantity);
    }

    @DeleteMapping("deleteQuantity/{id}")
    public void deleteQuantity(@PathVariable String id){
        availabilityService.deleteQuantity(id);
    }
}
