create table passengers(
passenger_id number(20),
name varchar2(30),
email varchar2(30),
contact_number number(20),
primary key(passenger_id)
);

 create table airport(
 aiport_id number(20),
 airport_name varchar2(30),
 city varchar2(30),
 country varchar2(30),
 primary key(aiport_id)
 );


CREATE TABLE Flights (
    flight_id NUMBER(20),
    departure_date_time DATE,
    arrival_date_time DATE,
    origin_airport_id NUMBER(20),
    PRIMARY KEY (flight_id),
    FOREIGN KEY (origin_airport_id) REFERENCES Airport(aiport_id)
);

CREATE TABLE Tickets (
    ticket_id NUMBER(20),
    flight_id NUMBER(20),
    passenger_id NUMBER(20),
    seat_number VARCHAR2(10),
    ticket_price NUMBER(10, 2),
    PRIMARY KEY (ticket_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id)
);
-- Insert statements for Passengers table
INSERT INTO Passengers (passenger_id, name, email, phone_number) VALUES (3, 'Michael Johnson', 'michael@example.com', 5551234567);
INSERT INTO Passengers (passenger_id, name, email, phone_number) VALUES (1, 'John Doe', 'john@example.com', 1234567890);
INSERT INTO Passengers (passenger_id, name, email, phone_number) VALUES (5, 'David Wilson', 'david@example.com', 5558765432);
INSERT INTO Passengers (passenger_id, name, email, phone_number) VALUES (7, 'Christopher Martinez', 'chris@example.com', 5553456789);
INSERT INTO Passengers (passenger_id, name, email, phone_number) VALUES (2, 'Jane Smith', 'jane@example.com', 9876543210);
INSERT INTO Passengers (passenger_id, name, email, phone_number) VALUES (4, 'Emily Davis', 'emily@example.com', 5559876543);
INSERT INTO Passengers (passenger_id, name, email, phone_number) VALUES (6, 'Sarah Brown', 'sarah@example.com', 5552345678);

-- Insert statements for Airport table
INSERT INTO Airport (airport_id, airport_name, city, country) VALUES (2, 'Heathrow Airport', 'London', 'UK');
INSERT INTO Airport (airport_id, airport_name, city, country) VALUES (5, 'Sydney Airport', 'Sydney', 'Australia');
INSERT INTO Airport (airport_id, airport_name, city, country) VALUES (4, 'Tokyo Haneda Airport', 'Tokyo', 'Japan');
INSERT INTO Airport (airport_id, airport_name, city, country) VALUES (1, 'JFK International Airport', 'New York', 'USA');
INSERT INTO Airport (airport_id, airport_name, city, country) VALUES (7, 'Dubai International Airport', 'Dubai', 'UAE');
INSERT INTO Airport (airport_id, airport_name, city, country) VALUES (3, 'Los Angeles International Airport', 'Los Angeles', 'USA');
INSERT INTO Airport (airport_id, airport_name, city, country) VALUES (6, 'Paris Charles de Gaulle Airport', 'Paris', 'France');

-- Insert statements for Flights table
INSERT INTO Flights (flight_id, departure_date_time, arrival_date_time, origin_airport_id) VALUES (3, '2024-05-03 10:00:00', '2024-05-03 14:00:00', 3);
INSERT INTO Flights (flight_id, departure_date_time, arrival_date_time, origin_airport_id) VALUES (7, '2024-05-07 14:00:00', '2024-05-07 18:00:00', 7);
INSERT INTO Flights (flight_id, departure_date_time, arrival_date_time, origin_airport_id) VALUES (6, '2024-05-06 13:00:00', '2024-05-06 17:00:00', 6);
INSERT INTO Flights (flight_id, departure_date_time, arrival_date_time, origin_airport_id) VALUES (2, '2024-05-02 09:00:00', '2024-05-02 13:00:00', 2);
INSERT INTO Flights (flight_id, departure_date_time, arrival_date_time, origin_airport_id) VALUES (1, '2024-05-01 08:00:00', '2024-05-01 12:00:00', 1);
INSERT INTO Flights (flight_id, departure_date_time, arrival_date_time, origin_airport_id) VALUES (4, '2024-05-04 11:00:00', '2024-05-04 15:00:00', 4);
INSERT INTO Flights (flight_id, departure_date_time, arrival_date_time, origin_airport_id) VALUES (5, '2024-05-05 12:00:00', '2024-05-05 16:00:00', 5);

-- Insert statements for Tickets table
INSERT INTO Tickets (ticket_id, flight_id, passenger_id, seat_number, ticket_price) VALUES (3, 3, 3, 'C3', 300.00);
INSERT INTO Tickets (ticket_id, flight_id, passenger_id, seat_number, ticket_price) VALUES (7, 7, 7, 'G7', 500.00);
INSERT INTO Tickets (ticket_id, flight_id, passenger_id, seat_number, ticket_price) VALUES (2, 2, 2, 'B2', 250.00);
INSERT INTO Tickets (ticket_id, flight_id, passenger_id, seat_number, ticket_price) VALUES (5, 5, 5, 'E5', 400.00);
INSERT INTO Tickets (ticket_id, flight_id, passenger_id, seat_number, ticket_price) VALUES (1, 1, 1, 'A1', 200.00);
INSERT INTO Tickets (ticket_id, flight_id, passenger_id, seat_number, ticket_price) VALUES (4, 4, 4, 'D4', 350.00);
INSERT INTO Tickets (ticket_id, flight_id, passenger_id, seat_number, ticket_price) VALUES (6, 6, 6, 'F6', 450.00);

ALTER TABLE Airport RENAME COLUMN aiport_id TO airport_id;
-- Create table Airlines
CREATE TABLE Airlines (
    airline_id NUMBER(20),
    airline_name VARCHAR2(100),
    country VARCHAR2(50),
    primary_hub VARCHAR2(100),
    primary key (airline_id)
);
-- Insert statements for Airlines table
INSERT INTO Airlines (airline_id, airline_name, country, primary_hub) VALUES (1, 'Delta Air Lines', 'USA', 'Hartsfield-Jackson Atlanta International Airport');
INSERT INTO Airlines (airline_id, airline_name, country, primary_hub) VALUES (2, 'Emirates', 'UAE', 'Dubai International Airport');
INSERT INTO Airlines (airline_id, airline_name, country, primary_hub) VALUES (3, 'British Airways', 'UK', 'Heathrow Airport');
INSERT INTO Airlines (airline_id, airline_name, country, primary_hub) VALUES (4, 'Qantas', 'Australia', 'Sydney Airport');

-- Drop Airlines table
DROP TABLE Airlines;