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

SELECT *
FROM dbo.Plans;
SELECT *
FROM dbo.PlansOption;
SELECT *
FROM dbo.PlansDetail;


SELECT *
FROM dbo.Plans P
    JOIN dbo.PlansOption PO
        ON P.Id = PO.PlanId
    JOIN dbo.PlansDetail PD
        ON PD.PlansOptionId = PO.Id;