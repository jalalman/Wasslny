package com.axsosacademy.wasslny.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Entity
@Table(name = "trips")
public class Trip {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotEmpty(message = "Trip title is required.")
    @Size(min = 3, max = 40, message = "Trip title must be between 3 and 40 characters.")
    private String title;

    private String description;

    @NotEmpty(message = "Trip start point is required.")
    @Size(min = 1, max = 40, message = "Trip start point is required.")
    private String startPoint;

    @NotEmpty(message = "Trip destination is required.")
    @Size(min = 1, max = 40, message = "Trip destination is required.")
    private String destination;

    @NotEmpty(message = "Trip status is required.")
    @Size(min = 1, max = 40, message = "Trip status is required.")
    private String status;

    @Min(value = 1, message = "Maximum passengers can only be more than 1.")
    private int maximumPassengers;

    @ManyToOne(fetch= FetchType.LAZY)
    @JoinColumn(name="driver_id")
    private Driver driver;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @Column(name = "departure_time")
    private Date departureTime;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "trips_passengers",
        joinColumns = @JoinColumn(name = "trip_id"),
        inverseJoinColumns = @JoinColumn(name = "passenger_id")
    )
    private List<Passenger> passengers;

    @ElementCollection
    @CollectionTable(name = "passenger_count_map", joinColumns = @JoinColumn(name = "trip_id"))
    @MapKeyColumn(name = "passenger_id", columnDefinition = "BIGINT")
    @Column(name = "count", columnDefinition = "INTEGER")
    private Map<Long, Integer> passengerCountMap = new HashMap<>();

    private int currentPassengers = 0;

    @ElementCollection
    @CollectionTable(name = "passenger_notes", joinColumns = @JoinColumn(name = "trip_id"))
    @MapKeyColumn(name = "passenger_id", columnDefinition = "BIGINT")
    @Column(name = "note", columnDefinition = "TEXT")
    private Map<Long, String> passengerNotes = new HashMap<>();

    @Column(updatable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    @DateTimeFormat(pattern = "yyy-MM-dd")
    private Date updatedAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = new Date();
    }

    public Trip() {}


	public Trip(String title, String description, String startPoint, String destination, String status, int maximumPassengers, Driver driver, Date departureTime) {
		this.title = title;
		this.description = description;
		this.status = status;
		this.startPoint = startPoint;
		this.maximumPassengers = maximumPassengers;
		this.destination = destination;
		this.driver = driver;
		this.departureTime = departureTime;
	}

	public boolean hasAvailableCapacity(int passengerCount) {
        return this.currentPassengers + passengerCount <= this.maximumPassengers;
    }

	public int getCurrentPassengers() {
		return currentPassengers;
	}

	public void setCurrentPassengers(int currentPassengers) {
		this.currentPassengers = currentPassengers;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public Date getDepartureTime() {
	    return departureTime;
	}

	public void setDepartureTime(Date departureTime) {
	    this.departureTime = departureTime;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Map<Long, Integer> getPassengerCountMap() {
		return passengerCountMap;
	}

	public void setPassengerCountMap(Map<Long, Integer> passengerCountMap) {
		this.passengerCountMap = passengerCountMap;
	}

	public Map<Long, String> getPassengerNotes() {
        return passengerNotes;
    }

    public void setPassengerNotes(Map<Long, String> passengerNotes) {
        this.passengerNotes = passengerNotes;
    }

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStartPoint() {
		return startPoint;
	}

	public void setStartPoint(String startPoint) {
		this.startPoint = startPoint;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public int getMaximumPassengers() {
		return maximumPassengers;
	}

	public void setMaximumPassengers(int maximumPassengers) {
		this.maximumPassengers = maximumPassengers;
	}

	public Driver getDriver() {
		return driver;
	}

	public void setDriver(Driver driver) {
		this.driver = driver;
	}

	public List<Passenger> getPassengers() {
		return passengers;
	}

	public void setPassengers(List<Passenger> passengers) {
		this.passengers = passengers;
	}

}