
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wasslny | Welcome</title>
    <link rel="icon" type="image/x-icon" href="/css/imgs/icon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .gradient-custom {
            background: url('/css/imgs/loginbackground.png') no-repeat center center/cover;
        }
        .form-floating > label {
            left: 8px;
        }
        .card {
            backdrop-filter: blur(15px);
            background-color: rgba(255, 255, 255, 0.9);
            border: none;
        }
        .fade-in {
            animation: fadeIn 0.3s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body class="gradient-custom min-vh-100">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand " href="/landingpage">

                <img src="css/imgs/logo.png" alt="logo" class="logo  " width="80" height="80">  
                
                Wasslny
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/landingpage"><i class="bi bi-house-door"></i> Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="/landingpage#aboutUsPage"><i class="bi bi-info-circle"></i> About</a></li>
                    <li class="nav-item"><a class="nav-link" href="/landingpage#contactUsPage"><i class="bi bi-telephone"></i> Contact</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row g-4 justify-content-center align-items-center">
            <!-- Register Form -->
            <div class="col-12 col-lg-6 fade-in">
                <div class="card shadow p-4">
                    <h2 class="text-center mb-4"><i class="bi bi-person-plus"></i> Register</h2>
                    <form:form action="/register" method="post" modelAttribute="newUser" class="needs-validation">
                        <div class="form-floating mb-3">
                            <form:input path="firstName" class="form-control" id="firstName" placeholder="First Name"/>
                            <form:label path="firstName">First Name</form:label>
                            <form:errors path="firstName" class="text-danger"/>
                        </div>
                        <div class="form-floating mb-3">
                            <form:input path="lastName" class="form-control" id="lastName" placeholder="Last Name"/>
                            <form:label path="lastName">Last Name</form:label>
                            <form:errors path="lastName" class="text-danger"/>
                        </div>
                        <div class="form-floating mb-3">
                            <form:input path="email" type="email" class="form-control" id="email" placeholder="Email"/>
                            <form:label path="email">Email</form:label>
                            <form:errors path="email" class="text-danger"/>
                        </div>
                        <div class="form-floating mb-3">
                            <form:input path="phoneNumber" class="form-control" id="phoneNumber" placeholder="Phone"/>
                            <form:label path="phoneNumber">Phone Number</form:label>
                            <form:errors path="phoneNumber" class="text-danger"/>
                        </div>
                        <div class="form-floating mb-3">
                            <form:input path="location" class="form-control" id="location" placeholder="Location"/>
                            <form:label path="location">Location</form:label>
                            <form:errors path="location" class="text-danger"/>
                        </div>
                        <div class="form-floating mb-3">
                            <form:password path="password" class="form-control" id="password" placeholder="Password"/>
                            <form:label path="password">Password</form:label>
                            <form:errors path="password" class="text-danger"/>
                        </div>
                        <div class="form-floating mb-3">
                            <form:password path="confirm" class="form-control" id="confirm" placeholder="Confirm"/>
                            <form:label path="confirm">Confirm Password</form:label>
                            <form:errors path="confirm" class="text-danger"/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label d-block">Account Type</label>

                            <div class="btn-group w-100" role="group">
                                <input type="radio" class="btn-check" name="accountType" id="driver" value="Driver" required>

                                <label class="btn btn-outline-primary" for="driver"><i class="bi bi-car-front"> </i> Driver</label>
                                <input type="radio" class="btn-check" name="accountType" id="passenger" value="Passenger">
                                <label class="btn btn-outline-primary" for="passenger"><i class="bi bi-person"></i> Passenger</label>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning w-100">Register</button>
                    </form:form>
                </div>
            </div>

            <!-- Login Form -->
            <div class="col-12 col-lg-6 fade-in">

                <div class="card shadow p-4">
                    <div class="text-center mb-4">
                        <img src="/css/imgs/icon.png" alt="Logo" width="100" class="d-inline-block align-text-top rounded-circle">
                    </div>

                    <h2 class="text-center mb-4"><i class="bi bi-box-arrow-in-right"></i> Login</h2>
                    <form:form action="/login" method="post" modelAttribute="newLogin">
                        <div class="form-floating mb-3">
                            <form:input path="email" type="email" class="form-control" id="loginEmail" placeholder="Email"/>
                            <form:label path="email">Email</form:label>
                            <form:errors path="email" class="text-danger"/>
                        </div>
                        <div class="form-floating mb-3">
                            <form:password path="password" class="form-control" id="loginPassword" placeholder="Password"/>
                            <form:label path="password">Password</form:label>
                            <form:errors path="password" class="text-danger"/>
                        </div>
                        <button type="submit" class="btn btn-warning w-100 mb-3">Login</button>
                        <div class="text-center">
                            <p class="text-muted">Our Soical Media:</p>
                            <div class="d-flex justify-content-center gap-2">
                                <button type="button" class="btn btn-outline-warning"><i class="bi bi-twitter"></i></button>
                                <button type="button" class="btn btn-outline-warning"><i class="bi bi-facebook"></i></button>
                                <button type="button" class="btn btn-outline-warning"><i class="bi bi-youtube"></i></button>
                                <button type="button" class="btn btn-outline-warning"><i class="bi bi-instagram"></i></button>

                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center text-white py-4">
        <p>&copy; 2024 Wasslny. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>