<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard | Wasslny</title>
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
                <p class="text-muted">Driver</p>
            </div>

            <nav class="nav flex-column">
                <a class="nav-link active" href="/driver/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a class="nav-link" href="/user/profile/edit">
                    <i class="bi bi-person-gear"></i> Edit Profile
                </a>
                <a class="nav-link" href="/driver/trips/new"
                   <c:if test="${loggedUser.permitNumber == null || loggedUser.carModel == null}">disabled</c:if>>
                    <i class="bi bi-plus-circle"></i> New Trip
                </a>
                <a class="nav-link text-danger" href="/logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content flex-grow-1">
            <c:if test="${loggedUser.permitNumber == null || loggedUser.carModel == null}">
                <div class="alert alert-warning d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <div>
                        Please <a href="/user/profile/edit" class="alert-link">complete your vehicle details</a> before adding trips.
                    </div>
                </div>
            </c:if>

            <!-- Active Trips Section -->
            <div class="card mb-4">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-car-front"></i> Active Trips</h5>
                    <a href="/driver/trips/new" class="btn btn-light btn-sm ${loggedUser.permitNumber == null || loggedUser.carModel == null ? 'disabled' : ''}">
                        <i class="bi bi-plus-lg"></i> Add Trip
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Route</th>
                                    <th>Status</th>
                                    <th>Passengers</th>
                                    <th>Departure</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="trip" items="${trips}">
                                    <c:if test="${trip.status == 'Planned'}">
                                        <tr>
                                            <td>
                                                <i class="bi bi-signpost-2"></i>
                                                <a href="/driver/trips/${trip.id}" class="text-decoration-none">
                                                    ${trip.title}
                                                </a>
                                            </td>
                                            <td>
                                                <small class="text-muted">
                                                    <i class="bi bi-geo-alt"></i> ${trip.startPoint} →
                                                    <i class="bi bi-geo"></i> ${trip.destination}
                                                </small>
                                            </td>
                                            <td>
                                                <span class="badge bg-warning">${trip.status}</span>
                                            </td>
                                            <td>
                                                <i class="bi bi-people"></i> ${trip.currentPassengers}/${trip.maximumPassengers}
                                            </td>
                                            <td>
                                                <i class="bi bi-clock"></i> ${trip.departureTime}
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="/driver/trips/${trip.id}/edit" class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <form method="post" action="/driver/trips/${trip.id}/departed" class="d-inline">
                                                        <button type="submit" class="btn btn-sm btn-outline-success">
                                                            <i class="bi bi-check-lg"></i>
                                                        </button>
                                                    </form>
                                                    <form method="post" action="/driver/trips/${trip.id}/delete" class="d-inline">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty trips}">
                            <div class="text-center py-4">
                                <i class="bi bi-calendar-x h1 text-muted"></i>
                                <p class="text-muted">No active trips found</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Past Trips Section -->
            <div class="card">
                <div class="card-header bg-secondary text-white">
                    <h5 class="mb-0"><i class="bi bi-clock-history"></i> Past Trips</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Route</th>
                                    <th>Status</th>
                                    <th>Passengers</th>
                                    <th>Departure</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="trip" items="${trips}">
                                    <c:if test="${trip.status == 'Departed'}">
                                        <tr>
                                            <td>
                                                <i class="bi bi-signpost-2"></i>
                                                <a href="/driver/trips/${trip.id}" class="text-decoration-none">
                                                    ${trip.title}
                                                </a>
                                            </td>
                                            <td>
                                                <small class="text-muted">
                                                    <i class="bi bi-geo-alt"></i> ${trip.startPoint} →
                                                    <i class="bi bi-geo"></i> ${trip.destination}
                                                </small>
                                            </td>
                                            <td>
                                                <i class="bi bi-check-circle"></i>
                                                <span class="badge bg-success">${trip.status}</span>
                                            </td>
                                            <td>
                                                <i class="bi bi-people"></i> ${trip.currentPassengers}/${trip.maximumPassengers}
                                            </td>
                                            <td>
                                                <i class="bi bi-clock"></i> ${trip.departureTime}
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>