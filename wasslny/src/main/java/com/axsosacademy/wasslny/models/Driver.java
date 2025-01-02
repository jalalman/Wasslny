package com.axsosacademy.wasslny.models;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "drivers")
public class Driver extends User {
	
	private String permitNumber;
	
	private String carModel;

    public Driver() {
        super();
    }
    
    @OneToMany(mappedBy="driver", fetch=FetchType.LAZY)
	private List<Trip> trips;

    public Driver(String email, String password, String firstName, String lastName, String phoneNumber, String location) {
        super(email, password, firstName, lastName, phoneNumber, location);
    }

	public String getPermitNumber() {
		return permitNumber;
	}

	public void setPermitNumber(String permitNumber) {
		this.permitNumber = permitNumber;
	}

	public String getCarModel() {
		return carModel;
	}

	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}
    
}