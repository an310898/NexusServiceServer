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

ALTER PROCEDURE availableCityList 
AS
BEGIN
 SELECT 
        Address,
        City,PostalCode FROM dbo.RetailStores

END
GO

SELECT * FROM dbo.RetailStores

EXEC dbo.getAllPlan