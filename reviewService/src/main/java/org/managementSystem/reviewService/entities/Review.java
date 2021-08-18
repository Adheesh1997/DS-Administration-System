package org.managementSystem.reviewService.entities;

import org.springframework.boot.autoconfigure.domain.EntityScan;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "review_table")
public class Review {
    @Id
    //@GeneratedValue(strategy = GenerationType.AUTO)
    String id;
    //String review;
    @ElementCollection
    List<String> reviewList;

    public Review() {
    }

    /*public Review(String id, String review) {
        this.id = id;
        this.review = review;
    }*/

    public Review(String id, List<String> reviewList) {
        this.id = id;
        this.reviewList = reviewList;
    }

    public List<String> getReviewList() {
        return reviewList;
    }

    public void setReviewList(List<String> reviewList) {
        this.reviewList = reviewList;
    }

    public String getId() {
        return id;
    }

    /*public String getReview() {
        return review;
    }*/

    /*public void setReview(String review) {
        this.review = review;
    }*/
}
