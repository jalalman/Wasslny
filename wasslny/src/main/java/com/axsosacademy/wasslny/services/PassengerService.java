package com.axsosacademy.wasslny.services;

import com.axsosacademy.wasslny.models.Passenger;
import com.axsosacademy.wasslny.repositories.PassengerRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PassengerService {
    private final PassengerRepository passengerRepository;

    public PassengerService(PassengerRepository passengerRepository) {
        this.passengerRepository = passengerRepository;
    }

    public Passenger findById(Long id) {
    	Optional<Passenger> optionalPassenger = passengerRepository.findById(id);
        if(optionalPassenger.isPresent()) {
            return optionalPassenger.get();
        } else {
            return null;
        }
    }
}
