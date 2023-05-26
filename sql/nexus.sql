USE master;
GO
DROP DATABASE IF EXISTS NEXUS;
GO
CREATE DATABASE NEXUS;
GO
USE NEXUS;
GO

CREATE TABLE Customers
(
    Id VARCHAR(12) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(11),
    Address NVARCHAR(100),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    City NVARCHAR(50),
    State NVARCHAR(50),
    PostalCode VARCHAR(10),
    SecurityDeposit DECIMAL(10, 2),
    IsHidden BIT
        DEFAULT 0,
    CreatedDate DATETIME
        DEFAULT GETDATE()
);
CREATE TABLE Roles
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    IsHidden BIT
        DEFAULT 0,
    RoleName NVARCHAR(50) NOT NULL
);
CREATE TABLE Employees
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address NVARCHAR(100),
    Username VARCHAR(50),
    Password VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    JoiningDate DATE,
    Salary DECIMAL(10, 2),
	RoleId INT FOREIGN KEY REFERENCES dbo.Roles(Id),
    IsHidden BIT
        DEFAULT 0,
    CreatedDate DATETIME
        DEFAULT GETDATE()
);



CREATE TABLE Plans
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    ConnectionType VARCHAR(50) NOT NULL, -- Dial-Up, Broadband, Landline
    Amount DECIMAL(10, 2) NOT NULL,
    IsHidden BIT
        DEFAULT 0
);

CREATE TABLE PlansOption (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	PlanId INT FOREIGN KEY REFERENCES dbo.Plans(Id),
	OptionName VARCHAR(50)
)
CREATE TABLE PlansDetail
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
	PlansOptionId INT FOREIGN KEY REFERENCES dbo.PlansOption(Id),
    Description VARCHAR(200),
    Duration VARCHAR(20),
    DataLimit DECIMAL(10, 2),
    CallCharges VARCHAR(300),
    Price DECIMAL(10, 2)
);

CREATE TABLE Products
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    ProductName VARCHAR(100),
	ProductImageUrl NVARCHAR(max),
    Description VARCHAR(200),
    Price DECIMAL(10, 2),
    QuantityInStock INT,
    IsHidden BIT
        DEFAULT 0,
    Manufacturer VARCHAR(100),
	ForPlan int FOREIGN KEY REFERENCES dbo.Plans(Id)
);

CREATE TABLE Orders
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID varchar(12) FOREIGN KEY REFERENCES dbo.Customers(Id),
    PlanDetailID INT
        FOREIGN KEY REFERENCES dbo.PlansDetail (Id),
    OrderStatus VARCHAR(50), 
    PaymentMethod NVARCHAR(50),
    OrderDate DATE,
    DeliveryDate DATE
);
CREATE TABLE OrderDetails
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    OrderId INT
        FOREIGN KEY REFERENCES dbo.Orders (Id),
    ProductId INT
        FOREIGN KEY REFERENCES dbo.Products (Id),
    Quantity INT NOT NULL
        DEFAULT 1
);
CREATE TABLE CustomerPlan (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	CustomerId VARCHAR(12) FOREIGN KEY REFERENCES dbo.Customers(Id),
	PlanDetailId INT FOREIGN KEY REFERENCES dbo.PlansDetail(Id)
)
CREATE TABLE Billing
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    CustomerID VARCHAR(12) FOREIGN KEY REFERENCES dbo.Customers(Id),
    BillAmount DECIMAL(10, 2),
    PaymentAmount DECIMAL(10, 2),
    BillingDate DATE,
    PaymentDate DATE,
    PaymentMethod VARCHAR(50)
);
CREATE TABLE BillDetails (
    Id INT PRIMARY KEY Identity(1,1),
    BillingID INT FOREIGN KEY REFERENCES Billing(Id),
	ProductId INT FOREIGN KEY REFERENCES dbo.Products (Id),
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
);
CREATE TABLE Payments
(
    PaymentID INT PRIMARY KEY IDENTITY(1, 1),
    BillingID INT
        FOREIGN KEY REFERENCES Billing (Id),
    Amount DECIMAL(10, 2),
    PaymentDate DATE
        DEFAULT GETDATE(),
);

CREATE TABLE RetailStores
(
    StoreID INT PRIMARY KEY IDENTITY(1, 1),
    StoreName NVARCHAR(100),
    Address NVARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50),
    State bit,
    PostalCode VARCHAR(10),
    ManagerId int FOREIGN KEY REFERENCES dbo.Employees(Id),
);

CREATE TABLE Feedback
(
    FeedbackID INT PRIMARY KEY IDENTITY(1, 1),
    OrderID INT,
    CustomerID varchar(12),
    Rating INT,
    Comments NVARCHAR(200),
    FOREIGN KEY (OrderID) REFERENCES Orders (Id),
    FOREIGN KEY (CustomerID) REFERENCES Customers (Id)
);




INSERT INTO dbo.Roles
(
    IsHidden,
    RoleName
)
VALUES
(   DEFAULT, -- IsHidden - bit
    N'Admin' -- RoleName - nvarchar(50)
    );


INSERT INTO dbo.Roles
(
    IsHidden,
    RoleName
)
VALUES
(   DEFAULT,      -- IsHidden - bit
    N'Accountant' -- RoleName - nvarchar(50)
    );


INSERT INTO dbo.Roles
(
    IsHidden,
    RoleName
)
VALUES
(   DEFAULT,     -- IsHidden - bit
    N'Technical' -- RoleName - nvarchar(50)
    );


INSERT INTO dbo.Roles
(
    IsHidden,
    RoleName
)
VALUES
(   DEFAULT,        -- IsHidden - bit
    N'Retail Store' -- RoleName - nvarchar(50)
    );


INSERT INTO dbo.Employees
(
    FirstName,
    LastName,
    Email,
    Phone,
    Address,
    Username,
    Password,
    DateOfBirth,
    Gender,
    JoiningDate,
    Salary,
    RoleId,
    IsHidden,
    CreatedDate
)
VALUES
(   'Nguyen',             -- FirstName - nvarchar(50)
    'An',                 -- LastName - nvarchar(50)
    'an310898@gmail.com', -- Email - varchar(100)
    '0935263945',         -- Phone - varchar(20)
    '67 Mai Am',          -- Address - nvarchar(100)
    'anns318',            -- Username - varchar(50)
    '123123',             -- Password - varchar(50)
    '1998-08-31',         -- DateOfBirth - date
    'Name',               -- Gender - varchar(10)
    GETDATE(),            -- JoiningDate - date
    '1000',               -- Salary - decimal(10, 2)
    1, DEFAULT,           -- IsHidden - bit
    DEFAULT               -- CreatedDate - datetime
    );



INSERT INTO dbo.Plans
(
    ConnectionType,
    Amount,
    IsHidden
)
VALUES
(   'Dial - up Connection', -- ConnectionType - varchar(50)
    325,                    -- Amount - decimal(10, 2)
    DEFAULT                 -- IsHidden - bit
    );


INSERT INTO dbo.Plans
(
    ConnectionType,
    Amount,
    IsHidden
)
VALUES
(   'Broad Band Connection', -- ConnectionType - varchar(50)
    500,                     -- Amount - decimal(10, 2)
    DEFAULT                  -- IsHidden - bit
    );


INSERT INTO dbo.Plans
(
    ConnectionType,
    Amount,
    IsHidden
)
VALUES
(   'LandLine Connection', -- ConnectionType - varchar(50)
    250,                   -- Amount - decimal(10, 2)
    DEFAULT                -- IsHidden - bit
    );


INSERT INTO dbo.PlansOption
(
    PlanId,
    OptionName
)
VALUES
(   1,             -- PlanId - int
    'Hourly Basis' -- OptionName - varchar(50)
    );

INSERT INTO dbo.PlansOption
(
    PlanId,
    OptionName
)
VALUES
(   1,                 -- PlanId - int
    'Unlimited 28Kbps' -- OptionName - varchar(50)
    );

INSERT INTO dbo.PlansOption
(
    PlanId,
    OptionName
)
VALUES
(   1,                   -- PlanId - int
    'Unlimited 56 Kbps.' -- OptionName - varchar(50)
    );


INSERT INTO dbo.PlansOption
(
    PlanId,
    OptionName
)
VALUES
(   2,             -- PlanId - int
    'Hourly Basis' -- OptionName - varchar(50)
    );

INSERT INTO dbo.PlansOption
(
    PlanId,
    OptionName
)
VALUES
(   2,                  -- PlanId - int
    'Unlimited 64 Kbps' -- OptionName - varchar(50)
    );

INSERT INTO dbo.PlansOption
(
    PlanId,
    OptionName
)
VALUES
(   2,                    -- PlanId - int
    'Unlimited 128 Kbps.' -- OptionName - varchar(50)
    );


INSERT INTO dbo.PlansOption
(
    PlanId,
    OptionName
)
VALUES
(   3,           -- PlanId - int
    'Local Plan' -- OptionName - varchar(50)
    );

INSERT INTO dbo.PlansOption
(
    PlanId,
    OptionName
)
VALUES
(   3,         -- PlanId - int
    'STD Plan' -- OptionName - varchar(50)
    );

INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   1,                                           -- PlansOption - int
    '10 Hrs. - 50$ (validity is for one Month)', -- Description - varchar(200)
    '10 Hrs',                                    -- Duration - varchar(20)
    NULL,                                        -- DataLimit - decimal(10, 2)
    NULL,                                        -- CallCharges - decimal(10, 2)
    '50'                                         -- Price - decimal(10, 2)
    );
INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   1,                                           -- PlansOption - int
    '30 Hrs. - 130$ (validity is for 3 Months)', -- Description - varchar(200)
    '30 Hrs',                                    -- Duration - varchar(20)
    NULL,                                        -- DataLimit - decimal(10, 2)
    NULL,                                        -- CallCharges - decimal(10, 2)
    '130'                                        -- Price - decimal(10, 2)
    );
INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   1,                                           -- PlansOption - int
    '60 Hrs. - 260$ (validity is for 6 Months)', -- Description - varchar(200)
    '60 Hrs',                                    -- Duration - varchar(20)
    NULL,                                        -- DataLimit - decimal(10, 2)
    NULL,                                        -- CallCharges - decimal(10, 2)
    '260'                                        -- Price - decimal(10, 2)
    );




INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   2,               -- PlansOption - int
    'Monthly - 75$', -- Description - varchar(200)
    'Monthly',       -- Duration - varchar(20)
    NULL,            -- DataLimit - decimal(10, 2)
    NULL,            -- CallCharges - decimal(10, 2)
    '75'             -- Price - decimal(10, 2)
    );
INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   2,                  -- PlansOption - int
    'Quarterly - 150$', -- Description - varchar(200)
    'Quarterly',        -- Duration - varchar(20)
    NULL,               -- DataLimit - decimal(10, 2)
    NULL,               -- CallCharges - decimal(10, 2)
    '150'               -- Price - decimal(10, 2)
    );

INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   3,                -- PlansOption - int
    'Monthly - 100$', -- Description - varchar(200)
    'Monthly',        -- Duration - varchar(20)
    NULL,             -- DataLimit - decimal(10, 2)
    NULL,             -- CallCharges - decimal(10, 2)
    '100'             -- Price - decimal(10, 2)
    );
INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   3,                  -- PlansOption - int
    'Quarterly - 180$', -- Description - varchar(200)
    'Quarterly',        -- Duration - varchar(20)
    NULL,               -- DataLimit - decimal(10, 2)
    NULL,               -- CallCharges - decimal(10, 2)
    '180'               -- Price - decimal(10, 2)
    );


INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   4,                                           -- PlansOption - int
    '30 Hrs. - 175$ (validity is for 1 Months)', -- Description - varchar(200)
    '30 Hrs',                                    -- Duration - varchar(20)
    NULL,                                        -- DataLimit - decimal(10, 2)
    NULL,                                        -- CallCharges - decimal(10, 2)
    175                                          -- Price - decimal(10, 2)
    );
INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   4,                                           -- PlansOption - int
    '60 Hrs. - 315$ (validity is for 6 Months)', -- Description - varchar(200)
    '60 Hrs',                                    -- Duration - varchar(20)
    NULL,                                        -- DataLimit - decimal(10, 2)
    NULL,                                        -- CallCharges - decimal(10, 2)
    '315'                                        -- Price - decimal(10, 2)
    );

INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   5,                -- PlansOption - int
    'Monthly - 225$', -- Description - varchar(200)
    'Monthly',        -- Duration - varchar(20)
    NULL,             -- DataLimit - decimal(10, 2)
    NULL,             -- CallCharges - decimal(10, 2)
    225               -- Price - decimal(10, 2)
    );
INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   5,                  -- PlansOption - int
    'Quarterly - 400$', -- Description - varchar(200)
    'Quarterly',        -- Duration - varchar(20)
    NULL,               -- DataLimit - decimal(10, 2)
    NULL,               -- CallCharges - decimal(10, 2)
    400                 -- Price - decimal(10, 2)
    );

INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   6,                -- PlansOption - int
    'Monthly - 350$', -- Description - varchar(200)
    'Monthly',        -- Duration - varchar(20)
    NULL,             -- DataLimit - decimal(10, 2)
    NULL,             -- CallCharges - decimal(10, 2)
    350               -- Price - decimal(10, 2)
    );
INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   6,                  -- PlansOption - int
    'Quarterly - 445$', -- Description - varchar(200)
    'Quarterly',        -- Duration - varchar(20)
    NULL,               -- DataLimit - decimal(10, 2)
    NULL,               -- CallCharges - decimal(10, 2)
    445                 -- Price - decimal(10, 2)
    );


INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   7,                                                            -- PlansOption - int
    'Unlimited - 75$ (Valid for an year and this is the rental)', -- Description - varchar(200)
    'Unlimited',                                                  -- Duration - varchar(20)
    NULL,                                                         -- DataLimit - decimal(10, 2)
    '55cents / minute',                                          -- CallCharges - decimal(10, 2)
    75                                                            -- Price - decimal(10, 2)
    );
INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   7,                                                          -- PlansOption - int
    'Monthly - 35$ (Valid for a month and this is the rental)', -- Description - varchar(200)
    'Monthly',                                                  -- Duration - varchar(20)
    NULL,                                                       -- DataLimit - decimal(10, 2)
    '75cents / minute',                                        -- CallCharges - decimal(10, 2)
    35                                                          -- Price - decimal(10, 2)
    );

INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   8,                                                           -- PlansOptionId - int
    'Monthly - 125$ (Valid for a month and this is the rental)', -- Description - varchar(200)
    'Monthly',                                                   -- Duration - varchar(20)
    NULL,                                                        -- DataLimit - decimal(10, 2)
    'Local : 70cents / minute <br/>STD : 2.25$ / minute <br/>Messaging For Mobiles : 1.00$ / Minute',                         -- CallCharges - varchar(50)
    125                                                          -- Price - decimal(10, 2)
    );


INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   8,                                                               -- PlansOptionId - int
    'Half Yearly - 420$ (Valid for a month and this is the rental)', -- Description - varchar(200)
    'Half Yearly',                                                   -- Duration - varchar(20)
    NULL,                                                            -- DataLimit - decimal(10, 2)
    'Local : 60cents / minute <br/>STD : 2.00$ / minute <br/>Messaging For Mobiles : 1.15$ / Minute',                             -- CallCharges - varchar(50)
    420                                                              -- Price - decimal(10, 2)
    );

INSERT INTO dbo.PlansDetail
(
    PlansOptionId,
    Description,
    Duration,
    DataLimit,
    CallCharges,
    Price
)
VALUES
(   8,                                                               -- PlansOptionId - int
    'Yearly - 700 (Valid for an year and this is the rental)', -- Description - varchar(200)
    'Half Yearly',                                                   -- Duration - varchar(20)
    NULL,                                                            -- DataLimit - decimal(10, 2)
    'Local : 60cents / minute <br />STD : 1.75$ / minute <br/>Messaging For Mobiles : 1.25$ / Minute',                             -- CallCharges - varchar(50)
    700                                                              -- Price - decimal(10, 2)
    );



	INSERT INTO dbo.RetailStores
	(
	    StoreName,
	    Address,
	    Phone,
	    City,
	    State,
	    PostalCode,
	    ManagerId
	)
	VALUES
	(   'Nexus Da Nang', -- StoreName - nvarchar(100)
	    '39 Yen Bai, Da Nang, VietNam', -- Address - nvarchar(100)
	    '0935263945', -- Phone - varchar(20)
	    'Da Nang', -- City - varchar(50)
	    1, -- State - varchar(50)
	    '550000', -- PostalCode - varchar(10)
	    1  -- ManagerId - int
	    )