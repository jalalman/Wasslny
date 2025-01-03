<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver Profile | Wasslny</title>
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
                <a class="nav-link active" href="/user/profile/edit">
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
            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Profile Information -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-person"></i> Personal Information</h5>
                </div>
                <div class="card-body">
                    <form:form action="/user/profile/edit/driver" method="post" modelAttribute="profileForm">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:input path="firstName" class="form-control" id="firstName" placeholder="First Name" value="${loggedUser.firstName}" />
                                    <form:label path="firstName">First Name</form:label>
                                    <form:errors path="firstName" cssClass="text-danger" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:input path="lastName" class="form-control" id="lastName" placeholder="Last Name" value="${loggedUser.lastName}" />
                                    <form:label path="lastName">Last Name</form:label>
                                    <form:errors path="lastName" cssClass="text-danger" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:input path="email" class="form-control" id="email" placeholder="Email" value="${loggedUser.email}" />
                                    <form:label path="email">Email</form:label>
                                    <form:errors path="email" cssClass="text-danger" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:input path="phoneNumber" class="form-control" id="phoneNumber" placeholder="Phone Number" value="${loggedUser.phoneNumber}" />
                                    <form:label path="phoneNumber">Phone Number</form:label>
                                    <form:errors path="phoneNumber" cssClass="text-danger" />
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-floating">
                                    <form:input path="location" class="form-control" id="location" placeholder="Location" value="${loggedUser.location}" />
                                    <form:label path="location">Location</form:label>
                                    <form:errors path="location" cssClass="text-danger" />
                                </div>
                            </div>
                        </div>
                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> Save Changes
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>

            <!-- Vehicle Details -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="bi bi-car-front"></i> Vehicle Details</h5>
                </div>
                <div class="card-body">
                    <form method="post" action="/driver/vehicleDetails/update">
                        <input type="hidden" name="driverId" value="${loggedUser.id}" />
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" id="permitNumber" name="permitNumber" class="form-control" placeholder="Permit Number" value="${loggedUser.permitNumber}" />
                                    <label for="permitNumber">Permit Number</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" id="carModel" name="carModel" class="form-control" placeholder="Vehicle Model" value="${loggedUser.carModel}" />
                                    <label for="carModel">Vehicle Model</label>
                                </div>
                            </div>
                        </div>
                        <div class="mt-3">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-save"></i> Update Vehicle Details
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Change Password -->
            <div class="card shadow-sm">
                <div class="card-header bg-warning">
                    <h5 class="mb-0"><i class="bi bi-key"></i> Change Password</h5>
                </div>
                <div class="card-body">
                    <form:form action="/user/password/update" method="post" modelAttribute="passwordForm">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <div class="form-floating">
                                    <form:password path="currentPassword" class="form-control" id="currentPassword" placeholder="Current Password" />
                                    <form:label path="currentPassword">Current Password</form:label>
                                    <form:errors path="currentPassword" cssClass="text-danger" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:password path="newPassword" class="form-control" id="newPassword" placeholder="New Password" />
                                    <form:label path="newPassword">New Password</form:label>
                                    <form:errors path="newPassword" cssClass="text-danger" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <form:password path="confirmPassword" class="form-control" id="confirmPassword" placeholder="Confirm Password" />
                                    <form:label path="confirmPassword">Confirm New Password</form:label>
                                    <form:errors path="confirmPassword" cssClass="text-danger" />
                                </div>
                            </div>
                        </div>
                        <div class="mt-3">
                            <button type="submit" class="btn btn-warning">
                                <i class="bi bi-key"></i> Update Password
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>