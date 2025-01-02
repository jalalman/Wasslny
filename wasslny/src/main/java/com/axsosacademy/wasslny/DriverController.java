package com.axsosacademy.wasslny;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.axsosacademy.wasslny.models.Driver;

import com.axsosacademy.wasslny.models.Trip;
import com.axsosacademy.wasslny.services.DriverService;
import com.axsosacademy.wasslny.services.TripService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class DriverController {

	@Autowired
	TripService tripService;
	@Autowired
	DriverService driverService;

    @GetMapping("/driver/dashboard")
    public String driverDashboard(HttpSession session, Model model) {
        if (session.getAttribute("loggedUser") != null && session.getAttribute("loggedUser") instanceof Driver) {
        	Driver driver = (Driver) session.getAttribute("loggedUser");
            model.addAttribute("trips", tripService.findTripsByDriver(driver.getId()));
            return "driver_dashboard.jsp";
        }
        return "redirect:/";
    }

    @GetMapping("/driver/trips/new")
    public String newTrip(Model model,HttpSession session) {
    	if (session.getAttribute("loggedUser") == null) {
            return "redirect:/";
        }
        model.addAttribute("trip", new Trip());
        return "new_trip.jsp";
    }

    @GetMapping("/driver/trips/{id}")
    public String viewTrip(@PathVariable Long id, Model model, HttpSession session) {
    	if (session.getAttribute("loggedUser") == null) {
            return "redirect:/";
        }
        Trip trip = tripService.findById(id);
        model.addAttribute("trip", trip);
        return "view_trip_driver.jsp";
    }



    @PostMapping("/driver/trips/new")
    public String createTrip(@Valid @ModelAttribute("trip") Trip trip, BindingResult bindingResult,Model model ,HttpSession session) {
        try {
            // Set required fields
            trip.setDriver((Driver)session.getAttribute("loggedUser"));
            trip.setStatus("Planned"); // Set initial status
            trip.setCurrentPassengers(0); // Initialize passengers

            // Debug logging
            System.out.println("Creating trip: " + trip.toString());

            Trip savedTrip = tripService.createTrip(trip);
            System.out.println("Trip created with ID: " + savedTrip.getId());

            return "redirect:/driver/dashboard";
        } catch (Exception e) {
            System.out.println("Error creating trip: " + e.getMessage());
            model.addAttribute("errorMessage", "Error creating trip");
            return "new_trip.jsp";
        }
    }

    @PostMapping("/driver/trips/{id}/delete")
    public String deleteTrip(@PathVariable Long id) {
    	tripService.deleteTrip(id);
        return "redirect:/driver/dashboard";
    }

    @PostMapping("/driver/trips/{id}/departed")
    public String updateTripStatusToDeparted(@PathVariable Long id) {
    	tripService.updateTripStatusToDeparted(id);
        return "redirect:/driver/dashboard";
    }

    @GetMapping("/driver/trips/{id}/edit")
    public String viewEditTrip(@PathVariable Long id, Model model, HttpSession session) {
    	if (session.getAttribute("loggedUser") == null) {
            return "redirect:/";
        }
        Trip trip = tripService.findById(id);
        model.addAttribute("trip", trip);
        return "edit_trip.jsp";
    }

    @PostMapping("/driver/trips/{id}/edit")
    public String updateTrip(@Valid @ModelAttribute("trip") Trip trip, BindingResult result, @PathVariable Long id, HttpSession session) {
        if (result.hasErrors()) {
            return "edit_trip.jsp";
        } else {
        	trip.setDriver((Driver)session.getAttribute("loggedUser"));
            tripService.updateTrip(trip);
            return "redirect:/driver/trips/{id}";
        }
    }

    @PostMapping("/driver/vehicleDetails/update")
    public String updateVehicleDetails(HttpSession session,
    		@RequestParam(value="permitNumber", required=false) String permitNumber,
            @RequestParam(value="carModel", required=false) String carModel,
            @RequestParam(value="driverId", required=false) Long driverId) {
    	Driver originalDriver = (Driver) session.getAttribute("loggedUser");
        driverService.updateVehicleDetails(permitNumber, carModel, originalDriver);
        session.setAttribute("loggedUser", driverService.findById(driverId));
    	return "redirect:/driver/dashboard";
    }
}
