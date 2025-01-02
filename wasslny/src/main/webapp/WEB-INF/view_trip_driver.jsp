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
                <p class="text-muted">Driver</p>
            </div>

            <nav class="nav flex-column">
                <a class="nav-link" href="/driver/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a class="nav-link" href="/user/profile/edit">
                    <i class="bi bi-person-gear"></i> Edit Profile
                </a>
                <a class="nav-link" href="/driver/trips/new">
                    <i class="bi bi-plus-circle"></i> New Trip
                </a>
                <a class="nav-link text-danger" href="/logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content flex-grow-1">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-info-circle"></i> Trip Details</h5>
                    <c:if test="${trip.status == 'Planned'}">
                        <div>
                            <form method="post" action="/driver/trips/${trip.id}/delete" class="d-inline me-2">
                                <input type="hidden" name="tripId" value="${trip.id}">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="bi bi-trash"></i> Delete
                                </button>
                            </form>
                            <form method="post" action="/driver/trips/${trip.id}/departed" class="d-inline me-2">
                                <input type="hidden" name="tripId" value="${trip.id}">
                                <button type="submit" class="btn btn-light btn-sm">
                                    <i class="bi bi-arrow-right-circle"></i> Mark as Departed
                                </button>
                            </form>
                            <a href="/driver/trips/${trip.id}/edit" class="btn btn-light btn-sm">
                                <i class="bi bi-pencil"></i> Edit
                            </a>
                        </div>
                    </c:if>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <h6 class="text-muted mb-2">Trip Information</h6>
                            <p><strong>Title:</strong> ${trip.title}</p>
                            <p><strong>Status:</strong>
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
                </div>
            </div>

            <!-- Passengers List -->
            <div class="card shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0"><i class="bi bi-people"></i> Passengers</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Passenger Name</th>
                                    <th scope="col">Seats Reserved</th>
                                    <th scope="col">Phone Number</th>
                                    <th scope="col">Notes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="passenger" items="${trip.passengers}" varStatus="status">
                                    <tr>
                                        <td>${status.count}</td>
                                        <td>
                                            <i class="bi bi-person"></i> ${passenger.firstName} ${passenger.lastName}
                                        </td>
                                        <td>${trip.passengerCountMap[passenger.id]}</td>
                                        <td>${passenger.phoneNumber}</td>
                                        <td>
                                            <small class="text-muted">
                                                ${trip.passengerNotes[passenger.id] != null ? trip.passengerNotes[passenger.id] : "No notes available"}
                                            </small>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty trip.passengers}">
                            <div class="text-center py-4">
                                <i class="bi bi-people h1 text-muted"></i>
                                <p class="text-muted">No passengers have joined this trip yet</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>