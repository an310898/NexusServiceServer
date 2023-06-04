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
CREATE FUNCTION GenerateEmpID
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

ALTER PROCEDURE addNewCustomer
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email VARCHAR(50),
    @Phone VARCHAR(11),
    @Address VARCHAR(100),
    @CityId INT,
    @PlanId INT,
    @PlanOptionId INT,
    @PlanDetailId INT,
    @ProductId INT 
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
                SELECT dbo.GenerateEmpID(@Prefix, IIF(@NewNumber IS NULL, (SELECT 1), (@NewNumber + 1)), 9, '0')
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




    DECLARE @TotalCharge DECIMAL(10, 3) = @InstallCharge + @MonthlyCharge + @ProductCharge;


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
        @PlanDetailId,  -- PlanDetailId - int
		@ProductId
        );


    INSERT INTO dbo.Orders
    (
        CustomerID,
        PlanDetailID,
        ProductId,
        OrderStatus,
        PaymentMethod,
        OrderDate,
        DeliveryDate
    )
    VALUES
    (   @CusId,        -- CustomerID - varchar(12)
        @PlanDetailId, -- PlanDetailID - int
        @ProductId,    -- ProductId - int
        'Pending',     -- OrderStatus - varchar(50)
        NULL,          -- PaymentMethod - nvarchar(50)
        GETDATE(),     -- OrderDate - date
        NULL           -- DeliveryDate - date
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
    (   @CusId,       -- CustomerID - varchar(12)
        @TotalCharge, -- BillAmount - decimal(10, 2)
        GETDATE(),    -- BillingDate - date
        NULL,         -- PaymentDate - date
        NULL          -- PaymentMethod - varchar(50)
        );

		SELECT @CusId AS CustomerId
END;
GO

