USE master;
GO
DROP DATABASE IF EXISTS NEXUS;
GO
CREATE DATABASE NEXUS;
GO
USE NEXUS;
GO


CREATE TABLE CityAvailable(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50),
	PostalCode VARCHAR(10),
	IsHidden BIT DEFAULT 0
)
CREATE TABLE Customers
(
    Id VARCHAR(12) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(11),
    Address NVARCHAR(100),
    CityId INT FOREIGN KEY REFERENCES dbo.CityAvailable(Id),
    State NVARCHAR(50),
    SecurityDeposit DECIMAL(10, 2),
    CreatedDate DATETIME
        DEFAULT GETDATE()
);
CREATE TABLE Roles
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL
);

CREATE TABLE Employees
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20) UNIQUE,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    JoiningDate DATE DEFAULT GETDATE(),
    Salary DECIMAL(10, 2),
    RoleId INT
        FOREIGN KEY REFERENCES dbo.Roles (Id),
    State VARCHAR(50),
	CityId INT FOREIGN KEY REFERENCES dbo.CityAvailable(id),
    CreatedDate DATE
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

CREATE TABLE PlansOption
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    PlanId INT
        FOREIGN KEY REFERENCES dbo.Plans (Id),
    OptionName VARCHAR(50)
);
CREATE TABLE PlansDetail
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    PlansOptionId INT
        FOREIGN KEY REFERENCES dbo.PlansOption (Id),
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
    ProductImageUrl NVARCHAR(MAX),
    Description VARCHAR(MAX),
    Price DECIMAL(10, 2),
    QuantityInStock INT,
    IsHidden BIT
        DEFAULT 0,
    Manufacturer VARCHAR(100),
    ForPlan INT
        FOREIGN KEY REFERENCES dbo.Plans (Id),
	CreatedDate DATE DEFAULT GETDATE()
);

CREATE TABLE Orders
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID VARCHAR(12)
        FOREIGN KEY REFERENCES dbo.Customers (Id),
    OrderStatus VARCHAR(50),
    PaymentMethod NVARCHAR(50),
    OrderDate DATE,
    DeliveryDate DATE
);





CREATE TABLE CustomerPlan
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerId VARCHAR(12)
        FOREIGN KEY REFERENCES dbo.Customers (Id),
		PlanId INT FOREIGN KEY REFERENCES dbo.Plans(id),
		PlanOption INT FOREIGN KEY REFERENCES dbo.PlansOption(id),
    PlanDetailId INT FOREIGN KEY REFERENCES dbo.PlansDetail (Id),
	ProductId INT FOREIGN KEY REFERENCES dbo.Products(Id)
);
CREATE TABLE Billing
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    CustomerID VARCHAR(12)
        FOREIGN KEY REFERENCES dbo.Customers (Id),
    BillAmount DECIMAL(10, 3),
    BillingDate DATE,
    PaymentDate DATE,
    PaymentMethod VARCHAR(50)
);
--drop TABLE BillDetails
--(
--    Id INT PRIMARY KEY IDENTITY(1, 1),
--    BillingID INT
--        FOREIGN KEY REFERENCES Billing (Id),
--    ProductId INT
--        FOREIGN KEY REFERENCES dbo.Products (Id),
--    Quantity INT,
--    TotalPrice DECIMAL(10, 2),
--);
--drop TABLE Payments
--(
--    PaymentID INT PRIMARY KEY IDENTITY(1, 1),
--    BillingID INT
--        FOREIGN KEY REFERENCES Billing (Id),
--    Amount DECIMAL(10, 2),
--    PaymentDate DATE
--        DEFAULT GETDATE(),
--);

CREATE TABLE RetailStores
(
    StoreID INT PRIMARY KEY IDENTITY(1, 1),
    StoreName NVARCHAR(100),
    Address NVARCHAR(100),
    Phone VARCHAR(20),
    CityId INT FOREIGN KEY REFERENCES CityAvailable(Id),
    State VARCHAR(50),
    ManagerId INT
        FOREIGN KEY REFERENCES dbo.Employees (Id),
);

CREATE TABLE Feedback
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    OrderID INT,
    CustomerID VARCHAR(12),
	[Subject] NVARCHAR(100),
    Comments NVARCHAR(1000),
	CreatedDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (OrderID) REFERENCES Orders (Id),
    FOREIGN KEY (CustomerID) REFERENCES Customers (Id)
);

CREATE TABLE EmployeeToken (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeId INT FOREIGN KEY REFERENCES dbo.Employees(Id),
	Token VARCHAR(40) DEFAULT REPLACE(NEWID(),'-',''),
	Expired DATETIME DEFAULT DATEADD(DAY,1,GETDATE())
)


CREATE TABLE Author
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    PermissionName VARCHAR(50)
);
CREATE TABLE RoleAuthorization
(
    RoleId INT
        FOREIGN KEY REFERENCES dbo.Roles (Id),
    AuthorizationId INT
        FOREIGN KEY REFERENCES dbo.Author (Id)
);

INSERT INTO dbo.CityAvailable
(
    Name,
    PostalCode
)
VALUES
(   'Da Nang', -- Name - nvarchar(50)
    '50000'  -- PostalCode - varchar(10)
    )
	INSERT INTO dbo.CityAvailable
	(
	    Name,
	    PostalCode
	)
	VALUES
	(   'Ha Noi', -- Name - nvarchar(50)
	    '14000'  -- PostalCode - varchar(10)
	    )

INSERT INTO dbo.Roles
(
    RoleName
)
VALUES
(N'Admin' -- RoleName - nvarchar(50)
    );


INSERT INTO dbo.Roles
(
    RoleName
)
VALUES
(N'Accountant' -- RoleName - nvarchar(50)
    );


INSERT INTO dbo.Roles
(
    RoleName
)
VALUES
(N'Technical' -- RoleName - nvarchar(50)
    );


INSERT INTO dbo.Roles
(
    RoleName
)
VALUES
(N'Retail Store' -- RoleName - nvarchar(50)
    );


INSERT INTO dbo.Employees
(
    FirstName,
    LastName,
    Email,
    Phone,
    Username,
    Password,
    DateOfBirth,
    JoiningDate,
    Salary,
	CityId,
    RoleId,
	State,
    CreatedDate
)
VALUES
(   'Nguyen',             -- FirstName - nvarchar(50)
    'An',                 -- LastName - nvarchar(50)
    'an310898@gmail.com', -- Email - varchar(100)
    '0935263945',         -- Phone - varchar(20)
    'anns318',            -- Username - varchar(50)
    '123123',             -- Password - varchar(50)
    '1998-08-31',         -- DateOfBirth - date
    GETDATE(),            -- JoiningDate - date
    '1000',               -- Salary - decimal(10, 2)
	1,
	1,
	'Active',
    DEFAULT               -- CreatedDate - datetime
    );

	INSERT INTO dbo.Employees
(
    FirstName,
    LastName,
    Email,
    Phone,
    Username,
    Password,
    DateOfBirth,
    JoiningDate,
    Salary,
	CityId,
    RoleId,
	State,
    CreatedDate
)
VALUES
(   'Nguyen',             -- FirstName - nvarchar(50)
    'accountant',                 -- LastName - nvarchar(50)
    'accountant@gmail.com', -- Email - varchar(100)
    '0935263944',         -- Phone - varchar(20)
    'accountant',            -- Username - varchar(50)
    '123123',             -- Password - varchar(50)
    '1998-08-31',         -- DateOfBirth - date
    GETDATE(),            -- JoiningDate - date
    '1000',               -- Salary - decimal(10, 2)
	1,
	2,
	'Active',
    DEFAULT               -- CreatedDate - datetime
    );

INSERT INTO dbo.Employees
(
    FirstName,
    LastName,
    Email,
    Phone,
    Username,
    Password,
    DateOfBirth,
    JoiningDate,
    Salary,
	CityId,
    RoleId,
	State,
    CreatedDate
)
VALUES
(   'Nguyen',             -- FirstName - nvarchar(50)
    'technical',                 -- LastName - nvarchar(50)
    'technical@gmail.com', -- Email - varchar(100)
    '0935263943',         -- Phone - varchar(20)
    'technical',            -- Username - varchar(50)
    '123123',             -- Password - varchar(50)
    '1998-08-31',         -- DateOfBirth - date
    GETDATE(),            -- JoiningDate - date
    '1000',               -- Salary - decimal(10, 2)
	1,
	3,
	'Active',
    DEFAULT               -- CreatedDate - datetime
    );

INSERT INTO dbo.Employees
(
    FirstName,
    LastName,
    Email,
    Phone,
    Username,
    Password,
    DateOfBirth,
    JoiningDate,
    Salary,
	CityId,
    RoleId,
	State,
    CreatedDate
)
VALUES
(   'Nguyen',             -- FirstName - nvarchar(50)
    'store',                 -- LastName - nvarchar(50)
    'store@gmail.com', -- Email - varchar(100)
    '0935263941',         -- Phone - varchar(20)
    'store',            -- Username - varchar(50)
    '123123',             -- Password - varchar(50)
    '1998-08-31',         -- DateOfBirth - date
    GETDATE(),            -- JoiningDate - date
    '1000',               -- Salary - decimal(10, 2)
	1,
	4,
	'Active',
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
    '55cents / minute',                                           -- CallCharges - decimal(10, 2)
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
    '75cents / minute',                                         -- CallCharges - decimal(10, 2)
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
(   8,                                                                                                -- PlansOptionId - int
    'Monthly - 125$ (Valid for a month and this is the rental)',                                      -- Description - varchar(200)
    'Monthly',                                                                                        -- Duration - varchar(20)
    NULL,                                                                                             -- DataLimit - decimal(10, 2)
    'Local : 70cents / minute <br/>STD : 2.25$ / minute <br/>Messaging For Mobiles : 1.00$ / Minute', -- CallCharges - varchar(50)
    125                                                                                               -- Price - decimal(10, 2)
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
(   8,                                                                                                -- PlansOptionId - int
    'Half Yearly - 420$ (Valid for a month and this is the rental)',                                  -- Description - varchar(200)
    'Half Yearly',                                                                                    -- Duration - varchar(20)
    NULL,                                                                                             -- DataLimit - decimal(10, 2)
    'Local : 60cents / minute <br/>STD : 2.00$ / minute <br/>Messaging For Mobiles : 1.15$ / Minute', -- CallCharges - varchar(50)
    420                                                                                               -- Price - decimal(10, 2)
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
(   8,                                                                                                 -- PlansOptionId - int
    'Yearly - 700 (Valid for an year and this is the rental)',                                         -- Description - varchar(200)
    'Half Yearly',                                                                                     -- Duration - varchar(20)
    NULL,                                                                                              -- DataLimit - decimal(10, 2)
    'Local : 60cents / minute <br />STD : 1.75$ / minute <br/>Messaging For Mobiles : 1.25$ / Minute', -- CallCharges - varchar(50)
    700                                                                                                -- Price - decimal(10, 2)
    );



INSERT INTO dbo.RetailStores
(
    StoreName,
    Address,
    Phone,
    CityId,
    State,
    ManagerId
)
VALUES
(   'Nexus Da Nang',                -- StoreName - nvarchar(100)
    '39 Yen Bai, Da Nang, VietNam', -- Address - nvarchar(100)
    '0935263945',                   -- Phone - varchar(20)
    1,								-- City - varchar(50)
    'Active',                              -- State - bit
    1                               -- ManagerId - int
    );



INSERT INTO dbo.RetailStores
(
    StoreName,
    Address,
    Phone,
    CityId,
    State,
    ManagerId
)
VALUES
(   'Nexus Ha Noi',                -- StoreName - nvarchar(100)
    '39 Yen Bai, Ha Noi, VietNam', -- Address - nvarchar(100)
    '0935263945',                  -- Phone - varchar(20)
    2,                      -- City - varchar(50)
    'Active',                             -- State - bit
    1                              -- ManagerId - int
    );

	SET IDENTITY_INSERT dbo.Products ON
	INSERT INTO dbo.Products
	(
		Id,
	    ProductName,
	    ProductImageUrl,
	    Description,
	    Price,
	    QuantityInStock,
	    IsHidden,
	    Manufacturer,
	    ForPlan
	)
	VALUES
	(	0,
		NULL,    -- ProductName - varchar(100)
	    NULL,    -- ProductImageUrl - nvarchar(max)
	    NULL,    -- Description - varchar(max)
	    0,    -- Price - decimal(10, 2)
	    NULL,    -- QuantityInStock - int
	    DEFAULT, -- IsHidden - bit
	    NULL,    -- Manufacturer - varchar(100)
	    NULL     -- ForPlan - int
	    )
	SET IDENTITY_INSERT dbo.Products OFF

INSERT INTO dbo.Products
(
    ProductName,
    ProductImageUrl,
    Description,
    Price,
    QuantityInStock,
    IsHidden,
    Manufacturer,
    ForPlan
)
VALUES
(   'US Robotics Serial Controller Dial-Up External Fax/Modem',                                                                                                                                                                                                                                                                                              -- ProductName - varchar(100)
    'https://www.bhphotovideo.com/images/images750x750/us_robotics_usr5686g_serial_controller_dial_up_external_1297751.jpg',                                                                                                                                                                                                                                 -- ProductImageUrl - nvarchar(max)
    'With support for both V.92, V.22, and a variety of other networking protocols, the Serial Controller Dial-Up External Fax/Modem from US Robotics is designed for use with Point of Sale (PoS) systems and other devices suited to operate with a 56K modem. This external fax/modem comes equipped with an 8 position DIP switch, multiple LED status', -- Description - varchar(200)
    112.99,                                                                                                                                                                                                                                                                                                                                                  -- Price - decimal(10, 2)
    5,                                                                                                                                                                                                                                                                                                                                                       -- QuantityInStock - int
    DEFAULT,                                                                                                                                                                                                                                                                                                                                                 -- IsHidden - bit
    'US Robotics',                                                                                                                                                                                                                                                                                                                                           -- Manufacturer - varchar(100)
    1                                                                                                                                                                                                                                                                                                                                                        -- ForPlan - int
    );


INSERT INTO dbo.Products
(
    ProductName,
    ProductImageUrl,
    Description,
    Price,
    QuantityInStock,
    IsHidden,
    Manufacturer,
    ForPlan
)
VALUES
(   'NETGEAR - Nighthawk 32 x 8 DOCSIS 3.1 Voice Cable Modem',                                                                                                                                                                                                                                                                                                                                                                                   -- ProductName - varchar(100)
    'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6425/6425815_rd.jpg',                                                                                                                                                                                                                                                                                                                                                        -- ProductImageUrl - nvarchar(max)
    'This NETGEAR Nighthawk ultra-high-speed cable modem for Xfinity Voice (CM2050V) delivers the gigabit-speed cable Internet and perfect call clarity. This DOCSIS 3.1 cable modem with voice supports all of today''s Internet service plans and is designed for the high-performance Internet in the future. CM2050V includes two telephone ports that automatically prioritize voice over the Internet for clear and uninterrupted calls.', -- Description - varchar(200)
    322.99,                                                                                                                                                                                                                                                                                                                                                                                                                                      -- Price - decimal(10, 2)
    10,                                                                                                                                                                                                                                                                                                                                                                                                                                          -- QuantityInStock - int
    0,                                                                                                                                                                                                                                                                                                                                                                                                                                           -- IsHidden - bit
    'NETGEAR',                                                                                                                                                                                                                                                                                                                                                                                                                                   -- Manufacturer - varchar(100)
    2                                                                                                                                                                                                                                                                                                                                                                                                                                            -- ForPlan - int
    );

INSERT INTO dbo.Products
(
    ProductName,
    ProductImageUrl,
    Description,
    Price,
    QuantityInStock,
    IsHidden,
    Manufacturer,
    ForPlan
)
VALUES
(   'Motorola - MG7700 24x8 DOCSIS 3.0 Cable Modem + AC1900 Router - Black',                                                                                                                                                                                                                                                                                                                                                                                                                                                                   -- ProductName - varchar(100)
    'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6298/6298663ld.jpg',                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ProductImageUrl - nvarchar(max)
    'The Motorola MG7700 24x8 DOCSIS 3.0 cable modem + AC1900 dual-band (2.4GHz and 5GHz) Wi-Fi Gigabit router with four Gigabit (GigE) Ethernet ports, power boost Wi-Fi amplifiers, firewall security, and more. Power Boost technology amplifies the wireless signal to the limit set by the Federal Communications Commission (FCC) to deliver higher WiFi speeds and extend the WiFi range. AnyBeam WiFi beamforming at 2.4 GHz and 5 GHz focuses the wireless signal on your wireless devices to further enhance wireless performance.', -- Description - varchar(200)
    164.99,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    -- Price - decimal(10, 2)
    10,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        -- QuantityInStock - int
    0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         -- IsHidden - bit
    'Motorola',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                -- Manufacturer - varchar(100)
    2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          -- ForPlan - int
    );

INSERT INTO dbo.Products
(
    ProductName,
    ProductImageUrl,
    Description,
    Price,
    QuantityInStock,
    IsHidden,
    Manufacturer,
    ForPlan
)
VALUES
(   'NETGEAR - Nighthawk AC3200 Wi-Fi Router with DOCSIS 3.1 Cable Modem',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        -- ProductName - varchar(100)
    'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6345/6345937_sd.jpg',                                                                                                                                                                                                                                                                                                                                                                                                                                                                         -- ProductImageUrl - nvarchar(max)
    'This NETGEAR® Nighthawk® X4S AC3200 Wi-Fi DOCSIS® 3.1 ultra-high-speed cable modem router works with the fast DOCSIS® 3.0 and is ready for new DOCSIS® 3.1 Gigabit Internet speeds. The NETGEAR X4S DOCSIS® 3.1 cable modem router with 32 x 8 channel bonding (in DOCSIS® 3.0 mode) offers fast Internet speeds that rival the speed of fiber. Enjoy a quality experience for streaming multiple HD-quality videos to multiple devices, VR gaming and more. Ideal for fast Internet cable services, such as XFINITY® from Comcast and Cox Internet plans.', -- Description - varchar(200)
    343.99,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- Price - decimal(10, 2)
    10,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           -- QuantityInStock - int
    0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            -- IsHidden - bit
    'Motorola',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   -- Manufacturer - varchar(100)
    2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             -- ForPlan - int
    );


INSERT INTO dbo.Products
(
    ProductName,
    ProductImageUrl,
    Description,
    Price,
    QuantityInStock,
    IsHidden,
    Manufacturer,
    ForPlan
)
VALUES
(   'VTech - Amplified Corded/Cordless Answering System with Big Buttons Display - White',                                                                                                                                                                                                                                                                                                                                    -- ProductName - varchar(100)
    'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6385/6385823_rd.jpg',                                                                                                                                                                                                                                                                                                                                     -- ProductImageUrl - nvarchar(max)
    'Designed for seniors or the hearing impaired, the VTech SN5147 Amplified Corded/Cordless Senior Phone System with 90dB Extra Loud Visual Ringer, Big Buttons & Large Display comes with features to make hearing and dialing calls easier than ever. With big butttons, large displays, and a full-duplex speakerphone on each device, this senior-friendly telephone system takes the guesswork out of dialing calls.', -- Description - varchar(200)
    96.99,                                                                                                                                                                                                                                                                                                                                                                                                                    -- Price - decimal(10, 2)
    10,                                                                                                                                                                                                                                                                                                                                                                                                                       -- QuantityInStock - int
    0,                                                                                                                                                                                                                                                                                                                                                                                                                        -- IsHidden - bit
    'VTech',                                                                                                                                                                                                                                                                                                                                                                                                                  -- Manufacturer - varchar(100)
    3                                                                                                                                                                                                                                                                                                                                                                                                                         -- ForPlan - int
    );


INSERT INTO dbo.Products
(
    ProductName,
    ProductImageUrl,
    Description,
    Price,
    QuantityInStock,
    IsHidden,
    Manufacturer,
    ForPlan
)
VALUES
(   'VTech - CM18045 DECT 6.0 Cordless Expansion Handset Only - Silver',                                                                                                                                                                                  -- ProductName - varchar(100)
    'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/4571/4571502_ra.jpg',                                                                                                                                                                 -- ProductImageUrl - nvarchar(max)
    'This VTech CM18045 DECT 6.0 cordless expansion handset features an extra-large display for easy viewing and a 50 name-and-number caller ID history for convenient callback. The full-duplex speakerphone lets both parties speak at the same time.', -- Description - varchar(200)
    51.99,                                                                                                                                                                                                                                                -- Price - decimal(10, 2)
    10,                                                                                                                                                                                                                                                   -- QuantityInStock - int
    0,                                                                                                                                                                                                                                                    -- IsHidden - bit
    'VTech',                                                                                                                                                                                                                                              -- Manufacturer - varchar(100)
    3                                                                                                                                                                                                                                                     -- ForPlan - int
    );

INSERT INTO dbo.Products
(
    ProductName,
    ProductImageUrl,
    Description,
    Price,
    QuantityInStock,
    IsHidden,
    Manufacturer,
    ForPlan
)
VALUES
(   'VTech - 5 Handset Connect to Cell Answering System with Super Long Range - Silver and Black',                                                                                                                                                                                                                                                                                                                                                                                                  -- ProductName - varchar(100)
    'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6406/6406779_rd.jpg',                                                                                                                                                                                                                                                                                                                                                                                                           -- ProductImageUrl - nvarchar(max)
    'Experience the industy''s best cordless range with the VTech IS8151-5 DECT 6.0 Expandable Cordless Phone featuring Super Long Range, Bluetooth Connect to Cell and Smart Call Blocker, you won''t have to worry about unwanted calls waking you up in the middle of the night or tying up the line. Robocalls are automatically blocked from ever ringing through—even the first time. You can also permanently blacklist any number you want with one touch. With up to 2300 feet or range.', -- Description - varchar(200)
    132.99,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         -- Price - decimal(10, 2)
    10,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             -- QuantityInStock - int
    0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              -- IsHidden - bit
    'VTech',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        -- Manufacturer - varchar(100)
    3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               -- ForPlan - int
    );

	
INSERT INTO dbo.Author
(
    PermissionName
)
VALUES
('Employee' -- PermissionName - varchar(50)
    );

INSERT INTO dbo.Author
(
    PermissionName
)
VALUES
('Customer' -- PermissionName - varchar(50)
    );

INSERT INTO dbo.Author
(
    PermissionName
)
VALUES
('Bill' -- PermissionName - varchar(50)
    );
INSERT INTO dbo.Author
(
    PermissionName
)
VALUES
('Order' -- PermissionName - varchar(50)
    );
INSERT INTO dbo.Author
(
    PermissionName
)
VALUES
('Product' -- PermissionName - varchar(50)
    );
INSERT INTO dbo.Author
(
    PermissionName
)
VALUES
('Retail Store' -- PermissionName - varchar(50)
    );
INSERT INTO dbo.Author
(
    PermissionName
)
VALUES
('Available City' -- PermissionName - varchar(50)
    );
INSERT INTO dbo.Author
(
    PermissionName
)
VALUES
('Feedback' -- PermissionName - varchar(50)
    )
INSERT INTO dbo.RoleAuthorization
(
    RoleId,
    AuthorizationId
)
SELECT 1,
       Id
FROM Author;


USE NEXUS;
GO



CREATE PROCEDURE getAllEmp
AS
BEGIN
    SELECT Id,
           FirstName,
           LastName,
           Email,
           Phone,
           Username,
           Password,
           DateOfBirth,
           Gender,
           JoiningDate,
           State,
           Salary,
           CreatedDate
    FROM dbo.Employees;
END;
GO

CREATE PROCEDURE getAllPlan
AS
BEGIN
    SELECT P.Id,
           P.ConnectionType,
           P.Amount
    FROM dbo.Plans P;

END;

GO
CREATE PROCEDURE checkAvailableZipCode @ZipOrCityName VARCHAR(50)
AS
BEGIN
    IF EXISTS
    (
        SELECT TOP 1
               *
        FROM dbo.CityAvailable
        WHERE PostalCode = @ZipOrCityName
              OR Name = @ZipOrCityName
                 AND IsHidden = 0
    )
    BEGIN
        SELECT 1 AS result;
        RETURN;
    END;

    SELECT 0 AS result;


END;
GO

CREATE PROCEDURE getPlanOptionByPlanId @PlanId INT
AS
BEGIN
    SELECT Id,
           OptionName
    FROM dbo.PlansOption
    WHERE PlanId = @PlanId;
END;

GO

CREATE PROCEDURE getPlanDetailByPlanOptionId @PlanOptionId INT
AS
BEGIN
    SELECT *
    FROM dbo.PlansDetail
    WHERE PlansOptionId = @PlanOptionId;
END;

GO

CREATE PROCEDURE getProductForPlan @PlanId INT
AS
BEGIN
    SELECT Id,
           ProductName,
           ProductImageUrl,
           Description,
           Price,
           QuantityInStock,
           IsHidden,
           Manufacturer
    FROM dbo.Products
    WHERE ForPlan = @PlanId;
END;

GO

CREATE PROCEDURE getAvailableCity
AS
BEGIN
    SELECT Id,
           Name
    FROM dbo.CityAvailable
    WHERE IsHidden = 0;
END;
GO

GO

CREATE FUNCTION GenerateCusID
(
    @Prefix NVARCHAR(10),
    @Id INT,
    @Length INT,
    @PaddingChar CHAR(1) = '0'
)
RETURNS NVARCHAR(MAX)
AS
BEGIN

    RETURN
    (
        SELECT @Prefix + RIGHT(REPLICATE(@PaddingChar, @Length) + CAST(@Id AS NVARCHAR(10)), @Length)
    );

END;
GO

CREATE PROCEDURE addNewCustomer
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email VARCHAR(50),
    @Phone VARCHAR(11),
    @Address NVARCHAR(100),
    @CityId INT,
    @PlanId INT,
    @PlanOptionId INT,
    @PlanDetailId INT,
    @ProductId INT,
    @PaymentMethod VARCHAR(50)
AS
BEGIN

    IF (@PlanId = 0 OR @PlanDetailId = 0)
    BEGIN
        RETURN;
    END;

    DECLARE @NewNumber INT =
            (
                SELECT MAX(RIGHT(Id, 9))FROM dbo.Customers
            ),
            @Prefix VARCHAR(1) =
            (
                SELECT TOP 1 LEFT(ConnectionType, 1)FROM dbo.Plans WHERE Id = @PlanId
            );
    DECLARE @CusId NVARCHAR(20) =
            (
                SELECT dbo.GenerateCusID(@Prefix, IIF(@NewNumber IS NULL, (SELECT 1), (@NewNumber + 1)), 9, '0')
            );


    DECLARE @InstallCharge DECIMAL(10, 3) =
            (
                SELECT TOP 1
                       Amount + (Amount * 12.5 / 100)
                FROM dbo.Plans
                WHERE Id = @PlanId
            ),
            @MonthlyCharge DECIMAL(10, 3) =
            (
                SELECT TOP 1
                       Price + (Price * 12.5 / 100)
                FROM dbo.PlansDetail
                WHERE Id = @PlanDetailId
            ),
            @ProductCharge DECIMAL(10, 3) =
            (
                SELECT Price FROM dbo.Products WHERE Id = @ProductId
            );




    DECLARE @TotalCharge DECIMAL(10, 3) = @InstallCharge + @ProductCharge;


    INSERT INTO dbo.Customers
    (
        Id,
        FirstName,
        LastName,
        Email,
        Phone,
        Address,
        CityId,
        State,
        SecurityDeposit,
        CreatedDate
    )
    VALUES
    (   @CusId,     -- Id - varchar(12)
        @FirstName, -- FirstName - nvarchar(50)
        @LastName,  -- LastName - nvarchar(50)
        @Email,     -- Email - varchar(100)
        @Phone,     -- Phone - varchar(11)
        @Address,   -- Address - nvarchar(100)
        @CityId,    -- CityId - int
        'Active',   -- State - nvarchar(50)
        0,          -- SecurityDeposit - decimal(10, 2)
        DEFAULT     -- CreatedDate - datetime
        );

    INSERT INTO dbo.CustomerPlan
    (
        CustomerId,
        PlanId,
        PlanOption,
        PlanDetailId,
        ProductId
    )
    VALUES
    (   @CusId,        -- CustomerId - varchar(12)
        @PlanId,       -- PlanId - int
        @PlanOptionId, -- PlanOption - int
        @PlanDetailId, -- PlanDetailId - int
        @ProductId);


    INSERT INTO dbo.Orders
    (
        CustomerID,
        OrderStatus,
        PaymentMethod,
        OrderDate,
        DeliveryDate
    )
    VALUES
    (   @CusId,         -- CustomerID - varchar(12)
        'Pending',      -- OrderStatus - varchar(50)
        @PaymentMethod, -- PaymentMethod - nvarchar(50)
        GETDATE(),      -- OrderDate - date
        NULL            -- DeliveryDate - date
        );

    INSERT INTO dbo.Billing
    (
        CustomerID,
        BillAmount,
        BillingDate,
        PaymentDate,
        PaymentMethod
    )
    VALUES
    (   @CusId,                                                               -- CustomerID - varchar(12)
        @TotalCharge,                                                         -- BillAmount - decimal(10, 2)
        GETDATE(),                                                            -- BillingDate - date
        IIF(@PaymentMethod = 'Cash On Delivery', (SELECT NULL), (GETDATE())), -- PaymentDate - date
        @PaymentMethod                                                        -- PaymentMethod - varchar(50)
        );

    SELECT @CusId AS CustomerId;
END;
GO



CREATE PROCEDURE updateCustomerInfo
    @id VARCHAR(11),
    @firstName NVARCHAR(50),
    @lastName NVARCHAR(50),
    @email VARCHAR(150),
    @phone VARCHAR(11),
    @address NVARCHAR(MAX),
    @state VARCHAR(50)
AS
BEGIN
    UPDATE dbo.Customers
    SET FirstName = @firstName,
        LastName = @lastName,
        Email = @email,
        Phone = @phone,
        Address = @address,
        State = @state
    WHERE Id = @id;

    SELECT 1 AS result;
END;

GO

CREATE PROCEDURE getCustomerPlan @CustomerId VARCHAR(12)
AS
BEGIN
    SELECT CustomerId,
           PlanId,
           PlanOption,
           PlanDetailId,
           ProductId
    FROM dbo.CustomerPlan
    WHERE CustomerId = @CustomerId;
END;
GO


CREATE PROCEDURE updateCustomerPlan
    @customerId VARCHAR(12),
    @planOptionId INT,
    @planDetailId INT
AS
BEGIN
    UPDATE dbo.CustomerPlan
    SET PlanOption = @planOptionId,
        PlanDetailId = @planDetailId
    WHERE CustomerId = @customerId;

    SELECT 1 AS res;
END;

GO
CREATE VIEW AllPlanDetailTable
AS
SELECT P.Id AS PlanId,
       P.ConnectionType,
       P.Amount,
       P.IsHidden,
       PO.Id AS PlanOptionId,
       PO.OptionName,
       PD.Id AS PlanDetailId,
       PD.Description,
       PD.Duration,
       PD.DataLimit,
       PD.CallCharges,
       PD.Price
FROM dbo.Plans P
    JOIN dbo.PlansOption PO
        ON PO.PlanId = P.Id
    JOIN dbo.PlansDetail PD
        ON PD.PlansOptionId = PO.Id;

GO

CREATE PROCEDURE getCustomerOrderDetail
AS
BEGIN
    SELECT O.CustomerID,
           O.OrderStatus,
           O.PaymentMethod,
           O.OrderDate,
           O.DeliveryDate,
           C.FirstName,
           C.LastName,
           C.Address,
           C.Phone,
           [Plan].ConnectionType,
           [Plan].OptionName,
           [Plan].Description,
           P.ProductName,
           B.BillAmount
    FROM dbo.Orders O
        LEFT JOIN dbo.Billing B
            ON O.CustomerID = B.CustomerID
        LEFT JOIN dbo.CustomerPlan CP
            ON O.CustomerID = CP.CustomerId
        LEFT JOIN dbo.AllPlanDetailTable [Plan]
            ON CP.PlanDetailId = [Plan].PlanDetailId
        LEFT JOIN dbo.Products P
            ON CP.ProductId = P.Id
        LEFT JOIN dbo.Customers C
            ON O.CustomerID = C.Id;
END;
GO

CREATE PROCEDURE updateCustomerOrderStatus
    @CusId VARCHAR(12),
    @Status VARCHAR(50)
AS
BEGIN
    UPDATE dbo.Orders
    SET OrderStatus = @Status
    WHERE CustomerID = @CusId;

    IF (@Status = 'Completed')
    BEGIN
        UPDATE dbo.Customers
        SET State = 'Active'
        WHERE Id = @CusId;
        UPDATE dbo.Billing
        SET PaymentDate = GETDATE()
        WHERE PaymentMethod = 'Cash On Delivery'
              AND CustomerID = @CusId;
    END;
    IF (@Status = 'Cancelled')
    BEGIN
        UPDATE dbo.Customers
        SET State = 'Cancelled'
        WHERE Id = @CusId;

    END;
    SELECT 1 AS res;
END;

GO


CREATE PROCEDURE EmpLogin
    @UserName VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
    DECLARE @EmpId INT =
            (
                SELECT TOP 1
                       Id
                FROM dbo.Employees
                WHERE Username = @UserName
                      AND Password = @Password
                      AND State = 'Active'
            );

    IF EXISTS
    (
        SELECT TOP 1
               Id
        FROM dbo.EmployeeToken
        WHERE EmployeeId = @EmpId
    )
    BEGIN
        UPDATE dbo.EmployeeToken
        SET Expired = DATEADD(DAY, 1, GETDATE())
        WHERE EmployeeId = @EmpId;

        SELECT 1 AS Result,
               EmployeeId,
               Token,
               Expired
        FROM dbo.EmployeeToken
        WHERE EmployeeId = @EmpId;
        RETURN;
    END;



    IF (@EmpId IS NOT NULL AND @EmpId > 0)
    BEGIN
        INSERT INTO dbo.EmployeeToken
        (
            EmployeeId,
            Token,
            Expired
        )
        VALUES
        (   @EmpId,  -- EmployeeId - int
            DEFAULT, -- Token - varchar
            DEFAULT  -- Expired - datetime
            );

        SELECT 1 AS Result,
               EmployeeId,
               Token,
               Expired
        FROM dbo.EmployeeToken
        WHERE EmployeeId = @EmpId;


    END;
    ELSE
    BEGIN
        SELECT 0 AS Result;
    END;
END;

GO

CREATE PROCEDURE checkToken @Token VARCHAR(40)
AS
BEGIN
    SELECT TOP 1
           E.FirstName,
           E.LastName,
           E.RoleId,
           R.RoleName,
           (
               SELECT A.PermissionName
               FROM RoleAuthorization RA
                   JOIN dbo.Author A
                       ON A.Id = RA.AuthorizationId
               WHERE RA.RoleId = E.RoleId
               FOR JSON PATH
           ) AS Permission
    FROM dbo.EmployeeToken ET
        JOIN dbo.Employees E
            ON ET.EmployeeId = E.Id
        LEFT JOIN dbo.Roles R
            ON E.RoleId = R.Id
    WHERE Token = @Token
          AND GETDATE() < ET.Expired;

END;
GO

CREATE PROCEDURE getRoleAuth @RoleId INT
AS
BEGIN
    SELECT RA.RoleId,
           RA.AuthorizationId,
           A.PermissionName
    FROM dbo.RoleAuthorization RA
        JOIN dbo.Author A
            ON RA.AuthorizationId = A.Id
    WHERE RoleId = @RoleId;
END;
GO

CREATE PROCEDURE updateRoleAuth
    @RoleId INT,
    @arrRole VARCHAR(MAX)
AS
BEGIN
    --DECLARE @arrRole VARCHAR(max) = '1,2,3,4',@RoleId INT = 1

    DELETE FROM dbo.RoleAuthorization
    WHERE RoleId = @RoleId;


    IF (LEN(@arrRole) = 0)
    BEGIN
        SELECT 1 AS result;
        RETURN;
    END;

    INSERT INTO dbo.RoleAuthorization
    (
        RoleId,
        AuthorizationId
    )
    SELECT @RoleId,
           value
    FROM STRING_SPLIT(@arrRole, ',');

    SELECT 1 AS result;
END;

GO

CREATE PROCEDURE getAllBill
AS
BEGIN
    SELECT B.CustomerID,
           C.FirstName,
           C.LastName,
           C.Address,
           C.Phone,
           B.BillAmount,
           B.BillingDate,
           IIF(B.PaymentDate IS NULL, (SELECT CAST('' AS VARCHAR(1))), (SELECT CAST(B.PaymentDate AS VARCHAR(30)))) AS PaymentDate,
           IIF(B.PaymentDate IS NULL, (SELECT 'Unpaid'), (SELECT 'Paid')) AS IsPaid
    FROM dbo.Billing B
        JOIN dbo.CustomerPlan CP
            ON B.CustomerID = CP.CustomerId
        JOIN dbo.Customers C
            ON C.Id = B.CustomerID
    WHERE C.State = 'Active';
END;

GO

CREATE PROCEDURE getAllProduct
AS
BEGIN
    SELECT P.Id,
           P.ProductName,
           P.ProductImageUrl,
           P.Description,
           P.Price,
           P.QuantityInStock,
           P.IsHidden,
           P.Manufacturer,
           Pl.ConnectionType
    FROM dbo.Products P
        JOIN dbo.Plans Pl
            ON P.ForPlan = Pl.Id
    WHERE P.Id > 0;
END;
GO

CREATE PROCEDURE getProductInfo @ProductId INT
AS
BEGIN
    SELECT P.Id,
           P.ProductName,
           P.ProductImageUrl,
           P.Description,
           P.Price,
           P.QuantityInStock,
           P.IsHidden,
           P.Manufacturer,
           P.ForPlan
    FROM dbo.Products P
    WHERE P.Id = @ProductId;
END;
GO

CREATE PROCEDURE CreateProduct
    @ProductName VARCHAR(100),
    @ProductImageUrl NVARCHAR(MAX),
    @Description VARCHAR(MAX),
    @Price DECIMAL(20, 10),
    @QuantityInStock INT,
    @Manufacturer VARCHAR(100),
    @ForPlan INT
AS
BEGIN
    INSERT INTO dbo.Products
    (
        ProductName,
        ProductImageUrl,
        Description,
        Price,
        QuantityInStock,
        IsHidden,
        Manufacturer,
        ForPlan
    )
    VALUES
    (   @ProductName,     -- ProductName - varchar(100)
        @ProductImageUrl, -- ProductImageUrl - nvarchar(max)
        @Description,     -- Description - varchar(max)
        @Price,           -- Price - decimal(10, 2)
        @QuantityInStock, -- QuantityInStock - int
        DEFAULT,          -- IsHidden - bit
        @Manufacturer,    -- Manufacturer - varchar(100)
        @ForPlan          -- ForPlan - int
        );

    SELECT 1 AS Result;
END;
GO


CREATE PROCEDURE updateProduct
    @ProductId INT,
    @ProductName VARCHAR(100),
    @ProductImageUrl NVARCHAR(MAX),
    @Description VARCHAR(MAX),
    @Price DECIMAL(10, 5),
    @QuantityInStock INT,
    @Manufacturer VARCHAR(100),
    @ForPlan INT
AS
BEGIN
    UPDATE dbo.Products
    SET ProductName = @ProductName,
        ProductImageUrl = @ProductImageUrl,
        Description = @Description,
        Price = @Price,
        QuantityInStock = @QuantityInStock,
        Manufacturer = @Manufacturer,
        ForPlan = @ForPlan
    WHERE Id = @ProductId;

    SELECT 1 AS Result;

END;

GO

CREATE PROCEDURE editEmp
    @id INT,
    @firstName NVARCHAR(50),
    @lastName NVARCHAR(50),
    @email VARCHAR(100),
    @phone VARCHAR(11),
    @userName VARCHAR(50),
    @password VARCHAR(50),
    @salary DECIMAL(10, 2),
    @roleId INT,
    @dateOfBirth DATE,
    @cityId INT,
    @state VARCHAR(50)
AS
BEGIN
    UPDATE dbo.Employees
    SET FirstName = @firstName,
        LastName = @lastName,
        Email = @email,
        Phone = @phone,
        Username = @userName,
        Password = @password,
        Salary = @salary,
        RoleId = @roleId,
        DateOfBirth = @dateOfBirth,
        CityId = @cityId,
        State = @state
    WHERE Id = @id;

    SELECT 1 AS Result;
END;
GO

CREATE PROCEDURE getAllRetailStore
AS
BEGIN
    SELECT RS.StoreID,
           RS.StoreName,
           RS.Address,
           RS.Phone,
           C.Name,
           RS.State,
           E.FirstName + ' ' + E.LastName AS FullName
    FROM dbo.RetailStores RS
        JOIN dbo.Employees E
            ON RS.ManagerId = E.Id
        JOIN dbo.CityAvailable C
            ON RS.CityId = C.Id;
END;

GO

CREATE PROCEDURE addNewStore
    @StoreName NVARCHAR(100),
    @Address NVARCHAR(100),
    @Phone VARCHAR(20),
    @CityId INT,
    @ManagerId INT
AS
BEGIN
    INSERT INTO dbo.RetailStores
    (
        StoreName,
        Address,
        Phone,
        CityId,
        State,
        ManagerId
    )
    VALUES
    (   @StoreName, -- StoreName - nvarchar(100)
        @Address,   -- Address - nvarchar(100)
        @Phone,     -- Phone - varchar(20)
        @CityId,    -- CityId - int
        'Active',   -- State - varchar(50)
        @ManagerId  -- ManagerId - int
        );


    SELECT 1 AS Result;
END;
GO

CREATE PROCEDURE getManagerByCityId @CityId INT
AS
BEGIN
    SELECT Id,
           FirstName + ' ' + LastName AS FullName
    FROM dbo.Employees
    WHERE CityId = @CityId
          AND RoleId = 4
    UNION
    SELECT Id,
           FirstName + ' ' + LastName AS FullName
    FROM dbo.Employees
    WHERE RoleId = 1;
END;

GO

CREATE PROCEDURE getStoreInfo @StoreId INT
AS
BEGIN
    SELECT StoreID,
           StoreName,
           Address,
           Phone,
           CityId,
           State,
           ManagerId
    FROM dbo.RetailStores
    WHERE StoreID = @StoreId;
END;
GO

CREATE PROCEDURE updateStore
    @StoreID INT,
    @StoreName NVARCHAR(100),
    @Address NVARCHAR(100),
    @Phone VARCHAR(20),
    @CityId INT,
    @ManagerId INT
AS
BEGIN
    UPDATE dbo.RetailStores
    SET StoreName = @StoreName,
        Address = @Address,
        Phone = @Phone,
        CityId = @CityId,
        ManagerId = @ManagerId
    WHERE StoreID = @StoreID;
    SELECT 1 AS Result;
END;
GO

CREATE PROCEDURE getAvailableCityList
AS
BEGIN
    SELECT Id,
           Name,
           PostalCode,
           IsHidden
    FROM dbo.CityAvailable;
END;
GO

CREATE PROCEDURE addNewCity
    @CityName NVARCHAR(50),
    @PostalCode VARCHAR(10)
AS
BEGIN
    INSERT INTO dbo.CityAvailable
    (
        Name,
        PostalCode,
        IsHidden
    )
    VALUES
    (   @CityName,   -- Name - nvarchar(50)
        @PostalCode, -- PostalCode - varchar(10)
        DEFAULT      -- IsHidden - bit
        );
    SELECT 1 AS Result;
END;
GO

CREATE PROCEDURE getCityInfo @cityId INT
AS
BEGIN
    SELECT Id,
           Name,
           PostalCode,
           IsHidden
    FROM dbo.CityAvailable
    WHERE Id = @cityId;
END;
GO

CREATE PROCEDURE updateCity
    @Id INT,
    @CityName NVARCHAR(50),
    @PostalCode NVARCHAR(50)
AS
BEGIN
    UPDATE dbo.CityAvailable
    SET Name = @CityName,
        PostalCode = @PostalCode
    WHERE Id = @Id;

    SELECT 1 AS Result;
END;
GO

CREATE PROCEDURE getOrderDetailByCustomer
    @Customer VARCHAR(15),
    @IsPhoneNumber BIT
AS
BEGIN
    IF (@IsPhoneNumber = 1)
    BEGIN
        SELECT O.Id AS OrderId,
               O.CustomerID,
               O.OrderStatus,
               O.PaymentMethod,
               O.OrderDate,
               O.DeliveryDate,
               C.Id,
               C.FirstName,
               C.LastName,
               C.Phone,
               C.Address,
               AP.ConnectionType,
               AP.OptionName,
               AP.Description,
               AP.Price,
               AP.CallCharges,
               P.ProductName,
               B.BillAmount
        FROM dbo.Orders O
            JOIN dbo.Customers C
                ON O.CustomerID = C.Id
            JOIN dbo.CustomerPlan CP
                ON CP.CustomerId = C.Id
            JOIN dbo.AllPlanDetailTable AP
                ON CP.PlanDetailId = AP.PlanDetailId
            JOIN dbo.Products P
                ON CP.ProductId = P.Id
            JOIN dbo.Billing B
                ON C.Id = B.CustomerID
        WHERE C.Phone = @Customer;
        RETURN;

    END;


    SELECT O.Id AS OrderId,
           O.CustomerID,
           O.OrderStatus,
           O.PaymentMethod,
           O.OrderDate,
           O.DeliveryDate,
           C.Id,
           C.FirstName,
           C.LastName,
           C.Phone,
           C.Address,
           AP.ConnectionType,
           AP.OptionName,
           AP.Description,
           AP.Price,
           AP.CallCharges,
           P.ProductName,
           B.BillAmount
    FROM dbo.Orders O
        JOIN dbo.Customers C
            ON O.CustomerID = C.Id
        JOIN dbo.CustomerPlan CP
            ON CP.CustomerId = C.Id
        JOIN dbo.AllPlanDetailTable AP
            ON CP.PlanDetailId = AP.PlanDetailId
        JOIN dbo.Products P
            ON CP.ProductId = P.Id
        JOIN dbo.Billing B
            ON C.Id = B.CustomerID
    WHERE C.Id = @Customer;
END;

GO

CREATE PROCEDURE CustomerFeedbackByOrderId
    @OrderId INT,
    @Subject NVARCHAR(100),
    @Comments NVARCHAR(1000)
AS
BEGIN
    DECLARE @CustomerId VARCHAR(12) =
            (
                SELECT TOP 1 CustomerID FROM dbo.Orders WHERE Id = @OrderId
            );

    IF @CustomerId IS NULL
    BEGIN

        SELECT 0 AS Result;
        RETURN;
    END;

    INSERT INTO dbo.Feedback
    (
        OrderID,
        CustomerID,
        [Subject],
        Comments
    )
    VALUES
    (   @OrderId,    -- OrderID - int
        @CustomerId, -- CustomerID - varchar(12)
        @Subject,    -- Subject - nvarchar(100)
        @Comments    -- Comments - nvarchar(1000)
        );

    SELECT 1 AS Result;

END;

GO

CREATE PROCEDURE getAllFeedback
AS
BEGIN
    SELECT F.Id,
           F.OrderID,
           F.CustomerID,
           F.Subject,
           F.Comments,
           C.FirstName,
           C.LastName,
           C.Phone,
           C.Address,
           C.CreatedDate
    FROM dbo.Feedback F
        JOIN dbo.Customers C
            ON F.CustomerID = C.Id;

END;

GO

CREATE PROCEDURE CheckPermission
    @Token VARCHAR(40),
    @Permisson VARCHAR(50)
AS
BEGIN
	IF EXISTS (
    SELECT TOP 1 A.PermissionName
    FROM dbo.EmployeeToken ET
        JOIN dbo.Employees E
            ON E.Id = ET.EmployeeId
        JOIN dbo.Roles R
            ON E.RoleId = R.Id
        JOIN dbo.RoleAuthorization RA
            ON R.Id = RA.RoleId
        JOIN dbo.Author A
            ON RA.AuthorizationId = A.Id
    WHERE ET.Token = @Token
          AND A.PermissionName = @Permisson)
		  BEGIN
		      SELECT 1 AS Result
			  RETURN
		  END

		  SELECT 0 AS Result
END;
