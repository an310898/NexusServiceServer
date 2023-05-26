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
           Address,
           Username,
           Password,
           DateOfBirth,
           Gender,
           JoiningDate,
           Salary,
           IsHidden,
           CreatedDate
    FROM dbo.Employees;
END;
GO


ALTER PROCEDURE getAllPlan
AS
BEGIN
    SELECT P.Id,
       P.ConnectionType,
       P.Amount
FROM dbo.Plans P

END

GO
CREATE PROCEDURE checkAvailableZipCode @ZipCode VARCHAR(10)
AS
BEGIN
    IF EXISTS
    (
        SELECT TOP 1
               *
        FROM dbo.RetailStores
        WHERE PostalCode = @ZipCode
    )
    BEGIN
        SELECT 1 AS result
		RETURN;
    END;
	
     SELECT 0 AS result


END;
GO

CREATE PROCEDURE getPlanOptionByPlanId @PlanId INT
AS
BEGIN
    SELECT Id,OptionName FROM dbo.PlansOption WHERE PlanId = @PlanId
END

go

CREATE PROCEDURE getPlanDetailByPlanOptionId @PlanOptionId INT
AS
BEGIN
    SELECT * FROM dbo.PlansDetail WHERE PlansOptionId = @PlanOptionId
END

