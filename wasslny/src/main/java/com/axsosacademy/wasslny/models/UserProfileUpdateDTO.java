package com.axsosacademy.wasslny.models;

import jakarta.validation.constraints.*;

public class UserProfileUpdateDTO {
    @NotEmpty(message = "First name is required.")
    @Size(min = 3, max = 30, message = "First name must be between 3 and 30 characters.")
    private String firstName;

    @NotEmpty(message = "Last name is required.")
    @Size(min = 3, max = 30, message = "Last name must be between 3 and 30 characters.")
    private String lastName;

    @NotNull(message="Email cannot be null.")
    @NotEmpty(message = "Email is required.")
    @Email(message = "The email address you've entered is invalid.")
    private String email;
    
    @NotEmpty(message = "Phone number is required.")
    @Size(min = 10, max = 10, message = "Phone number can only be 10 characters.")
    private String phoneNumber;
    
    @NotEmpty(message = "Location is required.")
    @Size(min = 3, max = 30, message = "Location must be between 3 and 30 characters.")
    private String location;

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
    
}