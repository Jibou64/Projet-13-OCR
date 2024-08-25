CREATE TABLE Users (
                       user_id SERIAL PRIMARY KEY,
                       first_name VARCHAR(100) NOT NULL,
                       last_name VARCHAR(100) NOT NULL,
                       email VARCHAR(150) UNIQUE NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,
                       phone_number VARCHAR(20),
                       address VARCHAR(255),
                       city VARCHAR(100),
                       country VARCHAR(100),
                       postal_code VARCHAR(20),
                       date_of_birth DATE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Vehicles (
                          vehicle_id SERIAL PRIMARY KEY,
                          model VARCHAR(100) NOT NULL,
                          brand VARCHAR(100) NOT NULL,
                          category VARCHAR(50) NOT NULL,
                          license_plate VARCHAR(20) UNIQUE NOT NULL,
                          availability BOOLEAN DEFAULT TRUE,
                          daily_rate DECIMAL(10, 2) NOT NULL,
                          location_id INT REFERENCES Locations(location_id),
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Locations (
                           location_id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           address VARCHAR(255) NOT NULL,
                           city VARCHAR(100) NOT NULL,
                           country VARCHAR(100) NOT NULL,
                           postal_code VARCHAR(20),
                           phone_number VARCHAR(20),
                           opening_hours VARCHAR(50),
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Reservations (
                              reservation_id SERIAL PRIMARY KEY,
                              user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
                              vehicle_id INT REFERENCES Vehicles(vehicle_id) ON DELETE SET NULL,
                              start_date DATE NOT NULL,
                              end_date DATE NOT NULL,
                              total_price DECIMAL(10, 2) NOT NULL,
                              status VARCHAR(50) DEFAULT 'Pending',  -- Possible values: Pending, Confirmed, Cancelled
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Payments (
                          payment_id SERIAL PRIMARY KEY,
                          reservation_id INT REFERENCES Reservations(reservation_id) ON DELETE CASCADE,
                          amount DECIMAL(10, 2) NOT NULL,
                          payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          payment_method VARCHAR(50),  -- Possible values: Credit Card, PayPal, etc.
                          status VARCHAR(50) DEFAULT 'Completed',  -- Possible values: Completed, Pending, Failed
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Reviews (
                         review_id SERIAL PRIMARY KEY,
                         user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
                         vehicle_id INT REFERENCES Vehicles(vehicle_id) ON DELETE SET NULL,
                         rating INT CHECK (rating >= 1 AND rating <= 5),
                         comment TEXT,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
