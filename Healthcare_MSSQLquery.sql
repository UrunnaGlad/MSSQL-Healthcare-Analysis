/**
 Business Questions:
	1. Which medical condition has he highest average billing amount?
	2. What's the average length of stay per admission type?
	3. Which insurance providers cover the highest cost cases?
	4. what are the most common medications used per diagnosis?
	5. What is the average time to discharge by hospital?
**/


--------------------------------------------DATA EXPLORATION-------------------------------------------

----Check the entire column in the data table
SELECT * 
FROM healthcare;


-----Check unique category
SELECT DISTINCT(ID) AS Gender_category
FROM healthcare;

SELECT DISTINCT(Gender) AS Gender_category
FROM healthcare;  

SELECT DISTINCT(Medical_Condition) AS Medical_condition_category
FROM healthcare;  

SELECT DISTINCT(Blood_Type) AS Blood_Type_category
FROM healthcare; 

SELECT DISTINCT(Insurance_Provider) AS Insurance_Provider_category
FROM healthcare;

SELECT DISTINCT(Admission_Type) AS Insurance_Provider_category
FROM healthcare;

SELECT DISTINCT(Medication) AS Medication_category
FROM healthcare; 

SELECT DISTINCT(Test_Results) AS Test_Results_category
FROM healthcare; 

--------------------------------------------- DATA CLEANING ------------------------------------------------------

---------- Standardize text column
---------- Changing the values of Name column to uppercase letter
UPDATE healthcare SET Name = UPPER (Name);

SELECT TRIM(Medical_condition) AS cleaned_med
FROM healthcare;

UPDATE healthcare SET Medical_Condition = TRIM(Medical_condition)


---------------- Check for nulls
SELECT *
FROM healthcare
WHERE ID IS NULL OR Name IS NULL OR Age IS NULL OR Gender IS NULL OR Blood_Type IS NULL OR Medical_Condition IS NULL OR Date_of_Admission IS NULL 
        OR Doctor IS NULL OR Hospital IS NULL OR Insurance_Provider IS NULL OR Billing_Amount IS NULL OR Room_Number IS NULL 
		OR Admission_Type IS NULL OR Discharge_Date IS NULL OR Medication IS NULL OR Test_Results IS NULL;


-------------- Update the null values with the mean
SELECT AVG(Billing_Amount)
FROM healthcare;

UPDATE healthcare
SET Billing_Amount = (
	SELECT AVG(Billing_Amount)
	FROM healthcare
)
WHERE ID = 26812;


---------------- Check for duplicates
SELECT *, COUNT(*) AS record_count
FROM healthcare
GROUP BY ID, Name, Age, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, 
				Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type,
				Discharge_Date, Medication, Test_Results
HAVING COUNT(*) > 1;

-----------------Remove duplicates in the ID column
WITH duplicate AS (
	SELECT *,
		ROW_NUMBER() OVER (PARTITION BY ID ORDER BY ID) AS rn
	FROM healthcare

)
DELETE FROM duplicate
WHERE rn > 1;


---------- Extract year from date of admission
SELECT Date_of_Admission, DATEPART(year,Date_of_Admission) AS Year
FROM healthcare;



---------------Summary STATS
SELECT MIN(Age) FROM healthcare;
SELECT MAX(Age) FROM healthcare;
SELECT AVG(Billing_amount) AS Avg_Billing FROM healthcare;
SELECT SUM(Billing_amount) AS Total_Billing FROM healthcare;
SELECT COUNT(ID) FROM healthcare;


---------------------------------------------DATA ANALYSIS------------------------------------------------------------

-----------Medical condition with the highest average billing amount
SELECT Medical_Condition,
		COUNT(*) AS patient_count,
		ROUND(AVG(Billing_Amount), 2) AS Avg_billing_amount
FROM
	healthcare
GROUP BY
	Medical_Condition
ORDER BY Avg_billing_amount DESC 


------------Average length of stay per admission type
SELECT Admission_Type,
		Date_of_Admission,
		Discharge_Date,
		DATEDIFF(DAY, Date_of_Admission, Discharge_Date) As stay_length
INTO #TEMP
FROM healthcare;

SELECT 
	Admission_Type,
	AVG(Stay_length) as Avg_stay_length
FROM #TEMP
GROUP BY Admission_Type;


------------ Insurance providers with the highest cost cases
SELECT
	Insurance_provider,
	ROUND(SUM(Billing_Amount), 2) AS Total_Bill
FROM
	healthcare
GROUP BY
	Insurance_Provider
ORDER BY 
	Total_bill DESC


-------- The most common medications used per diagnosis
SELECT Medical_Condition,
	   Medication,
	   COUNT(*) AS usage_count
FROM healthcare
GROUP BY
	Medical_Condition,
	Medication
ORDER BY
	Medical_Condition,
	usage_count


----------- The average time to discharge by hospital
SELECT
	Hospital,
	DATEDIFF(DAY, Date_of_Admission, Discharge_Date) AS stay_length
INTO #staylenghtable
FROM healthcare;

SELECT
	Hospital, 
	AVG(stay_length) AS Avg_stay_length
FROM #staylenghtable
GROUP BY 
	Hospital
ORDER BY
	Avg_stay_length DESC;


-------- Total billing amount for patients by medical condition
SELECT
	Gender,
	Medical_Condition,
	SUM(Billing_Amount) As Total_amount
FROM healthcare
GROUP BY Medical_Condition, 
		 Gender
ORDER BY Total_amount DESC;


------- Categorize patients by age and gender for targeted outreach
SELECT 
	ID,
	Name,
	Age,
	Gender,
	CASE 
		WHEN Gender = 'Female' THEN
			CASE
				WHEN Age < 30 THEN 'Young Female'
				ELSE 'Adult Female'
			END
				WHEN Gender = 'Male' THEN
			CASE
				WHEN Age < 30 THEN 'Young Male'
				ELSE 'Adult Female'
			END
		ELSE 'Other'
	END AS Sement
FROM healthcare;


--------- Total billing by insurance provider
SELECT Total_billing, Insurance_Provider
FROM (
		SELECT insurance_provider, SUM(Billing_amount) AS Total_billing
		FROM healthcare
		GROUP BY Insurance_Provider
) As Billing_insurance;


-------- Average billing per Medical Condition
SELECT
	Medical_condition,
	AVG(Billing_Amount) AS avg_bill_per_condition
FROM healthcare
GROUP BY Medical_condition;
