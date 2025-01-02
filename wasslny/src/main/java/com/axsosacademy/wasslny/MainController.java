package com.axsosacademy.wasslny;

import com.axsosacademy.wasslny.models.Driver;
import com.axsosacademy.wasslny.models.LoginUser;
import com.axsosacademy.wasslny.models.Passenger;
import com.axsosacademy.wasslny.models.PasswordForm;
import com.axsosacademy.wasslny.models.RegistrationForm;
import com.axsosacademy.wasslny.models.User;
import com.axsosacademy.wasslny.models.UserProfileUpdateDTO;
import com.axsosacademy.wasslny.services.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MainController {

    private final UserService userService;
    public MainController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("newUser", new RegistrationForm());
        model.addAttribute("newLogin", new LoginUser());
        return "index.jsp";
    }

    @GetMapping("/home")
    public String home(HttpSession session) {
        if (session.getAttribute("loggedUser") != null) {
            User user = (User) session.getAttribute("loggedUser");
            if (user instanceof Driver) {
                return "redirect:/driver/dashboard";
            } else if (user instanceof Passenger) {
                return "redirect:/passenger/dashboard";
            }
        }
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") RegistrationForm registrationForm, BindingResult bindingResult,
                           Model model, HttpSession session) {

        // Validate registration including password match
        userService.validateRegistration(registrationForm, bindingResult);

        if (bindingResult.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "index.jsp";
        }

        User loggedUser = userService.register(registrationForm, bindingResult);

        if (bindingResult.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "index.jsp";
        }

        session.setAttribute("loggedUser", loggedUser);

        if (loggedUser instanceof Driver) {
            return "redirect:/driver/dashboard";
        } else if (loggedUser instanceof Passenger) {
            return "redirect:/passenger/dashboard";
        }

        return "redirect:/";
    }


    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult bindingResult,
            HttpSession session, Model model) {
        Object loggedInUser = userService.login(newLogin, bindingResult);

        if (bindingResult.hasErrors()) {
            model.addAttribute("newUser", new RegistrationForm());
            return "index.jsp";
        } else {
            session.setAttribute("loggedUser", loggedInUser);
            if (loggedInUser instanceof Driver) {
                return "redirect:/driver/dashboard";
            } else {
                return "redirect:/passenger/dashboard";
            }
        }
    }

    @GetMapping("/user/profile/edit")
    public String viewEditProfile(Model model, HttpSession session) {
        if (session.getAttribute("loggedUser") == null) {
            return "redirect:/";
        }

        User loggedUser = (User) session.getAttribute("loggedUser");

        UserProfileUpdateDTO profileForm = new UserProfileUpdateDTO();
        profileForm.setFirstName(loggedUser.getFirstName());
        profileForm.setLastName(loggedUser.getLastName());
        profileForm.setEmail(loggedUser.getEmail());
        profileForm.setPhoneNumber(loggedUser.getPhoneNumber());
        profileForm.setLocation(loggedUser.getLocation());

        model.addAttribute("profileForm", profileForm);
        model.addAttribute("passwordForm", new PasswordForm());
        model.addAttribute("loggedUser", loggedUser);

        if (loggedUser instanceof Driver) {
            return "driver_edit_profile.jsp";
        } else if (loggedUser instanceof Passenger) {
            return "passenger_edit_profile.jsp";
        }

        return "error.jsp";
    }


    @PostMapping("/user/profile/edit/driver")
    public String updateDriverProfile(@Valid @ModelAttribute("profileForm") UserProfileUpdateDTO profileForm, 
                                    BindingResult result, HttpSession session, Model model) {
        if (result.hasErrors()) {
        	model.addAttribute("passwordForm", new PasswordForm());
            return "driver_edit_profile.jsp";
        }

        Driver originalDriver = (Driver) session.getAttribute("loggedUser");
        originalDriver.setFirstName(profileForm.getFirstName());
        originalDriver.setLastName(profileForm.getLastName());
        originalDriver.setEmail(profileForm.getEmail());
        originalDriver.setPhoneNumber(profileForm.getPhoneNumber());
        originalDriver.setLocation(profileForm.getLocation());
        
        try {
            userService.updateUserProfile(originalDriver);
            session.setAttribute("loggedUser", originalDriver);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "An error occurred while updating your profile.");
            return "error.jsp";
        }

        return "redirect:/driver/dashboard";
    }

    @PostMapping("/user/profile/edit/passenger")
    public String updatePassengerProfile(@Valid @ModelAttribute("profileForm") UserProfileUpdateDTO profileForm, 
                                    BindingResult result, HttpSession session, Model model) {
        if (result.hasErrors()) {
        	model.addAttribute("passwordForm", new PasswordForm());
            return "passenger_edit_profile.jsp";
        }

        Passenger originalPassenger = (Passenger) session.getAttribute("loggedUser");
        originalPassenger.setFirstName(profileForm.getFirstName());
        originalPassenger.setLastName(profileForm.getLastName());
        originalPassenger.setEmail(profileForm.getEmail());
        originalPassenger.setPhoneNumber(profileForm.getPhoneNumber());
        originalPassenger.setLocation(profileForm.getLocation());
        
        try {
            userService.updateUserProfile(originalPassenger);
            session.setAttribute("loggedUser", originalPassenger);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "An error occurred while updating your profile.");
            return "error.jsp";
        }

        return "redirect:/passenger/dashboard";
    }
    
    @PostMapping("/user/password/update")
    public String updatePassword(@Valid @ModelAttribute("passwordForm") PasswordForm passwordForm,
                               BindingResult result, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        
        // Verify current password
        if (!userService.checkPassword(loggedUser.getId(), passwordForm.getCurrentPassword())) {
            result.rejectValue("currentPassword", "Invalid", "Current password is incorrect");
        }
        
        // Check if new password matches confirmation
        if (!passwordForm.getNewPassword().equals(passwordForm.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "Matches", "New passwords do not match");
        }
        
        if (result.hasErrors()) {
            // Repopulate the profile form
            UserProfileUpdateDTO profileForm = new UserProfileUpdateDTO();
            profileForm.setFirstName(loggedUser.getFirstName());
            profileForm.setLastName(loggedUser.getLastName());
            profileForm.setEmail(loggedUser.getEmail());
            profileForm.setPhoneNumber(loggedUser.getPhoneNumber());
            profileForm.setLocation(loggedUser.getLocation());
            
            model.addAttribute("profileForm", profileForm);
            model.addAttribute("loggedUser", loggedUser);
            
            // Return to the appropriate edit profile page
            if (loggedUser instanceof Driver) {
                return "driver_edit_profile.jsp";
            } else {
                return "passenger_edit_profile.jsp";
            }
        }

        // Update password
        try {
            userService.updatePassword(loggedUser.getId(), passwordForm.getNewPassword());
            redirectAttributes.addFlashAttribute("successMessage", "Password updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update password. Please try again.");
        }

        // Redirect back to profile edit page
        String userType = (loggedUser instanceof Driver) ? "driver" : "passenger";
        return "redirect:/user/profile/edit";
    }

}