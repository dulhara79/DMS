CREATE TABLE Supplier (
	supId INT,
	contactName VARCHAR(30),
	address VARCHAR(50),
	phone VARCHAR(10),

	CONSTRAINT PK_supId_Supplier PRIMARY KEY (supID),
)

CREATE TABLE Product (
	productId VARCHAR(10),
	productName VARCHAR(30),
	qty INT NOT NULL,
	unitPrice FLOAT,
	ROL INT,
	supplier INT,

	CONSTRAINT PK_productId_Product PRIMARY KEY (productId),
	CONSTRAINT FK_supplier_Product FOREIGN KEY (supplier) REFERENCES Supplier(SUPiD),
)

CREATE TABLE Customer (
	custId VARCHAR(10) PRIMARY KEY,
	cusName VARCHAR(50),
	address VARCHAR(50),
	phone VARCHAR(10),
	loyalityPoints INT,
)

CREATE TABLE Staff (
	staffId VARCHAR(10) PRIMARY KEY,
	staffName VARCHAR(50),
	phone VARCHAR(10)
)

CREATE TABLE Sales (
	pid VARCHAR(10),
	cid VARCHAR(10),
	sid VARCHAR(10),
	salesDate DATETIME,

	CONSTRAINT PK_pidcidsidsalesDate_Sales PRIMARY KEY(pid, cid, sid, salesDate),
	CONSTRAINT FK_pid_Sales FOREIGN KEY (pid) REFERENCES Product(productID),
	CONSTRAINT FK_cid_Sales FOREIGN KEY (cid) REFERENCES Customer(custId),
	CONSTRAINT FK_sid_Sales FOREIGN KEY (sid) REFERENCES Staff(staffId),
)

INSERT INTO Supplier (supId, contactName, address, phone) VALUES 
(1, 'Ceylon Biscuits Amal Ranjith', 'Ratmalana', '0112111111'),
(2, 'Unilvers Nadeeka Perera', 'Borella', '0114555666');

INSERT INTO Product (productId, productName, qty, unitPrice, ROL, Supplier) VALUES 
('P0001', 'Lemon Puff', 22, 85, 20, 1),
('P0201', 'Knor Soup', 8, 100, 10, 2),
('P0084', 'Lipton Ceylonta', 12, 125, 15, 2),
('P0222', 'chocolate fingers', 14, 50, 8, 1);

INSERT INTO Customer (custId, cusName, address, phone, loyalityPoints) VALUES
('C100', 'Ravi Perera', 'Colombo', '0112123456', 1200),
('C101', 'Nimali Alwis', 'Gampaha', '0332212345', 275);

INSERT INTO Staff (staffId, staffName, phone) VALUES 
('S001', 'Kamal Silva', '0718123456'),
('S002', 'Amila Namal', '0714222222');

INSERT INTO Sales (pid, cid, sid, salesDate) values
('P0201', 'C100', 'S001', 13/11/2015),
('P0222', 'C101', 'S002', 22/11/2015),
('P0084', 'C100', 'S001', 01/12/2015),
('P0201', 'C100', 'S002', 08/12/2015);