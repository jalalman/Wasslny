package com.axsosacademy.wasslny.models;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "passengers")
public class Passenger extends User {

    public Passenger() {
        super();
    }
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "trips_passengers", 
        joinColumns = @JoinColumn(name = "passenger_id"), 
        inverseJoinColumns = @JoinColumn(name = "trip_id")
    )
    private List<Trip> trips;

    public Passenger(String email, String password, String firstName, String lastName, String phoneNumber, String location) {
        super(email, password, firstName, lastName, phoneNumber, location);
    }
}