<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Results | Wasslny</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>

<body>
	<div class="container mt-5">
	<a href="/passenger/dashboard" class="btn btn-secondary mb-3">Back
			to Dashboard</a>
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="mt-3">Search Results</h2>
		</div>
		<table class="table table-striped table-bordered">
			<thead class="table-dark">
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th>Start Point</th>
					<th>Destination</th>
					<th>Status</th>
					<th>Passengers</th>
					<th>Departure Time</th>
					<th>Driver</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="trip" items="${trips}">
					<c:if test="${trip.status == 'Planned'}">
						<tr>
							<td><a href="/passenger/trips/${trip.id}"
								class="text-decoration-none text-primary"> ${trip.title} </a></td>
							<td>${trip.description}</td>
							<td>${trip.startPoint}</td>
							<td>${trip.destination}</td>
							<td>${trip.status}</td>
							<td>${trip.currentPassengers}/${trip.maximumPassengers}</td>
							<td>${trip.departureTime}</td>
							<td>${trip.driver.firstName} ${trip.driver.lastName}</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${empty trips}">
			<div class="alert alert-info">No trips found.
			</div>
		</c:if>
		</div>
</body>

</html>
