package com.axsosacademy.wasslny;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.axsosacademy.wasslny.models.Driver;
import com.axsosacademy.wasslny.models.Passenger;
import com.axsosacademy.wasslny.models.Trip;
import com.axsosacademy.wasslny.models.User;
import com.axsosacademy.wasslny.services.TripService;
import com.axsosacademy.wasslny.services.PassengerService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PassengerController {
    @Autowired
	TripService tripService;

    @Autowired
    PassengerService passengerService;

    @GetMapping("/passenger/dashboard")
    public String passengerDashboard(HttpSession session, Model model) {
        if (session.getAttribute("loggedUser") != null && session.getAttribute("loggedUser") instanceof Passenger) {
        	Passenger passenger = (Passenger) session.getAttribute("loggedUser");
            model.addAttribute("trips", tripService.findTripsByPassenger(passenger.getId()));
            return "passenger_dashboard.jsp";
        }
        return "redirect:/";
    }

    @GetMapping("/passenger/find/trips")
    public String findTripsView(HttpSession session, Model model) {
        if (session.getAttribute("loggedUser") != null && session.getAttribute("loggedUser") instanceof Passenger) {
            return "find_trip.jsp";
        }
        return "redirect:/";
    }

    @GetMapping("/passenger/trips/find")
    public String findTrips(HttpSession session,
                            @RequestParam(value = "startingPoint", required = false) String startingPoint,
                            @RequestParam(value = "destination", required = false) String destination,
                            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime departureTime,
                            @RequestParam(value = "passengerCount", required = false, defaultValue = "1") int passengerCount,
                            Model model) {
        if (session.getAttribute("loggedUser") == null) {
            return "redirect:/";
        }
        List<Trip> searchResults = tripService.searchTrips(
            startingPoint != null ? startingPoint : "",
            destination != null ? destination : "",
            departureTime,
            passengerCount
        );
        Passenger passenger = (Passenger) session.getAttribute("loggedUser");
        Long passengerId = passenger.getId();
        model.addAttribute("passenger", passengerService.findById(passengerId));
        model.addAttribute("trips", searchResults);
        return "find_trip.jsp";
    }


    @GetMapping("/passenger/trips/{id}")
    public String viewPassengerTrip(@PathVariable Long id, Model model, HttpSession session) {
    	if (session.getAttribute("loggedUser") == null) {
            return "redirect:/";
        }
        Trip trip = tripService.findById(id);
        Passenger passenger = (Passenger)session.getAttribute("loggedUser");
        model.addAttribute("trip", trip);
        model.addAttribute("isPassengerPartOfTrip", tripService.isPassengerPartOfTrip(trip.getId(), passenger.getId()));
        return "view_trip_passenger.jsp";
    }

    @PostMapping("/passenger/trips/{tripId}/join")
    public String joinTrip(@PathVariable Long tripId, HttpSession session,
                           @RequestParam(value = "passengerNotes") String passengerNotes,
                           @RequestParam(value = "passengerCount") int passengerCount) {
        Passenger passenger = (Passenger)session.getAttribute("loggedUser");
        tripService.joinTrip(tripId, passenger.getId(), passengerNotes, passengerCount);
        return "redirect:/passenger/dashboard";
    }

    @PostMapping("/passenger/trips/{tripId}/leave")
    public String leaveTrip(@PathVariable Long tripId, HttpSession session) {
    	Passenger passenger = (Passenger)session.getAttribute("loggedUser");
		tripService.leaveTrip(tripId,passenger.getId());
        return "redirect:/passenger/dashboard";
    }
}
