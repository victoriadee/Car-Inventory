CREATE database car_selling; 
-- Users Table
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- Listings Table
CREATE TABLE Listings (
    ListingID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    Make VARCHAR(50),
    Model VARCHAR(50),
    Year INT,
    Mileage INT,
    Price DECIMAL(10, 2),
    ImageURL VARCHAR(255),
    Status ENUM('Pending', 'Active', 'Rejected') DEFAULT 'Pending',
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
-- Payments Table
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    ListingID INT NOT NULL,
    Amount DECIMAL(10, 2),
    MpesaPhone VARCHAR(15),
    MpesaTransactionID VARCHAR(50) UNIQUE,
    Status ENUM('Pending', 'Success', 'Failed') DEFAULT 'Pending',
    PaidAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID)
);
INSERT INTO Users (FullName, Email, Phone, PasswordHash, CreatedAt) VALUES
('Jane Mwangi', 'jane@example.com', '0712345678', SHA2('password123', 256), NOW()),
('Mark Otieno', 'mark@example.com', '0798765432', SHA2('securepass', 256), NOW()),
('Linet Wanjiru', 'linet@example.com', '0700111222', SHA2('mypassword', 256), NOW());
INSERT INTO Listings (UserID, Title, Description, Make, Model, Year, Mileage, Price, ImageURL, Status, CreatedAt) VALUES
(1, 'Toyota Axio 2014', 'Clean car, accident-free, Nairobi-based.', 'Toyota', 'Axio', 2014, 78000, 950000.00, 'images/axio1.jpg', 'Pending', NOW()),
(2, 'Mazda Demio 2012', 'Well-maintained, one owner, mint condition.', 'Mazda', 'Demio', 2012, 120000, 620000.00, 'images/demio.jpg', 'Pending', NOW()),
(1, 'Subaru Forester 2015', 'Powerful AWD, good for upcountry roads.', 'Subaru', 'Forester', 2015, 94000, 1100000.00, 'images/forester.jpg', 'Pending', NOW());
INSERT INTO Payments (UserID, ListingID, Amount, MpesaPhone, MpesaTransactionID, Status, PaidAt) VALUES
(1, 1, 5.00, '0712345678', 'MPESA123456', 'Success', NOW()),
(2, 2, 5.00, '0798765432', 'MPESA654321', 'Success', NOW()),
(1, 3, 5.00, '0712345678', 'MPESA112233', 'Success', NOW());