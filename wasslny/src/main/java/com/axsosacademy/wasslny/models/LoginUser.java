package com.axsosacademy.wasslny.models;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

public class LoginUser {

    @NotEmpty(message = "Please fill in your email address.")
    @Email(message = "The email address you've entered is invalid.")
    private String email;

    @NotEmpty(message="Please fill in your password.")
    @Size(min=8, max=128, message="Password must be between 8 and 128 characters.")
    private String password;

    public LoginUser() {
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}