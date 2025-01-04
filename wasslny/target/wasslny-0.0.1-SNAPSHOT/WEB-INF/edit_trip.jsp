<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Trip | Wasslny</title>
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
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-pencil"></i> Edit Trip</h5>
                    <form method="post" action="/driver/trips/${trip.id}/delete" class="d-inline">
                        <input type="hidden" name="tripId" value="${trip.id}">
                        <button type="submit" class="btn btn-danger btn-sm">
                            <i class="bi bi-trash"></i> Delete Trip
                        </button>
                    </form>
                </div>
                <div class="card-body">
                    <form:form method="post" action="/driver/trips/${trip.getId()}/edit" modelAttribute="trip">
                        <form:hidden path="id"/>
                        <form:hidden path="status" value="${trip.status}"/>

                        <div class="row g-3">
                            <div class="col-12">
                                <div class="form-floating">
                                    <form:input path="title" class="form-control" id="title" placeholder="Title" value="${trip.title}"/>
                                    <form:label path="title">Title</form:label>
                                    <form:errors path="title" class="text-danger" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:select path="startPoint" class="form-select" id="startPoint">
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
                                    </form:select>
                                    <form:label path="startPoint">Start Point</form:label>
                                    <form:errors path="startPoint" class="text-danger" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:select path="destination" class="form-select" id="destination">
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
                                    </form:select>
                                    <form:label path="destination">Destination</form:label>
                                    <form:errors path="destination" class="text-danger" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:input path="departureTime" type="datetime-local" class="form-control" id="departureTime" placeholder="Departure Time"/>
                                    <form:label path="departureTime">Departure Time</form:label>
                                    <form:errors path="departureTime" class="text-danger" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:input path="maximumPassengers" type="number" step="1" class="form-control" id="maximumPassengers" placeholder="Maximum Passengers"/>
                                    <form:label path="maximumPassengers">Maximum Passengers</form:label>
                                    <form:errors path="maximumPassengers" class="text-danger" />
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="form-floating">
                                    <form:textarea path="description" class="form-control" id="description" placeholder="Description" style="height: 100px"/>
                                    <form:label path="description">Description</form:label>
                                    <form:errors path="description" class="text-danger" />
                                </div>
                            </div>
                        </div>

                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> Save Changes
                            </button>
                            <a href="/driver/dashboard" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle"></i> Cancel
                            </a>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>