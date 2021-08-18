package org.managementSystem.availabilityService;

import org.managementSystem.availabilityService.entities.Availability;
import org.managementSystem.availabilityService.repositories.AvailabilityRepo;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableEurekaClient
public class AvailabilityServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(AvailabilityServiceApplication.class, args);
	}

	@Bean
	ApplicationRunner init(AvailabilityRepo availabilityRepo){
		return args -> {
			Availability ex1 = new Availability("1", "In Stock",5);
			Availability ex2 = new Availability("2", "Out of Stock",8);
			Availability ex3 = new Availability("3", "In Stock",10);
			availabilityRepo.save(ex1);
			availabilityRepo.save(ex2);
			availabilityRepo.save(ex3);
		};
	}
}

