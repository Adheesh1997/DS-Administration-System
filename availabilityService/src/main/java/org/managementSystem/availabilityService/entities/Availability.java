package org.managementSystem.availabilityService.entities;


import javax.persistence.*;

@Entity
@Table(name = "availability_table")
public class Availability {
    @Id
    String id;
    String availability;
    Integer quantity ;

    public Availability() {
    }

    public Availability(String id, String availability, Integer quantity) {
        this.id = id;
        this.availability = availability;
        this.quantity = quantity;
    }

    public String getId() {
        return id;
    }


    public String getAvailability() {
        return availability;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
