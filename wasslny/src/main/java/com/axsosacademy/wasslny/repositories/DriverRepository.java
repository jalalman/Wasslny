package com.axsosacademy.wasslny.repositories;

import com.axsosacademy.wasslny.models.Driver;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DriverRepository extends CrudRepository<Driver, Long> {
    Optional<Driver> findByEmail(String email);
}