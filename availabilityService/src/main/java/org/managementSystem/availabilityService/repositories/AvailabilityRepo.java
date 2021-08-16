package org.managementSystem.availabilityService.repositories;

import org.managementSystem.availabilityService.entities.Availability;
import org.springframework.data.repository.CrudRepository;


public interface AvailabilityRepo extends CrudRepository<Availability, String> {


}
