package com.axsosacademy.wasslny.services;

import com.axsosacademy.wasslny.models.Driver;
import com.axsosacademy.wasslny.models.LoginUser;
import com.axsosacademy.wasslny.models.Passenger;
import com.axsosacademy.wasslny.models.RegistrationForm;
import com.axsosacademy.wasslny.models.User;
import com.axsosacademy.wasslny.repositories.DriverRepository;
import com.axsosacademy.wasslny.repositories.PassengerRepository;
import com.axsosacademy.wasslny.repositories.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import java.util.Optional;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PassengerRepository passengerRepository;
    private final DriverRepository driverRepository;

    public UserService(UserRepository userRepository, PassengerRepository passengerRepository, DriverRepository driverRepository) {
        this.userRepository = userRepository;
        this.passengerRepository = passengerRepository;
        this.driverRepository = driverRepository;
    }

    public User register(RegistrationForm registrationForm, BindingResult bindingResult) {
        validateRegistration(registrationForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return null;
        }

        User newUser;
        switch (registrationForm.getAccountType()) {
            case "Driver":
                newUser = new Driver();
                break;
            case "Passenger":
                newUser = new Passenger();
                break;
            default:
                return null;
        }
        
        newUser.setFirstName(registrationForm.getFirstName());
        newUser.setLastName(registrationForm.getLastName());
        newUser.setEmail(registrationForm.getEmail());
        newUser.setPhoneNumber(registrationForm.getPhoneNumber());
        newUser.setLocation(registrationForm.getLocation());

        String hashedPassword = BCrypt.hashpw(registrationForm.getPassword(), BCrypt.gensalt());
        newUser.setPassword(hashedPassword);

        return userRepository.save(newUser);
    }



    public User login(LoginUser loginUser, BindingResult bindingResult) {
        Optional<User> existingUser = userRepository.findByEmail(loginUser.getEmail());

        if (existingUser.isEmpty()) {
            bindingResult.rejectValue("email", "NotFound", "No account with this email was found.");
            return null;
        }

        User user = existingUser.get();

        if (!BCrypt.checkpw(loginUser.getPassword(), user.getPassword())) {
            bindingResult.rejectValue("password", "Invalid", "Incorrect password.");
        }

        if (bindingResult.hasErrors()) {
            return null;
        }

        return user;
    }

    public void validateRegistration(RegistrationForm registrationForm, BindingResult bindingResult) {
        Optional<User> existingUser = userRepository.findByEmail(registrationForm.getEmail());
        if (existingUser.isPresent()) {
            bindingResult.rejectValue("email", "EmailExists", "This email is already registered.");
        }

        if (!registrationForm.isPasswordMatch()) {
            bindingResult.rejectValue("confirm", "Matches", "Passwords do not match.");
        }
    }

    public boolean checkPassword(Long userId, String currentPassword) {
        Optional<User> optionalUser = userRepository.findById(userId);
        if (optionalUser.isEmpty()) {
            return false;
        }

        User user = optionalUser.get();
        return BCrypt.checkpw(currentPassword, user.getPassword());
    }

    public void updateUserProfile(User user) {
        Optional<User> existingUser = userRepository.findById(user.getId());
        if (existingUser.isPresent()) {
            User currentUser = existingUser.get();
            currentUser.setFirstName(user.getFirstName());
            currentUser.setLastName(user.getLastName());
            currentUser.setEmail(user.getEmail());
            currentUser.setPhoneNumber(user.getPhoneNumber());
            currentUser.setLocation(user.getLocation());
            
            if (currentUser instanceof Driver) {
                driverRepository.save((Driver) currentUser);
            } else if (currentUser instanceof Passenger) {
                passengerRepository.save((Passenger) currentUser);
            }
        }
    }
    
    public void updatePassword(Long userId, String newPassword) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            user.setPassword(hashedPassword);
            userRepository.save(user);
        }
    }

}
