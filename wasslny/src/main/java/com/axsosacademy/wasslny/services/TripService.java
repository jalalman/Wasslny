package com.axsosacademy.wasslny.services;

import com.axsosacademy.wasslny.models.Passenger;
import com.axsosacademy.wasslny.models.Trip;
import com.axsosacademy.wasslny.repositories.PassengerRepository;
import com.axsosacademy.wasslny.repositories.TripRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class TripService {

    private final TripRepository tripRepository;
    private final PassengerRepository passengerRepository;

    public TripService(TripRepository tripRepository, PassengerRepository passengerRepository) {
        this.tripRepository = tripRepository;
        this.passengerRepository = passengerRepository;
    }

    public Trip createTrip(Trip newTrip) {
        return tripRepository.save(newTrip);
    }

    public List<Trip> findTripsByDriver(Long driverId) {
        return tripRepository.findByDriverId(driverId);
    }
    public List<Trip> findTripsByPassenger(Long passengerId) {
        return tripRepository.findByPassengers_Id(passengerId);
    }

    public Trip findById(Long id) {
    	Optional<Trip> optionalTrip = tripRepository.findById(id);
        if(optionalTrip.isPresent()) {
            return optionalTrip.get();
        } else {
            return null;
        }
    }

    public void joinTrip(Long tripId, Long passengerId, String passengerNotes, int passengerCount) {
        Trip trip = tripRepository.findById(tripId).get();
        Passenger passenger = passengerRepository.findById(passengerId).get();
        if (trip.hasAvailableCapacity(passengerCount)) {
            trip.getPassengers().add(passenger);
            trip.setCurrentPassengers(trip.getCurrentPassengers() + passengerCount);
            trip.getPassengerCountMap().put(passengerId, passengerCount); // Store the passenger count
            if (passengerNotes != null && !passengerNotes.trim().isEmpty()) {
                trip.getPassengerNotes().put(passengerId, passengerNotes.trim());
            }
            tripRepository.save(trip);
        } else {
            throw new RuntimeException("Not enough capacity for the requested number of passengers.");
        }
    }


    public void leaveTrip(Long tripId, Long passengerId) {
        Trip trip = tripRepository.findById(tripId).get();
        Passenger passenger = passengerRepository.findById(passengerId).get();
        int passengerCount = trip.getPassengerCountMap().getOrDefault(passengerId, 1);
        trip.getPassengers().remove(passenger);
        trip.setCurrentPassengers(trip.getCurrentPassengers() - passengerCount);
        trip.getPassengerCountMap().remove(passengerId);
        tripRepository.save(trip);
    }


    public List<Trip> searchTrips(String startPoint, String destination, LocalDateTime departureTime, int passengerCount) {
        return tripRepository.searchTrips(
            startPoint.trim().isEmpty() ? null : startPoint,
            destination.trim().isEmpty() ? null : destination,
            departureTime,
            passengerCount
        );
    }

    public void updateTripStatusToDeparted(Long id) {
    	Optional<Trip> optionalTrip = tripRepository.findById(id);
        if(optionalTrip.isPresent()) {
            Trip trip = optionalTrip.get();
            trip.setStatus("Departed");
            tripRepository.save(trip);
        }
    }

    public void deleteTrip(Long id) {
        tripRepository.deleteById(id);
    }

    public List<Trip> findAll() {
        return tripRepository.findAll();
    }

    public void updateTrip(Trip Trip) {
    	tripRepository.save(Trip);
    }

	public boolean isPassengerPartOfTrip(Long tripId, Long passengerId) {
		Trip trip = tripRepository.findById(tripId).get();
		Passenger passenger = passengerRepository.findById(passengerId).get();
		return trip.getPassengers().contains(passenger);
	}
}