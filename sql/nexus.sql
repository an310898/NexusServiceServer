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
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Username VARCHAR(50),
    Password VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    JoiningDate DATE,
    Salary DECIMAL(10, 2),
    RoleId INT
        FOREIGN KEY REFERENCES dbo.Roles (Id),
    State VARCHAR(50),
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
        FOREIGN KEY REFERENCES dbo.Plans (Id)
);

CREATE TABLE Orders
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID VARCHAR(12)
        FOREIGN KEY REFERENCES dbo.Customers (Id),
    PlanDetailID INT
        FOREIGN KEY REFERENCES dbo.PlansDetail (Id),
    ProductId INT
        FOREIGN KEY REFERENCES dbo.Products (Id) NULL,
    OrderStatus VARCHAR(50),
    PaymentMethod NVARCHAR(50),
    OrderDate DATE,
    DeliveryDate DATE
);


--CREATE TABLE OrderDetails
--(
--    Id INT PRIMARY KEY IDENTITY(1, 1),
--    OrderId INT
--        FOREIGN KEY REFERENCES dbo.Orders (Id),
--    ProductId INT
--        FOREIGN KEY REFERENCES dbo.Products (Id),
--    Quantity INT NOT NULL
--        DEFAULT 1
--);


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
    FeedbackID INT PRIMARY KEY IDENTITY(1, 1),
    OrderID INT,
    CustomerID VARCHAR(12),
    Rating INT,
    Comments NVARCHAR(200),
    FOREIGN KEY (OrderID) REFERENCES Orders (Id),
    FOREIGN KEY (CustomerID) REFERENCES Customers (Id)
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
    RoleId,
	State,
    CreatedDate
)
VALUES
(   'Nguyen',             -- FirstName - nvarchar(50)
    'An 2',                 -- LastName - nvarchar(50)
    'an310898@gmail.com', -- Email - varchar(100)
    '0935263945',         -- Phone - varchar(20)
    'anns3182',            -- Username - varchar(50)
    '123123',             -- Password - varchar(50)
    '1998-08-31',         -- DateOfBirth - date
    GETDATE(),            -- JoiningDate - date
    '1000',               -- Salary - decimal(10, 2)
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
    RoleId,
	State,
    CreatedDate
)
VALUES
(   'Nguyen',             -- FirstName - nvarchar(50)
    'An3',                 -- LastName - nvarchar(50)
    'an310898@gmail.com', -- Email - varchar(100)
    '0935263945',         -- Phone - varchar(20)
    'anns3183',            -- Username - varchar(50)
    '123123',             -- Password - varchar(50)
    '1998-08-31',         -- DateOfBirth - date
    GETDATE(),            -- JoiningDate - date
    '1000',               -- Salary - decimal(10, 2)
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
    RoleId,
	State,
    CreatedDate
)
VALUES
(   'Nguyen',             -- FirstName - nvarchar(50)
    'An4',                 -- LastName - nvarchar(50)
    'an310898@gmail.com', -- Email - varchar(100)
    '0935263945',         -- Phone - varchar(20)
    'anns3184',            -- Username - varchar(50)
    '123123',             -- Password - varchar(50)
    '1998-08-31',         -- DateOfBirth - date
    GETDATE(),            -- JoiningDate - date
    '1000',               -- Salary - decimal(10, 2)
	4,
	'Active',
    DEFAULT               -- CreatedDate - datetime
    );


