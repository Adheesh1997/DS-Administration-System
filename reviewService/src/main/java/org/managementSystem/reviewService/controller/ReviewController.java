package org.managementSystem.reviewService.controller;

import org.apache.coyote.Response;
import org.managementSystem.reviewService.entities.Review;
import org.managementSystem.reviewService.repositories.ReviewRepo;
import org.managementSystem.reviewService.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@CrossOrigin(origins =  "http://localhost:11613" )
@RestController
@RequestMapping("rv")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping("getAll")
    public ResponseEntity<List<Review>> getTheReviews(){
        List<Review> allReviews = reviewService.getTheReviews();
        return new ResponseEntity<>(allReviews, HttpStatus.OK);
    }

    @GetMapping("by/{id}")
    public ResponseEntity<Review> getReview(@PathVariable String id){
        Review expectedReview = reviewService.getReviewById(id);
        return new ResponseEntity<>(expectedReview, HttpStatus.OK);

    }

    @GetMapping("Hi")
    public String HiFunction(){
        return "Hi";
    }

    @PostMapping("by/createReview")
    public void addReview(@RequestBody Review review){
        reviewService.addReview(review);
    }

    @PutMapping("by/{id}")
    public void updateReview(@RequestBody Review review ,@PathVariable String id){
        reviewService.updateReview(id, review);
    }

    @DeleteMapping("by/{id}")
    public void deleteReview(@PathVariable String id){
        reviewService.deleteReview(id);
    }
}
