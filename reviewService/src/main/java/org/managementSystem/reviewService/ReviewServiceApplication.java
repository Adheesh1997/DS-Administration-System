package org.managementSystem.reviewService;

import org.managementSystem.reviewService.entities.Review;
import org.managementSystem.reviewService.repositories.ReviewRepo;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class ReviewServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(ReviewServiceApplication.class, args);
	}

	@Bean
	ApplicationRunner init(ReviewRepo reviewRepo){
		return args -> {
			Review rev1 = new Review("1", "appRunRev1");
			Review rev2 = new Review("2", "appRunRev2");
			reviewRepo.save(rev1);
			reviewRepo.save(rev2);
		};
	}
}

