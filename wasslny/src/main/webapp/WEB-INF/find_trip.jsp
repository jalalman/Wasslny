<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Trips | Wasslny</title>
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
                <a class="nav-link active" href="/passenger/find/trips">
                    <i class="bi bi-search"></i> Find Trips
                </a>



                <a class="nav-link text-danger" href="/logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content flex-grow-1">
            <!-- Search Form -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-search"></i> Search Trips</h5>
                </div>
                <div class="card-body">
                    <form action="/passenger/trips/find" method="get">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <select name="startingPoint" class="form-select" id="startingPoint">
                                        <option value="">Select starting point</option>
                                        <option value="Ramallah">Ramallah</option>
                                        <option value="Nablus">Nablus</option>
                                        <option value="Bethlehem">Bethlehem</option>
                                        <option value="Qalqilya">Qalqilya</option>
                                        <option value="Jerusalem">Jerusalem</option>
                                        <option value="Hebron">Hebron</option>
                                        <option value="Jenin">Jenin</option>
                                        <option value="Tulkarm">Tulkarm</option>
                                        <option value="Salfit">Salfit</option>
                                        <option value="Tubas">Tubas</option>
                                        <option value="Jericho">Jericho</option>
                                        <option value="Gaza City">Gaza City</option>
                                        <option value="Khan Younis">Khan Younis</option>
                                        <option value="Rafah">Rafah</option>
                                        <option value="Deir al-Balah">Deir al-Balah</option>
                                        <option value="Beit Lahia">Beit Lahia</option>
                                    </select>
                                    <label for="startingPoint">From</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <select name="destination" class="form-select" id="destination">
                                        <option value="">Select destination</option>
                                        <option value="Ramallah">Ramallah</option>
                                        <option value="Nablus">Nablus</option>
                                        <option value="Bethlehem">Bethlehem</option>
                                        <option value="Qalqilya">Qalqilya</option>
                                        <option value="Jerusalem">Jerusalem</option>
                                        <option value="Hebron">Hebron</option>
                                        <option value="Jenin">Jenin</option>
                                        <option value="Tulkarm">Tulkarm</option>
                                        <option value="Salfit">Salfit</option>
                                        <option value="Tubas">Tubas</option>
                                        <option value="Jericho">Jericho</option>
                                        <option value="Gaza City">Gaza City</option>
                                        <option value="Khan Younis">Khan Younis</option>
                                        <option value="Rafah">Rafah</option>
                                        <option value="Deir al-Balah">Deir al-Balah</option>
                                        <option value="Beit Lahia">Beit Lahia</option>
                                    </select>
                                    <label for="destination">To</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="datetime-local" class="form-control" id="departureTime" name="departureTime">
                                    <label for="departureTime">Departure Time</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="number" class="form-control" id="passengerCount" name="passengerCount" min="1" value="1">
                                    <label for="passengerCount">Number of Passengers</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-search"></i> Search Trips
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Search Results -->
            <div class="card shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0"><i class="bi bi-list-ul"></i> Available Trips</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Route</th>
                                    <th>Driver</th>
                                    <th>Departure</th>
                                    <th>Available Seats</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="trip" items="${trips}">
                                    <c:if test="${not trip.getPassengers().contains(passenger)}">
                                    <tr>
                                        <td>

                                                ${trip.title}

                                        </td>
                                        <td>
                                            <small class="text-muted">
                                                <i class="bi bi-geo-alt"></i> ${trip.startPoint} →
                                                <i class="bi bi-geo"></i> ${trip.destination}
                                            </small>
                                        </td>
                                        <td>${trip.driver.firstName} ${trip.driver.lastName}</td>
                                        <td>
                                            <i class="bi bi-clock"></i> ${trip.departureTime}
                                        </td>
                                        <td>
                                            <i class="bi bi-people"></i> ${trip.maximumPassengers - trip.currentPassengers} available
                                        </td>
                                        <td>
                                            <form method="post" action="/passenger/trips/${trip.id}/join">
                                                <div class="mb-2">
                                                    <input type="text" class="form-control form-control-sm"
                                                        name="passengerNotes"
                                                        placeholder="Add any notes (optional)">
                                                </div>
                                                <div class="mb-2">
                                                    <input type="number" class="form-control form-control-sm"
                                                        name="passengerCount"
                                                        min="1"
                                                        max="${trip.maximumPassengers - trip.currentPassengers}"
                                                        value="1"
                                                        required
                                                        placeholder="Number of seats">
                                                </div>
                                                <button type="submit" class="btn btn-success btn-sm w-100">
                                                    <i class="bi bi-plus-circle"></i> Join Trip
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty trips}">
                            <div class="text-center py-4">
                                <i class="bi bi-search h1 text-muted"></i>
                                <p class="text-muted">No trips found matching your criteria</p>
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