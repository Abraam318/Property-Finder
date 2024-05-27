-- Client Table
CREATE TABLE client (
    SSN NUMBER(9) PRIMARY KEY,
    first_name VARCHAR(8),
    last_name VARCHAR(8),
    email VARCHAR(25) UNIQUE
);

INSERT INTO client (SSN, first_name, last_name, email) VALUES
(232118857, 'Mariam', 'Maged', 'MariamM@gmail.com'),
(512455788, 'Ahmed', 'Ayman', 'AhmedA@gmail.com'),
(548616858, 'Amira', 'Ahmed', 'AmiraA@gmail.com'),
(494859032, 'Youssef', 'Sherif', 'YoussefS@gmail.com'),
(123456789, 'Mario', 'Medhat', 'MarioM@gmail.com'),
(987654321, 'Maria', 'Amgd', 'MariaA@gmail.com'),
(135792468, 'Ahmed', 'Ali', 'AhmedA@gmail.com');

-- Client_Phone Table
CREATE TABLE client_phone (
    c_ssn NUMBER(9),
    c_phone VARCHAR2(11),
    PRIMARY KEY (c_ssn, c_phone)
);

INSERT INTO client_phone (c_ssn, c_phone) VALUES
(512455788, '01248578017'),
(494859032, '01198650123'),
(232118857, '01032760632'),
(232118857, '01145700831'),
(548616858, '01065297743'),
(123456789, '01018904623'),
(987654321, '01287532096'),
(135792468, '01130584761'),
(135792468, '01256890234');

-- Payment Table
CREATE TABLE payment (
    pay_id VARCHAR2(5) PRIMARY KEY,
    amount NUMBER(9) NOT NULL,
    card_type VARCHAR2(25) NOT NULL,
    card_number VARCHAR2(16) UNIQUE NOT NULL,
    CVV VARCHAR2(3) NOT NULL,
    name_on_card VARCHAR2(40) NOT NULL,
    c_ssn NUMBER(9) REFERENCES client (SSN)
);

INSERT INTO payment VALUES
('10000', 2350000, 'Mastercard', '5210387306335745', '209', 'Ahmed Ayman', 512455788),
('12540', 3450000, 'Mastercard', '4032441851584078', '245', 'Mohamed Ali', 232118857),
('63457', 4000000, 'VISA', '5304476216300685', '923', 'Youssef Sherif', 494859032);

-- Location Table
CREATE TABLE location (
    location_id NUMBER(32) PRIMARY KEY,
    country VARCHAR2(30) NOT NULL,
    city VARCHAR2(30) NOT NULL,
    apartment_number NUMBER(30) NOT NULL,
    building_number NUMBER(35) NOT NULL,
    street_name VARCHAR2(255) NOT NULL,
    floor NUMBER(15) NOT NULL,
    near_by VARCHAR2(50) NOT NULL
);

INSERT INTO location VALUES
(1, 'Egypt', 'Cairo', 5, 52, 'Ahmed Helmy', 10, 'Gym Shubra'),
(2, 'Egypt', 'Cairo', 9, 89, 'Toman Bai', 5, 'Bilal Mosque'),
(3, 'Egypt', 'Cairo', 13, 22, 'Sliem Ali', 9, 'Al Khalidin Club'),
(4, 'Egypt', 'Cairo', 3, 35, 'Masra', 4, 'Saint Mary Church'),
(5, 'Egypt', 'Cairo', 5, 52, 'Abbasya Square', 2, 'Ain Shams University'),
(6, 'Egypt', 'Mansoura', 8, 7, 'Mansoura St.', 5, 'Mansoura University'),
(7, 'Egypt', 'Giza', 1, 22, 'Giza St.', 8, 'Shopping Mall');

-- Property Table
CREATE TABLE property (
    property_id NUMBER(10) PRIMARY KEY,
    p_type VARCHAR2(15) NOT NULL,
    p_size NUMBER(5) NOT NULL,
    agent_ssn NUMBER(9) REFERENCES agent (a_ssn),
    client_ssn NUMBER(9) REFERENCES client (SSN),
    p_category VARCHAR2(5),
    deal_date DATE,
    state VARCHAR(10) NOT NULL
);

INSERT INTO property VALUES
(55, 'Apartment', 188, 182740935, 232118857, 'Rent', TO_DATE('03-Nov-2023', 'DD-Mon-YYYY'), 'Sold Out'),
(56, 'Villa', 230, 576891782, 494859032, 'Buy', TO_DATE('26-Sep-2023', 'DD-Mon-YYYY'), 'Sold Out'),
(57, 'Town House', 350, 982457229, NULL, 'Buy', NULL, 'Available'),
(58, 'Town House', 310, 134624861, NULL, 'Buy', NULL, 'Available'),
(59, 'Villa', 250, 182740935, 512455788, 'Rent', TO_DATE('17-Oct-2023', 'DD-Mon-YYYY'), 'Sold Out');

-- Located_IN Table
CREATE TABLE located_in (
    property_id NUMBER(10),
    location_id NUMBER(32),
    PRIMARY KEY (property_id, location_id)
);

INSERT INTO located_in VALUES
(58, 1),
(55, 2),
(57, 3),
(56, 4),
(59, 5);

-- Property_Details Table
CREATE TABLE property_details (
    property_id NUMBER(10) REFERENCES property (property_id),
    description VARCHAR2(4000) NOT NULL,
    number_of_rooms NUMBER(10),
    number_of_bathrooms NUMBER(10),
    price NUMBER(38) NOT NULL,
    furnished VARCHAR2(6),
    condition VARCHAR2(20),
    pool VARCHAR2(6),
    garden VARCHAR2(6),
    parking VARCHAR2(6),
    balcony VARCHAR2(6),
    PRIMARY KEY (property_id, description)
);

INSERT INTO property_details VALUES
(55, 'Apartment for rent with 3 Rooms and 2 bathrooms, Area: 160 square meters', 3, 2, 700000, 'NO', 'Finished', 'No', 'No', 'Yes', 'Yes'),
(56, 'Villa for sale with 2 Rooms and 2 bathrooms, Area: 140 square meters', 2, 2, 600000, 'NO', 'Finished', 'No', 'No', 'No', 'No'),
(57, 'Town House for Sale with 5 Rooms and 3 bathrooms, Area: 300 square meters', 5, 3, 2000000, 'YES', 'Semi-Finished', 'Yes', 'Yes', 'Yes', 'Yes'),
(58, 'Town House for sale with 3 Rooms and 2 bathrooms, Area: 200 square meters', 3, 2, 1300000, 'YES', 'Finished', 'Yes', 'No', 'Yes', 'Yes'),
(59, 'Villa for rent with 5 Rooms and 2 bathrooms, Area: 220 square meters', 5, 2, 1300000, 'YES', 'Semi-Finished', 'Yes', 'No', 'Yes', 'Yes');

-- Agency Table
CREATE TABLE agency (
    agency_id NUMBER(7) PRIMARY KEY,
    tin NUMBER(9) UNIQUE,
    agency_name VARCHAR2(20) NOT NULL
);

INSERT INTO agency VALUES
(1, 200132413, 'New Home Agency'),
(2, 240125789, 'ElAhram Agency'),
(3, 134978146, 'El Safwa Agency'),
(4, 124697512, 'First Deal Agency'),
(5, 135643218, 'Masr ElGedida Agency');

-- Agency_Location Table
CREATE TABLE agency_location (
    agency_id NUMBER(7),
    country VARCHAR2(30),
    city VARCHAR2(30),
    PRIMARY KEY (agency_id, country, city)
);

INSERT INTO agency_location VALUES
(1, 'Egypt', 'Cairo'),
(2, 'Egypt', 'Cairo'),
(3, 'Egypt', 'Giza'),
(4, 'Egypt', 'Alexandria'),
(5, 'Egypt', 'Mansoura');

-- Agent Table
CREATE TABLE agent (
    agent_id NUMBER(7) REFERENCES agency (agency_id),
    a_ssn NUMBER(9) PRIMARY KEY,
    a_first_name VARCHAR2(20) NOT NULL,
    a_last_name VARCHAR2(20) NOT NULL,
    a_email VARCHAR2(50) NOT NULL,
    a_phone NUMBER(11) UNIQUE
);

INSERT INTO agent VALUES
(1, 182740935, 'Hazem', 'Kamal', 'HazemKamal@gmail.com', '01254093729'),
(2, 134624861, 'Ali', 'Hossam', 'AliHossam@gmail.com', '01056938724'),
(3, 576891782, 'Ibrahim', 'Hany', 'IbrahimHany@gmail.com', '01120963754'),
(4, 982457229, 'Ramy', 'Ahmed', 'RamyAhmed@gmail.com', '01258673092');
