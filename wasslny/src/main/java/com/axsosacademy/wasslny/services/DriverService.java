package com.axsosacademy.wasslny.services;

import com.axsosacademy.wasslny.models.Driver;
import com.axsosacademy.wasslny.models.Trip;
import com.axsosacademy.wasslny.models.User;
import com.axsosacademy.wasslny.repositories.DriverRepository;
import com.axsosacademy.wasslny.repositories.UserRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class DriverService {
    private final UserRepository userRepository;
    private final DriverRepository driverRepository;

    public DriverService(UserRepository userRepository, DriverRepository driverRepository) {
        this.userRepository = userRepository;
        this.driverRepository = driverRepository;
    }
    
    public Driver findById(Long id) {
    	Optional<Driver> optionalDriver = driverRepository.findById(id);
        if(optionalDriver.isPresent()) {
            return optionalDriver.get();
        } else {
            return null;
        }
    }
    
    public void updateVehicleDetails(String permitNumber, String carModel, Driver originalDriver) {
        Optional<User> userOpt = userRepository.findById(originalDriver.getId());
        if (userOpt.isPresent() && userOpt.get() instanceof Driver) {
            Driver driver = (Driver) userOpt.get();
            if (permitNumber != null && !permitNumber.trim().isEmpty()) {
                driver.setPermitNumber(permitNumber.trim());
            }
            
            if (carModel != null && !carModel.trim().isEmpty()) {
                driver.setCarModel(carModel.trim());
            }
            
            driverRepository.save(driver);
        }
    }
}
