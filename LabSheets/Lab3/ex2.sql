--------

-- NOT COMPLETE YET

--------

CREATE TABLE Bank (
	code varchar(10),
    registration varchar(10),
    name varchar(50),
    
    constraint pk_code_Bank primary key (code)
);

CREATE TABLE Branch (
	bra_num varchar(10),
    code varchar(10),
    name char(50),
    address varchar(100),
    
    constraint pk_bra_numcode_Branch primary key (bra_num, code)
);

CREATE TABLE Account_Type (
	accType_code varchar(10) primary key,
    name varchar(50),
    description varchar(200)
);

CREATE TABLE Savings (
	accType_code varchar(10) primary key,
    interest_rate float,
    
    constraint fk_accType_Savings foreign key (accType_code) references Account_Type(accType_code)
);

CREATE TABLE CurrentAcc (
	accType_code varchar(10) primary key,
    maxCheques int,
    
	constraint fk_accType_CurrentAcc foreign key (accType_code) references Account_Type(accType_code)
);

CREATE TABLE Customer (
	number varchar(10),
    NIC varchar(10),
    name varchar(50),
    phone varchar(10),
    address varchar(200),
    PIN int,
    
    constraint pk_number_Customer primary key (number)
);

CREATE TABLE Transactions (
	tid varchar(10) primary key,
    date_time datetime,
    executed_by varchar(10),
    description varchar(200),
    amount float
);

CREATE TABLE Account (
	account_no varchar(10),
    branch_number varchar(10),
    code varchar(10),
    accType_code varchar(10),
    balance float,

   constraint pk_account_no_Account primary key (account_no),
   constraint fk_branch_numbercode_Account foreign key (branch_number, code) references Branch(bra_num, code),
   constraint fk_accType_code_Account foreign key (accType_code) references Account_Type(accType_code)
);

CREATE TABLE Belongs_to (
	number varchar(10),
    account_no varchar(10),
    
	constraint pk_numberaccount_no_Belongs_to primary key (number, account_no),
    constraint fk_number_Belongs_to foreign key (number) references customer(number),
	constraint fk_account_no_Belongs_to foreign key (account_no) references Account(account_no)
);

CREATE TABLE Has (
	account_no varchar(10),
    tid varchar(10),
    type varchar(20),
    
    constraint pk_account_no_tid_Has primary key (account_no, tid),
    constraint fk_accout_no_Has foreign key (account_no) references Account(account_no),
    constraint fk_tid_Has foreign key (tid) references Transactions(tid)
);

-- Insert data into Bank table
INSERT INTO Bank (code, registration, name)
VALUES 
('B001', 'REG001', 'Sampath Bank'),
('B002', 'REG002', 'Mhajana Bank'),
('B003', 'REG003', 'Commercial Bank');

-- Insert data into Branch table
INSERT INTO Branch (bra_num, code, name, address)
VALUES 
('BR001', 'B001', 'Homagama', '123/2Homagama'),
('BR002', 'B001', 'Malabe', '453/5 Malabe'),
('BR003', 'B002', 'Pettah', '1/2/3 Pettah');

-- Insert data into Account_Type table
INSERT INTO Account_Type (accType_code, name, description)
VALUES 
('AT001', 'Savings Account', 'An account that allows you to save money'),
('AT002', 'Current Account', 'An account for day-to-day transactions'),
('AT003', 'Saving Account', 'An account that allows you to save money'),
('AT004', 'Current Account', 'An account for day-to-day transactions');

-- Insert data into Savings table
INSERT INTO Savings (accType_code, interest_rate)
VALUES 
('AT001', 5.0),
('AT003', 2.5);

-- Insert data into CurrentAcc table
INSERT INTO CurrentAcc (accType_code, maxCheques)
VALUES 
('AT002', 50),
('AT004', 100);

-- Insert data into Customer table
INSERT INTO Customer (number, NIC, name, phone, address, PIN)
VALUES 
('C001', '123456789V', 'Will Smith', '1234567890', '456 New York', 1234),
('C002', '987654321V', 'Kalhara', '9876543210', '123 Meegoda', 5678),
('C003', '123123123V', 'Nuwan Pradeep', '5555555555', '321 Malabe', 9012);

-- Insert data into Transactions table
INSERT INTO Transactions (tid, date_time, executed_by, description, amount)
VALUES 
('T001', 2024/02/17, 'C001', 'Deposit', 1000),
('T002', 2024/02/17, 'C002', 'Withdrawal', 500),
('T003', 2024/02/17, 'C003', 'Transfer', 200);

-- Insert data into Account table
INSERT INTO Account (account_no, branch_number, code, accType_code, balance)
VALUES 
('ACC001', 'BR001', 'B001', 'AT001', 5000),
('ACC002', 'BR002', 'B001', 'AT002', 3000),
('ACC003', 'BR003', 'B002', 'AT003', 10000);

-- Insert data into Belongs_to table
INSERT INTO Belongs_to (number, account_no)
VALUES 
('C001', 'ACC001'),
('C002', 'ACC002'),
('C003', 'ACC003');

-- Insert data into Has table
INSERT INTO Has (account_no, tid, type)
VALUES 
('ACC001', 'T001', 'Deposit'),
('ACC002', 'T002', 'Withdrawal'),
('ACC003', 'T003', 'Transfer');
