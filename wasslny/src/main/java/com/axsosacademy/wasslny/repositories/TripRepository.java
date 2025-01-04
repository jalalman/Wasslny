package com.axsosacademy.wasslny.repositories;

import com.axsosacademy.wasslny.models.Trip;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface TripRepository extends CrudRepository<Trip, Long> {
	Optional<Trip> findByTitle(String title);
	List<Trip> findAll();
	List<Trip> findByDriverId(Long driverId);
	List<Trip> findByPassengers_Id(Long passengerId);

	@Query("SELECT t FROM Trip t WHERE " +
           "(:startPoint IS NULL OR t.startPoint = :startPoint) AND " +
           "(:destination IS NULL OR t.destination = :destination) AND " +
           "(:departureTime IS NULL OR CAST(t.departureTime AS date) = CAST(:departureTime AS date)) AND " +
           "t.status != 'Departed' AND " +
           "t.maximumPassengers - t.currentPassengers >= :passengerCount")
    List<Trip> searchTrips(
        @Param("startPoint") String startPoint,
        @Param("destination") String destination,
        @Param("departureTime") LocalDate departureTime,
        @Param("passengerCount") int passengerCount
    );

}