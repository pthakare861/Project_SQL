
CREATE TABLE Hospital (
    HospitalName VARCHAR(255),
    Location VARCHAR(255),
    Department VARCHAR(255),
    DoctorsCount INT,
    PatientsCount INT,
    AdmissionDate DATE,
    DischargeDate DATE,
    MedicalExpenses DECIMAL(10,2)
);
	
SELECT * FROM Hospital;

--Import data into hospital 
COPY Hospital(Hospital Name,Location,Department,Doctors Count,	Patients Count,	Admission Date,	Discharge Date,	Medical Expenses
)
From D:\'Power Bi course 30 days\Data anaytics SQL lang micro course\certi drive-download-20250203T065749Z-001\Hospital_Data.csv'
DELIMITER 
CSV HEADER;

--- 1 TOTAL NUMBER OF PATIENTS
SELECT SUM(PatientsCount) AS TotalPatients
FROM Hospital;

-- 2 Average Number of Doctors per Hospital
 	SELECT AVG(DoctorsCount) AS AvgDoctorsPerHospital
FROM Hospital;

---3 Top 3 Departments with the Highest Number of Patients 
	SELECT Department, SUM(PatientsCount) AS Total_Patients
FROM Hospital
GROUP BY Department
ORDER BY Total_Patients DESC
LIMIT 3;

--4 Hospital with the Maximum Medical Expenses
	SELECT Hospital, MedicalExpenses
FROM Hospital
ORDER BY MedicalExpenses DESC
LIMIT 1;

-- 5  Daily Average Medical Expenses 
	SELECT AdmissionDate, 
    AVG(medicalexpenses) AS DailyAvgExpenses
FROM Hospital
GROUP BY AdmissionDate
ORDER BY AdmissionDate;





-- 6 Longest Hospital Stay
	SELECT Hospital, DATEDIFF(DischargeDate, AdmissionDate) AS StayDuration
FROM Hospital
ORDER BY Stay_Duration DESC
LIMIT 1;

-- 7 Total Patients Treated Per City
	SELECT Location AS City, SUM(PatientsCount) AS TotalPatients
FROM Hospital
GROUP BY Location
ORDER BY TotalPatients DESC;

-- 8 Average Length of Stay Per Department
	SELECT Department, 
       AVG(DATEDIFF(Discharge_Date, AdmissionDate)) AS AvgLengthofStay
		FROM Hospital
		GROUP BY Department
		ORDER BY AvgLengthofStay DESC;


---- 9 Identify the Department with the Lowest Number of Patients
		SELECT Department, SUM(PatientsCount) AS TotalPatients
		FROM Hospital
		GROUP BY Department
		ORDER BY TotalPatients ASC
		LIMIT 1;

---- 10 Monthly Medical Expenses Report
	SELECT strftime('%Y-%M', AdmissionDate) AS Month, 
    SUM(MedicalExpenses) AS TotalExpenses
FROM Hospital
GROUP BY Month
ORDER BY Month;


