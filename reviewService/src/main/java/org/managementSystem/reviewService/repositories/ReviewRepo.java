package org.managementSystem.reviewService.repositories;

import org.managementSystem.reviewService.entities.Review;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ReviewRepo extends CrudRepository<Review, String> {


}
