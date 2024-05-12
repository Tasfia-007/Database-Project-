-- Step 1: Add the "passport_number" column to the "Passengers" table
ALTER TABLE Passengers
ADD passport_number VARCHAR2(20);

-- Step 2: Update the "passport_number" column for each passenger
UPDATE Passengers
SET passport_number = 'PASS123'
WHERE passenger_id = 3;

UPDATE Passengers
SET passport_number = 'PASS456'
WHERE passenger_id = 1;

UPDATE Passengers
SET passport_number = 'PASS789'
WHERE passenger_id = 5;

UPDATE Passengers
SET passport_number = 'PASS321'
WHERE passenger_id = 7;

UPDATE Passengers
SET passport_number = 'PASS654'
WHERE passenger_id = 2;

UPDATE Passengers
SET passport_number = 'PASS987'
WHERE passenger_id = 4;

UPDATE Passengers
SET passport_number = 'PASS654'
WHERE passenger_id = 6;



ALTER TABLE Passengers
RENAME COLUMN phone_number TO contact_number;


ALTER TABLE Passengers
MODIFY passport_number VARCHAR2(30);


-- Add a new column named "membership_level" to the "Passengers" table
ALTER TABLE Passengers
ADD membership_level VARCHAR2(20);

-- Insert membership data for passengers into the "Passengers" table
UPDATE Passengers
SET membership_level = 'Gold'
WHERE passenger_id = 1;

UPDATE Passengers
SET membership_level = 'Silver'
WHERE passenger_id = 2;

UPDATE Passengers
SET membership_level = 'Bronze'
WHERE passenger_id = 3;

-- Repeat the above UPDATE statements for each passenger

-- Drop the "membership_level" column from the "Passengers" table
ALTER TABLE Passengers
DROP COLUMN membership_level;

-- Insert rows with airport IDs 8 and 9
INSERT INTO Airport (airport_id, airport_name, city, country)
VALUES (8, 'Airport Name 8', 'City 8', 'Country 8');

INSERT INTO Airport (airport_id, airport_name, city, country)
VALUES (9, 'Airport Name 9', 'City 9', 'Country 9');

-- Update rows with airport IDs 8 and 9
UPDATE Airport
SET city = 'New City 8'
WHERE airport_id = 8;

UPDATE Airport
SET city = 'New City 9'
WHERE airport_id = 9;

-- Delete rows with airport IDs 8 and 9
DELETE FROM Airport
WHERE airport_id IN (8, 9);

--to show the sum of the total tickets sold 
SELECT SUM(ticket_price) AS total_sales
FROM Tickets;

-- calculate the total ticket sales for each flight
SELECT flight_id, SUM(ticket_price) AS total_sales
FROM Tickets
GROUP BY flight_id;
 

--This query selects all rows from the Tickets table where the ticket price is greater than the average ticket price across all tickets in the table.
SELECT *
FROM tickets
WHERE ticket_price > (
    SELECT AVG(ticket_price)
    FROM tickets
);

--Select flights that depart from New York AND arrive in London.
SELECT *
FROM Flights
WHERE origin_airport_id = (
        SELECT airport_id
        FROM Airport
        WHERE city = 'New York'
    )
    AND origin_airport_id = (
        SELECT airport_id
        FROM Airport
        WHERE city = 'London'
    );

--Select flights that depart from Tokyo OR arrive in Paris.

SELECT *
FROM Flights
WHERE origin_airport_id = (
        SELECT airport_id
        FROM Airport
        WHERE city = 'Tokyo'
    )
    OR origin_airport_id = (
        SELECT airport_id
        FROM Airport
        WHERE city = 'Paris'
    );

--Select flights that depart from airports other than New York.
SELECT *
FROM Flights
WHERE origin_airport_id NOT IN (
        SELECT airport_id
        FROM Airport
        WHERE city = 'New York'
    );

--This query joins the Flights table with the Airport table and then filters the results based on the airport name containing the string "International".

SELECT f.*
FROM Flights f
JOIN Airport a ON f.origin_airport_id = a.airport_id
WHERE a.airport_name LIKE '%International%';

-- Inner Join: Returns rows when there is a match in both tables
SELECT *
FROM Flights
INNER JOIN Tickets ON Flights.flight_id = Tickets.flight_id;

-- Left Join: Returns all rows from the left table (Flights), and the matched rows from the right table (Tickets)
SELECT *
FROM Flights
LEFT JOIN Tickets ON Flights.flight_id = Tickets.flight_id;

-- Right Join: Returns all rows from the right table (Tickets), and the matched rows from the left table (Flights)
SELECT *
FROM Flights
RIGHT JOIN Tickets ON Flights.flight_id = Tickets.flight_id;

-- Full Join: Returns all rows when there is a match in either table
SELECT *
FROM Flights
FULL JOIN Tickets ON Flights.flight_id = Tickets.flight_id;

-- Cross Join: Returns the Cartesian product of the two tables
SELECT *
FROM Flights
CROSS JOIN Tickets;

--We declare variables corresponding to the columns in the Passengers table.
--Assign sample values to these variables.
--Print the values using the DBMS_OUTPUT.PUT_LINE procedure.
--Ensure that SET SERVEROUTPUT ON; is executed to enable output in your SQL environment.

-- Enable DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- Declare PL/SQL block
DECLARE
    -- Declare variables
    v_passenger_id Passengers.passenger_id%TYPE;
    v_name Passengers.name%TYPE;
    v_email Passengers.email%TYPE;
    v_phone_number Passengers.contact_number%TYPE;

BEGIN
    -- Assign values to variables
    v_passenger_id := 3;
    v_name := 'Michael Johnson';
    v_email := 'michael@example.com';
    v_phone_number := 5551234567;

    -- Print variable values
    DBMS_OUTPUT.PUT_LINE('Passenger ID: ' || v_passenger_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
    DBMS_OUTPUT.PUT_LINE('Phone Number: ' || v_phone_number);
END;
/

--We've adjusted the variable v_contact_number to match the column name contact_number.
--Updated the INSERT statement accordingly to use the correct column name contact_number.
-- Enable DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- Declare PL/SQL block
DECLARE
    -- Declare variables
    v_passenger_id Passengers.passenger_id%TYPE;
    v_name Passengers.name%TYPE;
    v_email Passengers.email%TYPE DEFAULT 'default@example.com'; -- Setting default value
    v_contact_number Passengers.contact_number%TYPE;
BEGIN
    -- Assign values to variables
    v_passenger_id := 8; -- Assuming 8 is the new passenger ID
    v_name := 'New Passenger';
    v_contact_number := 5555555555;

    -- Insert new row with default value for email
    INSERT INTO Passengers (passenger_id, name, email, contact_number)
    VALUES (v_passenger_id, v_name, v_email, v_contact_number);

    -- Commit the transaction
    COMMIT;

    -- Print confirmation message
    DBMS_OUTPUT.PUT_LINE('New passenger inserted successfully with default email value.');
EXCEPTION
    WHEN OTHERS THEN
        -- Print error message if an exception occurs
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


--We declare a record variable v_flight of type Flights%ROWTYPE.
--We fetch a row from the Flights table into the v_flight variable using a SELECT INTO 
--statement.
--We then access the individual fields of the fetched row using dot notation (e.g., ----
--v_flight.flight_id).
--We handle exceptions such as when no rows are found or other errors occur during the --
--execution of the block.

DECLARE
    -- Declare a record variable of type Flights%ROWTYPE
    v_flight Flights%ROWTYPE;
BEGIN
    -- Fetch a row into the record variable
    SELECT *
    INTO v_flight
    FROM Flights
    WHERE flight_id = 1; -- You can specify any condition here to fetch the desired row

    -- Print the values of the fetched row
    DBMS_OUTPUT.PUT_LINE('Flight ID: ' || v_flight.flight_id);
    DBMS_OUTPUT.PUT_LINE('Departure Date Time: ' || TO_CHAR(v_flight.departure_date_time, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Arrival Date Time: ' || TO_CHAR(v_flight.arrival_date_time, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Origin Airport ID: ' || v_flight.origin_airport_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case when no rows are fetched
        DBMS_OUTPUT.PUT_LINE('No data found for the specified condition.');
    WHEN OTHERS THEN
        -- Handle other exceptions
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--We declare a cursor named flights_cursor to select all rows from the Flights table.
--Inside the BEGIN block, we open the cursor using the OPEN statement.
--We use a LOOP to fetch each row from the cursor into the v_flight variable.
--We print information about each fetched row using DBMS_OUTPUT.PUT_LINE.
--We increment the v_row_count variable for each fetched row.
--After fetching all rows, we close the cursor using the CLOSE statement.
--We print the total number of rows fetched using DBMS_OUTPUT.PUT_LINE. Alternatively, you --can use SQL%ROWCOUNT to get the row count directly after the cursor loop.

DECLARE
    -- Declare a cursor to fetch rows from the Flights table
    CURSOR flights_cursor IS
        SELECT *
        FROM Flights;

    -- Declare variables
    v_flight Flights%ROWTYPE;
    v_row_count NUMBER := 0;
BEGIN
    -- Open the cursor
    OPEN flights_cursor;

    -- Fetch rows from the cursor and process them
    LOOP
        -- Fetch a row from the cursor into the v_flight variable
        FETCH flights_cursor INTO v_flight;

        -- Exit the loop if no more rows are found
        EXIT WHEN flights_cursor%NOTFOUND;

        -- Increment the row count
        v_row_count := v_row_count + 1;

        -- Print information about the fetched row
        DBMS_OUTPUT.PUT_LINE('Flight ID: ' || v_flight.flight_id);
        DBMS_OUTPUT.PUT_LINE('Departure Date Time: ' || TO_CHAR(v_flight.departure_date_time, 'YYYY-MM-DD HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('Arrival Date Time: ' || TO_CHAR(v_flight.arrival_date_time, 'YYYY-MM-DD HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('Origin Airport ID: ' || v_flight.origin_airport_id);
        DBMS_OUTPUT.PUT_LINE('------------------------------------');
    END LOOP;

    -- Close the cursor
    CLOSE flights_cursor;

    -- Print the total number of rows fetched
    DBMS_OUTPUT.PUT_LINE('Total number of rows fetched: ' || v_row_count);
    -- Alternatively, you can use SQL%ROWCOUNT to get the row count directly after the cursor loop
    -- DBMS_OUTPUT.PUT_LINE('Total number of rows fetched: ' || SQL%ROWCOUNT);
END;
/

--This code will iterate over each row in the Flights table and print the flight ID, --
--departure date, and arrival date for each flight. 
DECLARE
  -- Declare variables to hold column values
  v_flight_id Flights.flight_id%TYPE;
  v_departure_date Flights.departure_date_time%TYPE;
  v_arrival_date Flights.arrival_date_time%TYPE;
BEGIN
  -- Iterate over each row in the Flights table
  FOR flight_rec IN (SELECT flight_id, departure_date_time, arrival_date_time FROM Flights) LOOP
    -- Assign values from the current row to variables
    v_flight_id := flight_rec.flight_id;
    v_departure_date := flight_rec.departure_date_time;
    v_arrival_date := flight_rec.arrival_date_time;
    
    -- Print information about the current flight
    DBMS_OUTPUT.PUT_LINE('Flight ID: ' || v_flight_id || ', Departure: ' || v_departure_date || ', Arrival: ' || v_arrival_date);
  END LOOP;
END;
/

--In this example, the WHILE loop iterates over each row in the Passengers table, fetching 
--the passenger ID, name, email, and phone number for each passenger.

DECLARE
    v_passenger_id Passengers.passenger_id%TYPE;
    v_name Passengers.name%TYPE;
    v_email Passengers.email%TYPE;
    v_phone_number Passengers.contact_number%TYPE;
BEGIN
    -- Initialize cursor to fetch passenger data
    FOR passenger_rec IN (SELECT * FROM Passengers) LOOP
        -- Assign values from cursor to variables
        v_passenger_id := passenger_rec.passenger_id;
        v_name := passenger_rec.name;
        v_email := passenger_rec.email;
        v_phone_number := passenger_rec.contact_number;
        
        -- Perform some operation with the fetched data
        DBMS_OUTPUT.PUT_LINE('Passenger ID: ' || v_passenger_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
        DBMS_OUTPUT.PUT_LINE('Phone Number: ' || v_phone_number);
        
        -- Here you can add any additional logic or operations
        
    END LOOP;
END;
/
--We declare a PL/SQL associative array PassengerList indexed by integers.
--Inside the loop, we extend the array dynamically using the EXTEND function and populate 
--it with each row fetched from the Passengers table.
--Finally, we iterate over the array using a FOR loop and print the details of each --
--passenger.


DECLARE
    TYPE PassengerList IS TABLE OF Passengers%ROWTYPE INDEX BY PLS_INTEGER;
    v_passengers PassengerList;
BEGIN
    -- Fetch passenger data into the array
    FOR passenger_rec IN (SELECT * FROM Passengers) LOOP
        v_passengers(passenger_rec.passenger_id) := passenger_rec;
    END LOOP;

    -- Print the details of each passenger in the array
    FOR i IN 1..v_passengers.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Passenger ID: ' || v_passengers(i).passenger_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_passengers(i).name);
        DBMS_OUTPUT.PUT_LINE('Email: ' || v_passengers(i).email);
        DBMS_OUTPUT.PUT_LINE('Phone Number: ' || v_passengers(i).contact_number);
    END LOOP;
END;
/

--This PL/SQL block declares a cursor c_passengers to select all rows from the Passengers 
--table. It then fetches each row into the variable v_passenger and prints its details --
--using DBMS_OUTPUT.PUT_LINE. Finally, it closes the cursor after processing all rows.

DECLARE
    CURSOR c_passengers IS
        SELECT * FROM Passengers;
    v_passenger Passengers%ROWTYPE;
BEGIN
    -- Open the cursor
    OPEN c_passengers;
    
    -- Fetch and process each row
    LOOP
        FETCH c_passengers INTO v_passenger;
        EXIT WHEN c_passengers%NOTFOUND;

        -- Print details of the current row
        DBMS_OUTPUT.PUT_LINE('Passenger ID: ' || v_passenger.passenger_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_passenger.name);
        DBMS_OUTPUT.PUT_LINE('Email: ' || v_passenger.email);
        DBMS_OUTPUT.PUT_LINE('Phone Number: ' || v_passenger.contact_number);
    END LOOP;
    
    -- Close the cursor
    CLOSE c_passengers;
END;
/
--We'll consider a scenario where we want to classify passengers based on their ticket --
--prices into different fare categories.

DECLARE
    v_ticket_price NUMBER := 350.00; -- Example ticket price
    v_fare_category VARCHAR2(50);
BEGIN
    IF v_ticket_price < 200 THEN
        v_fare_category := 'Low Fare';
    ELSIF v_ticket_price >= 200 AND v_ticket_price < 400 THEN
        v_fare_category := 'Mid Fare';
    ELSE
        v_fare_category := 'High Fare';
    END IF;

    -- Print the fare category
    DBMS_OUTPUT.PUT_LINE('Ticket Price: ' || v_ticket_price);
    DBMS_OUTPUT.PUT_LINE('Fare Category: ' || v_fare_category);
END;
/

--PL/SQL procedure that retrieves and displays the details of a specific passenger based on 
--their passenger ID

CREATE OR REPLACE PROCEDURE GetPassengerDetails(
    p_passenger_id IN NUMBERh
) AS
    v_passenger_name Passengers.name%TYPE;
    v_passenger_email Passengers.email%TYPE;
    v_passenger_contact Passengers.contact_number%TYPE;
BEGIN
    -- Retrieve passenger details based on the provided passenger ID
    SELECT name, email, contact_number
    INTO v_passenger_name, v_passenger_email, v_passenger_contact
    FROM Passengers
    WHERE passenger_id = p_passenger_id;

    -- Display the retrieved passenger details
    DBMS_OUTPUT.PUT_LINE('Passenger ID: ' || p_passenger_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_passenger_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_passenger_email);
    DBMS_OUTPUT.PUT_LINE('Contact Number: ' || v_passenger_contact);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for the provided passenger ID: ' || p_passenger_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred while retrieving passenger details.');
END;
/

--that calculates the total ticket price for a given flight ID
CREATE OR REPLACE FUNCTION CalculateTotalTicketPrice(
    p_flight_id IN NUMBER
) RETURN NUMBER AS
    v_total_price NUMBER := 0;
BEGIN
    -- Calculate the total ticket price for the given flight ID
    SELECT SUM(ticket_price)
    INTO v_total_price
    FROM Tickets
    WHERE flight_id = p_flight_id;

    -- Return the total price
    RETURN v_total_price;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Return 0 if no tickets are found for the flight ID
    WHEN OTHERS THEN
        RETURN -1; -- Return -1 for other errors
END CalculateTotalTicketPrice;
/
-- PL/SQL trigger that automatically updates a table whenever a new row is inserted into another table

CREATE OR REPLACE TRIGGER UpdateFlightStatus
AFTER INSERT ON Tickets
FOR EACH ROW
DECLARE
    v_flight_id NUMBER;
BEGIN
    -- Retrieve the flight ID of the newly inserted ticket
    v_flight_id := :NEW.flight_id;

    -- Update the status of the flight in the Flights table
    UPDATE Flights
    SET status = 'Booked'
    WHERE flight_id = v_flight_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- Optionally handle the exception
    WHEN OTHERS THEN
        NULL; -- Optionally handle other exceptions
END;
/

SELECT *
FROM (
    SELECT *
    FROM order_items
    ORDER BY price DESC
) 
WHERE ROWNUM = 2;




