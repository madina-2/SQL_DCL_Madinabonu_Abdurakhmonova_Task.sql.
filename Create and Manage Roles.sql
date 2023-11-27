CREATE USER rentaluser WITH PASSWORD 'rentalpassword';
GRANT CONNECT ON DATABASE dvd_rental TO rentaluser;
--------------------------------------------------------
GRANT SELECT ON TABLE customer TO rentaluser;
--------------------------------------------------------
SELECT * FROM customer;
---------------------------------------------
CREATE GROUP rental;
GRANT rental TO rentaluser;
--------------------------------------------
GRANT INSERT, UPDATE ON TABLE rental TO rental;
----------------------------------------------------
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES ('2023-11-24', 1, 1, '2023-11-30', 1);

UPDATE rental SET return_date = '2023-12-01' WHERE rental_id = 1;
-----------------------------------------------------------------------------------
REVOKE INSERT ON TABLE rental FROM rental;
---------------------------------------------------
CREATE ROLE client_first_name_last_name;
GRANT USAGE ON SCHEMA public TO client_first_name_last_name;
GRANT SELECT ON TABLE rental TO client_first_name_last_name;
GRANT SELECT ON TABLE payment TO client_first_name_last_name;
---------------------------------------------------------------
ALTER TABLE rental ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment ENABLE ROW LEVEL SECURITY;

CREATE POLICY client_first_name_last_name_policy ON rental
    FOR SELECT
    USING (customer_id = current_user);

CREATE POLICY client_first_name_last_name_policy ON payment
    FOR SELECT
    USING (customer_id = current_user);
---------------------------------------------------------------
SET ROLE client_first_name_last_name;
SELECT * FROM rental WHERE customer_id = current_user;
SELECT * FROM payment WHERE customer_id = current_user;
