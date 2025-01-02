package com.axsosacademy.wasslny.repositories;

import com.axsosacademy.wasslny.models.Passenger;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PassengerRepository extends CrudRepository<Passenger, Long> {
    Optional<Passenger> findByEmail(String email);
}