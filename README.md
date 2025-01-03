# Wasslny - Taxi Reservation Application
<img src="https://i.ibb.co/BqZcZGf/icon-Copy.png" width="200" alt="Wasslny Logo">



## Overview
Wasslny (which means "give me a ride" in Arabic) is a web-based platform that connects passengers with drivers for ride sharing in Palestine.

A Spring Boot web application that connects passengers with drivers for ride sharing in Palestine.

## Authors
- Jalal hemmo - Full Stack Developer
  - GitHub: [@jalalman](https://github.com/jalalman)
  - LinkedIn: [Jalal hemmo](https://www.linkedin.com/in/jalal-hemmo/)

- Mahmoud Al Turk - Full Stack Developer
  - GitHub: [@Mohammad-Al-Turk](https://github.com/Mohammad-Al-Turk)
  - LinkedIn: [Mahmoud Al Turk](https://linkedin.com/in/alturk-mohammad/)

- yasser alzoubi - Full Stack Developer
  - GitHub: [@yasseralzoubi](https://github.com/yasseralzoubi)
  - LinkedIn: [yasser alzoubi](https://www.linkedin.com/in/yasseralzoubi/)



## Overview

Wasslny (which means "give me a ride" in Arabic) is a web-based platform that enables:
- Passengers to find and book rides
- Drivers to create and manage trips
- User profile management
- Real-time trip status tracking
- Secure authentication and authorization

## Technologies Used

- Java 17
- Spring Boot 3.4.1
- Spring MVC
- Spring Data JPA
- MySQL Database
- JSP & JSTL
- Bootstrap 5
- Maven
- Hibernate
- Spring Security (BCrypt)

## Features

### For Passengers
- Search available trips by location and time
- Book seats on trips
- View trip details and driver information
- Track trip status
- Manage profile and bookings
- Leave/cancel trip bookings

### For Drivers
- Create and manage trips
- Set trip details (route, time, capacity)
- View passenger information
- Update trip status
- Manage vehicle details
- Track trip history

## Prerequisites

- JDK 17 or later
- MySQL Server 8.0 or later
- Maven 3.6 or later

## Installation

1. Clone the repository:
```sh
git clone https://github.com/yourusername/wasslny.git
cd wasslny

2.Configure database connection in src/main/resources/application.properties:

spring.datasource.url=jdbc:mysql://localhost:3306/wasslny_db
spring.datasource.username=your_username
spring.datasource.password=your_password

3.Build the project:
mvn clean install

4.Run the application:

mvn spring-boot:run
The application will be available at http://localhost:8080

## Usage

1.Register as either a driver or passenger
2.Login with your credentials
3.Update your profile information
4.For drivers:
    -Add vehicle details
    -Create new trips
    -Manage existing trips
5.For passengers:
    -Search for available trips
    -Book seats on trips
    -View trip details

## License
This project is licensed under the MIT License - see the LICENSE file for details. ``

