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

EXEC dbo.getAvailableCity