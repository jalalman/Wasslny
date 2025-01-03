<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trip Details | Wasslny</title>
    <link rel="icon" type="image/x-icon" href="/css/imgs/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .sidebar {
            min-height: 100vh;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .nav-link {
            color: #333;
            padding: 0.8rem 1rem;
            margin: 0.2rem 0;
            border-radius: 0.5rem;
        }
        .nav-link:hover, .nav-link.active {
            background-color: #f8f9fa;
            color: #0d6efd;
        }
        .main-content {
            margin-left: 280px;
            padding: 2rem;
        }
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar bg-white p-4 position-fixed" style="width: 280px;">
            <div class="text-center mb-4">
                <img src="/css/imgs/icon.png" alt="Profile" class="rounded-circle mb-3" width="100">
                <h5 class="mb-0">${loggedUser.firstName} ${loggedUser.lastName}</h5>
                <p class="text-muted">Passenger</p>
            </div>

            <nav class="nav flex-column">
                <a class="nav-link" href="/passenger/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a class="nav-link" href="/user/profile/edit">
                    <i class="bi bi-person-gear"></i> Edit Profile
                </a>
                <a class="nav-link" href="/passenger/trips/search">
                    <i class="bi bi-search"></i> Find Trips
                </a>
                <a class="nav-link text-danger" href="/logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content flex-grow-1">
            <!-- Trip Details Card -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-info-circle"></i> ${trip.title}</h5>
                    <c:if test="${trip.status == 'Planned' && isPassengerPartOfTrip}">
                        <form method="post" action="/passenger/trips/${trip.id}/leave">
                            <input type="hidden" name="tripId" value="${trip.id}">
                            <button type="submit" class="btn btn-light btn-sm">
                                <i class="bi bi-box-arrow-left"></i> Leave Trip
                            </button>
                        </form>
                    </c:if>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <h6 class="text-muted mb-2">Trip Information</h6>
                            <p>
                                <i class="bi bi-person-circle text-primary"></i>
                                <strong>Driver:</strong> ${trip.driver.firstName} ${trip.driver.lastName}
                                <br>
                                <small class="text-muted ms-4">
                                    <i class="bi bi-telephone"></i> ${trip.driver.phoneNumber}
                                </small>
                            </p>
                            <p>
                                <strong>Status:</strong>
                                <span class="badge ${trip.status == 'Planned' ? 'bg-warning' : 'bg-success'}">
                                    ${trip.status}
                                </span>
                            </p>
                            <p><strong>Description:</strong> ${trip.description}</p>
                        </div>
                        <div class="col-md-6">
                            <h6 class="text-muted mb-2">Route & Schedule</h6>
                            <p>
                                <i class="bi bi-geo-alt text-primary"></i> <strong>From:</strong> ${trip.startPoint}
                                <br>
                                <i class="bi bi-geo text-danger"></i> <strong>To:</strong> ${trip.destination}
                            </p>
                            <p>
                                <i class="bi bi-clock"></i> <strong>Departure:</strong> ${trip.departureTime}
                            </p>
                            <p>
                                <i class="bi bi-people"></i> <strong>Capacity:</strong>
                                ${trip.currentPassengers}/${trip.maximumPassengers}
                                <c:if test="${trip.currentPassengers == trip.maximumPassengers}">
                                    <span class="badge bg-danger ms-2">Full</span>
                                </c:if>
                            </p>
                        </div>
                    </div>

                    <!-- Join Trip Form -->
                    <c:if test="${not isPassengerPartOfTrip && trip.status == 'Planned' && trip.currentPassengers < trip.maximumPassengers}">
                        <div class="mt-4">
                            <h6 class="text-muted mb-3">Join This Trip</h6>
                            <form method="post" action="/passenger/trips/${trip.id}/join">
                                <input type="hidden" name="tripId" value="${trip.id}">
                                <div class="row g-3">
                                    <div class="col-md-8">
                                        <div class="form-floating">
                                            <textarea class="form-control" id="passengerNotes" name="passengerNotes"
                                                style="height: 100px" placeholder="Add any notes..."></textarea>
                                            <label for="passengerNotes">Notes (Optional)</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-floating">
                                            <input type="number" class="form-control" id="passengerCount"
                                                name="passengerCount" min="1"
                                                max="${trip.maximumPassengers - trip.currentPassengers}"
                                                value="1" required>
                                            <label for="passengerCount">Number of Seats</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle"></i> Join Trip
                                    </button>
                                </div>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>