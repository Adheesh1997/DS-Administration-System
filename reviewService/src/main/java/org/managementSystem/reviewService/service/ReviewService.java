package org.managementSystem.reviewService.service;

import org.managementSystem.reviewService.entities.Review;
import org.managementSystem.reviewService.repositories.ReviewRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepo reviewRepo;

    public List<Review> getTheReviews(){
        //return theReviews;
        List<Review> reviews = new ArrayList<>();
        reviewRepo.findAll()
                .forEach(reviews::add);
        return reviews;
    }

    public Review getReviewById(String id){
        //return theReviews.stream().filter(t -> t.getId().equals(id)).findFirst().get();
        return reviewRepo.findById(id).get();
    }

    public void addReview(Review review) {
        //theReviews.add(review);
        reviewRepo.save(review);
    }

    public void updateReview(String id, Review review) {
        reviewRepo.save(review);
    }

    public void updateReviewInList(String id, List<String> newReviews) {
        reviewRepo.updateUserChoices(newReviews, id);
    }

    public void deleteReview(String id) {
        //theReviews.removeIf(t -> t.getId().equals(id));
        reviewRepo.deleteById(id);
    }
}
