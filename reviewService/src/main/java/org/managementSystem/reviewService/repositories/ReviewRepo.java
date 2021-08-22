package org.managementSystem.reviewService.repositories;

import org.managementSystem.reviewService.entities.Review;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ReviewRepo extends CrudRepository<Review, String> {

    @Query("update Review set reviewList=?1 where id=?2")
    void updateUserChoices(List<String> newReviews,String id);
}
