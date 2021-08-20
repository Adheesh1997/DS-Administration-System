package org.managementSystem.reviewService;

import org.managementSystem.reviewService.entities.Review;
import org.managementSystem.reviewService.repositories.ReviewRepo;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.Bean;

import java.util.Arrays;

@SpringBootApplication
@EnableEurekaClient
public class ReviewServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(ReviewServiceApplication.class, args);
	}

	@Bean
	ApplicationRunner init(ReviewRepo reviewRepo){
		return args -> {
			Review rev1 = new Review("1", Arrays.asList("foo", "bar"));
			Review rev2 = new Review("2", Arrays.asList("foo2", "bar2"));
			reviewRepo.save(rev1);
			reviewRepo.save(rev2);
		};
	}
}

