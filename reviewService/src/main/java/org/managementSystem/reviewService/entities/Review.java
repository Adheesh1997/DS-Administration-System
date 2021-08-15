package org.managementSystem.reviewService.entities;

import org.springframework.boot.autoconfigure.domain.EntityScan;

import javax.persistence.*;

@Entity
@Table(name = "review_table")
public class Review {
    @Id
    //@GeneratedValue(strategy = GenerationType.AUTO)
    String id;
    String review;

    public Review() {
    }

    public Review(String id, String review) {
        this.id = id;
        this.review = review;
    }

    public String getId() {
        return id;
    }


    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }
}
