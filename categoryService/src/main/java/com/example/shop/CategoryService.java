package com.example.shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@SpringBootApplication
public class CategoryService {

	public static void main(String[] args) {
		SpringApplication.run(CategoryService.class, args);
	}

	@Bean
	ApplicationRunner init(VehicleRepo vehicleRepo){
		return  args -> {
			//Vehicle v1 = new Vehicle("AB1231", category:"car", numberOfSeats: "4");
			Vehicle v1 = new Vehicle("AB1231","car","4");
			vehicleRepo.save(v1);
			Vehicle v2 = new Vehicle("BB1631","car","4");
			vehicleRepo.save(v2);
			Vehicle v3 = new Vehicle("YT1231","truck","6");
			vehicleRepo.save(v3);
		};
	}

}




@Entity
@Table(name = "vehicles_table")
class Vehicle{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	long id;

	public Vehicle(String licensePlateNumber, String category, String numberOfSeats) {
		this.licensePlateNumber = licensePlateNumber;
		this.category = category;
		this.numberOfSeats = numberOfSeats;
	}

	String licensePlateNumber;

	String category;

	String numberOfSeats;

	public Vehicle() {

	}

	public long getId() {
		return id;
	}

	public String getLicensePlateNumber() {
		return licensePlateNumber;
	}

	public void setLicensePlateNumber(String licensePlateNumber) {
		this.licensePlateNumber = licensePlateNumber;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getNumberOfSeats() {
		return numberOfSeats;
	}

	public void setNumberOfSeats(String numberOfSeats) {
		this.numberOfSeats = numberOfSeats;
	}

}

@Repository
interface VehicleRepo extends JpaRepository<Vehicle, Long>{
	//@Query(value = "select v from Vehicle v where v.category = category")
	//public List<Vehicle> retrieveBasedOnCategory(String category);
}
@CrossOrigin(origins =  "http://localhost:11613" )
@RestController
@RequestMapping("vehicle")
class VehicleController{

	@Autowired
	VehicleRepo repo;


	@PostMapping("create")
	public ResponseEntity<Vehicle> AddVehicle(@RequestBody Vehicle vehicle){

		Vehicle saveVehicle = repo.save(vehicle);

		return new ResponseEntity<>(saveVehicle, HttpStatus.OK);
	}

	@GetMapping("all")
	public ResponseEntity<List<Vehicle>> getAllVehicles(){
		List<Vehicle> allVehicles = repo.findAll();
		return  new ResponseEntity<>(allVehicles, HttpStatus.OK);
	}

	@GetMapping ("category")
	//@RequestMapping("/{category}")
	public ResponseEntity<List<Vehicle>> getVehicleByCategory(@RequestParam String category){
		List<Vehicle> allVehicleList = repo.findAll();

		List<Vehicle> categoryList =new ArrayList<Vehicle>();
		Vehicle tempV;

		for (Vehicle vehicle : allVehicleList) {

			if (vehicle.category.equals(category)) {
				tempV = vehicle;
				categoryList.add(tempV);
			}

		}

		return new ResponseEntity<>(categoryList, HttpStatus.OK);
	}


}