
CREATE TABLE pharmacy (
    pharmacyId SERIAL PRIMARY KEY,
    phName VARCHAR(30) NOT NULL,
    city VARCHAR(30),
    subCity VARCHAR(30),
    kebele INTEGER
);

CREATE TABLE pharmacyPhoneNumber (
    pharmacyId INTEGER,
    phoneNumber VARCHAR(13),
    CONSTRAINT fk_pharmacy_phone FOREIGN KEY (pharmacyId) REFERENCES pharmacy(pharmacyId)
);

CREATE TABLE medicine (
    medId SERIAL PRIMARY KEY,
    medName VARCHAR(50),
    brandName VARCHAR(50),
    productionDate DATE,
    expiryDate DATE,
    sellingPrice DECIMAL(8, 2),
    stockQuantity INTEGER
);

CREATE TABLE supplier (
    supplierId SERIAL PRIMARY KEY,
    supName VARCHAR(100),
    city VARCHAR(30),
    subCity VARCHAR(30),
    kebele INTEGER,
    phone VARCHAR(13)
);

CREATE TABLE employee (
    empId SERIAL PRIMARY KEY,
    firstName VARCHAR(20),
    middleName VARCHAR(20),
    lastName VARCHAR(20),
    city VARCHAR(20),
    subCity VARCHAR(20),
    kebele INTEGER,
    salary DECIMAL(10, 2),
    position VARCHAR(30),
    pharmacyId INTEGER,
    CONSTRAINT fk_employee_pharmacy FOREIGN KEY (pharmacyId) REFERENCES pharmacy(pharmacyId)
);

CREATE TABLE customer (
    custId SERIAL PRIMARY KEY,
    firstName VARCHAR(20),
    middleName VARCHAR(20),
    lastName VARCHAR(20),
    city VARCHAR(20),
    subCity VARCHAR(20),
    kebele INTEGER,
    birthdate DATE,
    phone VARCHAR(13)
);

CREATE TABLE supplyOrder (
    supplyOrderId SERIAL PRIMARY KEY,
    orderDay DATE,
    supplierId INTEGER,
    CONSTRAINT fk_supply_supplier FOREIGN KEY (supplierId) REFERENCES supplier(supplierId)
);

CREATE TABLE supplyOrderDetail (
    supplyOrderId INTEGER,
    medId INTEGER,
    quantity INTEGER,
    purchasePrice DECIMAL(8, 2),
    CONSTRAINT fk_supplyorder FOREIGN KEY (supplyOrderId) REFERENCES supplyOrder(supplyOrderId),
    CONSTRAINT fk_supply_med FOREIGN KEY (medId) REFERENCES medicine(medId)
);

CREATE TABLE prescription (
    prescId SERIAL PRIMARY KEY,
    custId INTEGER,
    docFName VARCHAR(20),
    docMName VARCHAR(20),
    docLName VARCHAR(20),
    hospital VARCHAR(50),
    prescDate DATE,
    CONSTRAINT fk_presc_cust FOREIGN KEY (custId) REFERENCES customer(custId)
);

CREATE TABLE medicinePrescription (
    prescId INTEGER,
    medId INTEGER,
    CONSTRAINT fk_mp_presc FOREIGN KEY (prescId) REFERENCES prescription(prescId),
    CONSTRAINT fk_mp_med FOREIGN KEY (medId) REFERENCES medicine(medId)
);

CREATE TABLE customerOrder (
    ordId SERIAL PRIMARY KEY,
    orderDate DATE,
    empId INTEGER,
    custId INTEGER,
    pharmacyId INTEGER,
    CONSTRAINT fk_ord_emp FOREIGN KEY (empId) REFERENCES employee(empId),
    CONSTRAINT fk_ord_cust FOREIGN KEY (custId) REFERENCES customer(custId),
    CONSTRAINT fk_ord_ph FOREIGN KEY (pharmacyId) REFERENCES pharmacy(pharmacyId)
);

CREATE TABLE orderDetail (
    ordId INTEGER,
    medId INTEGER,
    quantity INTEGER,
    price DECIMAL(8, 2),
    discount DECIMAL(8, 2),
    CONSTRAINT fk_order_ord FOREIGN KEY (ordId) REFERENCES customerOrder(ordId),
    CONSTRAINT fk_order_med FOREIGN KEY (medId) REFERENCES medicine(medId)
);

CREATE TABLE bill (
    billId SERIAL PRIMARY KEY,
    ordId INTEGER,
    billDay DATE,
    totalPayment DECIMAL(8, 2),
    paid DECIMAL(8, 2),
    empId INTEGER,
    pharmacyId INTEGER,
    CONSTRAINT fk_bill_ord FOREIGN KEY (ordId) REFERENCES customerOrder(ordId),
    CONSTRAINT fk_bill_emp FOREIGN KEY (empId) REFERENCES employee(empId),
    CONSTRAINT fk_bill_pharm FOREIGN KEY (pharmacyId) REFERENCES pharmacy(pharmacyId)
);

-- Insert Data
INSERT INTO pharmacy (phName, city, subCity, kebele) VALUES 
('EthioMed Pharmacy', 'Addis Ababa', 'Bole', 12),
('Shega Pharmacy', 'Adama', 'Kersa', 3),
('Zewdu Pharmacy', 'Bahir Dar', 'Dagmawi', 7),
('Alem Pharmacy', 'Mekelle', 'Ayder', 18)

INSERT INTO pharmacyPhoneNumber (pharmacyId, phoneNumber) VALUES 
(1, '0912345678'),
(2, '0923456789'),
(3, '0934567890'),
(4, '0945678901');

INSERT INTO medicine (medId,medName, brandName, productionDate, expiryDate, sellingPrice, stockQuantity) VALUES 
(101,'Paracetamol', 'PharmaLife', '2023-01-01', '2025-01-01', 10.00, 500),
(102,'Amoxicillin', 'MedaPharma', '2023-06-15', '2026-06-15', 25.50, 300),
(103,'Ibuprofen', 'LifeAid', '2022-10-10', '2025-10-10', 15.00, 200),
(104,'Cough Syrup', 'Zemed', '2023-03-03', '2024-12-31', 18.75, 150);

INSERT INTO supplier (supplierId,supName, city, subCity, kebele, phone) VALUES 
(201,'Abebe Tadesse', 'Addis Ababa', 'Arada', 1, '0911223344'),
(202,'Meskerem Degu', 'Gondar', 'Azezo', 9, '0922334455'),
(203,'Bekele Desta', 'Hawassa', 'Haile', 4, '0933445566'),
(204,'Samrawit Lemma', 'Dire Dawa', 'Sabian', 5, '0944556677');

INSERT INTO employee (empId, firstName, middleName, lastName, city, subCity, kebele, salary, position, pharmacyId) VALUES 
(301, 'Kebede', 'Alemu', 'Bekele', 'Addis Ababa', 'Bole', 10, 8000.00, 'Pharmacist', 1),
(302,'Tigist', 'Yonas', 'Gebre', 'Bahir Dar', 'Kebel 14', 14, 7000.00, 'Cashier', 3),
(303,'Dereje', 'Mulu', 'Hailu', 'Adama', 'Kebele 02', 2, 9000.00, 'Manager', 2),
(304,'Hana', 'Abate', 'Fikre', 'Mekelle', 'Semien', 6, 6000.00, 'Assistant', 4);

INSERT INTO customer (custId, firstName, middleName, lastName, city, subCity, kebele, birthdate, phone) VALUES 
(401,'Mekdes', 'Tadele', 'Amanuel', 'Addis Ababa', 'Gulele', 5, '1998-02-12', '0911223344'),
(402,'Solomon', 'Bekele', 'Molla', 'Adama', 'Asela', 3, '1995-07-21', '0922334455'),
(403,'Banchi', 'Hailemariam', 'Kifle', 'Gondar', 'Fasil', 9, '1990-05-30', '0933445566'),
(404,'Yared', 'Tsegaye', 'Mengistu', 'Hawassa', 'Tikur Wuha', 8, '1988-11-15', '0944556677');

INSERT INTO supplyOrder (supplyOrderId, orderDay, supplierId) VALUES 
(501,'2025-06-01', 201),
(502,'2025-06-02', 202),
(503,'2025-06-03', 203),
(504,'2025-06-04', 204);

INSERT INTO supplyOrderDetail (supplyOrderId, medId, quantity, purchasePrice) VALUES 
(501, 101, 100, 8.00),
(502, 102, 150, 20.00),
(503, 103, 200, 12.00),
(504, 104, 120, 14.00);

INSERT INTO prescription (prescId, custId, docFName, docMName, docLName, hospital, prescDate) VALUES 
(601,401, 'Abiyot', 'Tesfaye', 'Negash', 'Black Lion Hospital', '2025-06-01'),
(602,402, 'Selam', 'Fikru', 'Debebe', 'St. Paul Hospital', '2025-06-02'),
(603,403, 'Mulu', 'Samuel', 'Wondimu', 'Zewditu Hospital', '2025-06-03'),
(604,404, 'Tewodros', 'Haile', 'Asfaw', 'Hidar 11 Hospital', '2025-06-04');

INSERT INTO medicinePrescription (prescId, medId) VALUES 
(601, 101),
(602, 102),
(603, 103),
(604, 104);

INSERT INTO customerOrder (ordId, orderDate, empId, custId, pharmacyId) VALUES 
(701,'2025-06-01', 301, 401, 1),
(702,'2025-06-02', 302, 402, 3),
(703,'2025-06-03', 303, 403, 2),
(704,'2025-06-04', 304, 404, 4);

INSERT INTO orderDetail (ordId, medId, quantity, price, discount) VALUES 
(701, 101, 2, 20.00, 0.00),
(702, 102, 3, 76.50, 5.00),
(703, 103, 1, 15.00, 0.00),
(704, 104, 2, 37.50, 2.50);

INSERT INTO bill (ordId, billDay, totalPayment, paid, empId, pharmacyId) VALUES 
(704, '2025-06-15', 34.60, 30.00, 4, 4);

CREATE OR REPLACE FUNCTION CalculateTotalPrice(medId INTEGER, quantity INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    totalPrice DECIMAL;
BEGIN
    SELECT sellingPrice * quantity INTO totalPrice
    FROM medicine
    WHERE medId = medId;
    RETURN totalPrice;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION MedicineStock(medId INTEGER)
RETURNS INTEGER AS $$
DECLARE
    stockQty INTEGER;
BEGIN
    SELECT stockQuantity INTO stockQty
    FROM medicine
    WHERE medId = medId;
    RETURN stockQty;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION CheckMedicineExpiry(medId INTEGER)
RETURNS INTEGER AS $$
DECLARE
    isExpired INTEGER := 0;
    expCount INTEGER;
BEGIN
    SELECT COUNT(*) INTO expCount
    FROM medicine
    WHERE medId = medId AND expiryDate < CURRENT_DATE;
    IF expCount > 0 THEN
        isExpired := 1;
    END IF;
    RETURN isExpired;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE AddEmployee(
    empId INTEGER,
    firstName VARCHAR,
    middleName VARCHAR,
    lastName VARCHAR,
    city VARCHAR,
    subCity VARCHAR,
    kebele INTEGER,
    salary DECIMAL
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO employee (empId, firstName, middleName, lastName, city, subCity, kebele, salary)
    VALUES (empId, firstName, middleName, lastName, city, subCity, kebele, salary);
END;
$$;

CREATE OR REPLACE PROCEDURE UpdateMedicineStock(
    medId INTEGER,
    quantity INTEGER
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE medicine
    SET stockQuantity = stockQuantity + quantity
    WHERE medId = medId;
    IF NOT FOUND THEN
        RAISE NOTICE 'No medicine found with the given medId.';
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE DeleteEmployee(
    empId INTEGER
)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM employee WHERE empId = empId;
END;
$$;

CREATE OR REPLACE FUNCTION trg_UpdateMedicineStock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE medicine
    SET stockQuantity = stockQuantity - NEW.quantity
    WHERE medId = NEW.medId;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_UpdateMedicineStock
AFTER INSERT ON orderDetail
FOR EACH ROW 
EXECUTE FUNCTION trg_UpdateMedicineStock();

CREATE OR REPLACE FUNCTION trg_ValidateMedicineInsert()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.expiryDate < NEW.productionDate THEN
        RAISE EXCEPTION 'Expiry date cannot be earlier than production date';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_ValidateMedicineInsert
BEFORE INSERT ON medicine
FOR EACH ROW 
EXECUTE FUNCTION trg_ValidateMedicineInsert();

CREATE OR REPLACE FUNCTION trg_ValidatePhoneNumber()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.phoneNumber) < 10 OR LENGTH(NEW.phoneNumber) > 13 THEN
        RAISE EXCEPTION 'Phone number must be between 10 and 13 digits.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_ValidatePhoneNumber
BEFORE INSERT OR UPDATE ON pharmacyPhoneNumber
FOR EACH ROW 
EXECUTE FUNCTION trg_ValidatePhoneNumber();

CREATE VIEW CustomerPurchases AS
SELECT c.firstName || ' ' || c.lastName AS customer, o.orderDate, m.medName, od.quantity
FROM customer c
JOIN customerOrder o ON c.custId = o.custId
JOIN orderDetail od ON o.ordId = od.ordId
JOIN medicine m ON od.medId = m.medId;

SELECT * FROM medicine WHERE expiryDate < CURRENT_DATE;
SELECT SUM(quantity) FROM orderDetail WHERE medId = 101;

CREATE ROLE pharmacy_role;
GRANT SELECT, INSERT, UPDATE ON pharmacy TO pharmacy_role;
GRANT SELECT, INSERT, UPDATE ON medicine TO pharmacy_role;
GRANT SELECT, INSERT, UPDATE ON employee TO pharmacy_role;
GRANT SELECT ON customer TO pharmacy_role;
GRANT EXECUTE ON FUNCTION CalculateTotalPrice(INTEGER, INTEGER) TO pharmacy_role;

GRANT EXECUTE ON PROCEDURE AddEmployee TO pharmacy_role;
GRANT EXECUTE ON PROCEDURE UpdateMedicineStock TO pharmacy_role;
GRANT EXECUTE ON PROCEDURE DeleteEmployee TO pharmacy_role;

COMMIT;