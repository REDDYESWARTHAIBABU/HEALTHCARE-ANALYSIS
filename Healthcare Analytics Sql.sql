-- KPI 1 : Number of Patients across various summaries
SELECT
    SUM(coalesce(transfusionsummary,0)) AS TransfusionPatients,
    SUM(coalesce(hypercalcemiasummary,0)) AS HypercalcemiaPatients,
    SUM(coalesce(Serumphosphorussummary,0)) AS SerumPhosphorusPatients,
    SUM(coalesce(hospitalizationsummary,0)) AS HospitalizationPatients,
    SUM(coalesce(hospitalreadmissionsummary,0)) AS HospitalReadmissionPatients,
    SUM(coalesce(survivalsummary,0)) AS SurvivalPatients,
    SUM(coalesce(Patientsincludedinfistulasummary,0)) AS FistulaPatients,
    SUM(coalesce(longcathetersummary,0)) AS LongCatheterPatients,
    SUM(coalesce(nPCRsummary,0)) AS nPCRPatients
FROM
    dialysis_one;

-- by using ifnull
SELECT
    SUM(IFNULL(transfusionsummary, 0)) AS TransfusionPatients,
    SUM(IFNULL(hypercalcemiasummary, 0)) AS HypercalcemiaPatients,
    SUM(IFNULL(Serumphosphorussummary, 0)) AS SerumPhosphorusPatients,
    SUM(IFNULL(hospitalizationsummary, 0)) AS HospitalizationPatients,
    SUM(IFNULL(hospitalreadmissionsummary, 0)) AS HospitalReadmissionPatients,
    SUM(IFNULL(survivalsummary, 0)) AS SurvivalPatients,
    SUM(IFNULL(Patientsincludedinfistulasummary, 0)) AS FistulaPatients,
    SUM(IFNULL(longcathetersummary, 0)) AS LongCatheterPatients,
    SUM(IFNULL(nPCRsummary, 0)) AS nPCRPatients
FROM
    dialysis_one;
    
-- output includes wordings as lakhs
SELECT
    CONCAT(FORMAT(SUM(IFNULL(transfusionsummary, 0)) / 100000, 2), ' Lakhs') AS TransfusionPatients,
    CONCAT(FORMAT(SUM(IFNULL(hypercalcemiasummary, 0)) / 100000, 2), ' Lakhs') AS HypercalcemiaPatients,
    CONCAT(FORMAT(SUM(IFNULL(Serumphosphorussummary, 0)) / 100000, 2), ' Lakhs') AS SerumPhosphorusPatients,
    CONCAT(FORMAT(SUM(IFNULL(hospitalizationsummary, 0)) / 100000, 2), ' Lakhs') AS HospitalizationPatients,
    CONCAT(FORMAT(SUM(IFNULL(hospitalreadmissionsummary, 0)) / 100000, 2), ' Lakhs') AS HospitalReadmissionPatients,
    CONCAT(FORMAT(SUM(IFNULL(survivalsummary, 0)) / 100000, 2), ' Lakhs') AS SurvivalPatients,
    CONCAT(FORMAT(SUM(IFNULL(Patientsincludedinfistulasummary, 0)) / 100000, 2), ' Lakhs') AS FistulaPatients,
    CONCAT(FORMAT(SUM(IFNULL(longcathetersummary, 0)) / 100000, 2), ' Lakhs') AS LongCatheterPatients,
    SUM(IFNULL(nPCRsummary, 0))  AS nPCRPatients
FROM
    dialysis_one;
    
-- KPI : 2 Profit Vs Non-Profit Stats
 SELECT
    ProfitorNonProfit,
    COUNT(*) AS TotalCenters,
    AVG(ExpectedDialysisStations) AS AvgDialysisStations,
    AVG(Patientsincludedinfistulasummary) AS AvgFistulaPatients,
    AVG(longcathetersummary) AS AvgLongCatheterPatients
FROM
    dialysis_one
GROUP BY
    ProfitorNonProfit;
    
-- KPI : 3 Chain Organizations w.r.t. Total Performance Score as No Score   
SELECT 
	d1.ChainOrganization, count(d2.TotalPerformanceScore) as 
    'Total No Score' FROM dialysis1 as d1 JOIN dialysis2 as d2 ON 
    d1.FacilityName = d2.FacilityName WHERE TotalPerformanceScore = 
	'No Score' group by d1.ChainOrganization;
    
-- KPI : 4 Dialysis Stations Stats 
SELECT
    AVG(ExpectedDialysisStations) AS AvgDialysisStations,
    MAX(ExpectedDialysisStations) AS MaxDialysisStations,
    MIN(ExpectedDialysisStations) AS MinDialysisStations,
    COUNT(*) AS TotalFacilities
FROM
    dialysis_one;

-- by using profit and non profit
SELECT
    ProfitorNonProfit,
    AVG(ExpectedDialysisStations) AS AvgDialysisStations,
    MAX(ExpectedDialysisStations) AS MaxDialysisStations,
    MIN(ExpectedDialysisStations) AS MinDialysisStations,
    COUNT(*) AS TotalFacilities
FROM
    dialysis_one
GROUP BY
    ProfitorNonProfit;

-- by using state
SELECT
    State,
    AVG(ExpectedDialysisStations) AS AvgDialysisStations,
    MAX(ExpectedDialysisStations) AS MaxDialysisStations,
    MIN(ExpectedDialysisStations) AS MinDialysisStations,
    COUNT(*) AS TotalFacilities
FROM
    dialysis_one
GROUP BY
    State;
    
-- KPI : 5 
 SELECT
    SUM(CASE WHEN PatientTransfusioncategorytext = 'As Expected' THEN 1 ELSE 0 END) AS TransfusionAsExpected,
    SUM(CASE WHEN Patienthospitalizationcategorytext = 'As Expected' THEN 1 ELSE 0 END) AS HospitalizationAsExpected,
    SUM(CASE WHEN PatientHospitalReadmissionCategory = 'As Expected' THEN 1 ELSE 0 END) AS HospitalReadmissionsAsExpected,
    SUM(CASE WHEN PatientSurvivalCategoryText = 'As Expected' THEN 1 ELSE 0 END) AS SurvivalAsExpected,
    SUM(CASE WHEN PatientInfectioncategorytext = 'As Expected' THEN 1 ELSE 0 END) AS InfectionAsExpected,
    SUM(CASE WHEN FistulaCategoryText = 'As Expected' THEN 1 ELSE 0 END) AS FistulaAsExpected,
    SUM(CASE WHEN SWRcategorytext = 'As Expected' THEN 1 ELSE 0 END) AS SWRAsExpected,
    SUM(CASE WHEN PPPWcategorytext = 'As Expected' THEN 1 ELSE 0 END) AS PPPWAsExpected
FROM
    dialysis_one;

-- KPI : 6
SELECT
    round(AVG(`PY2020PaymentReductionPercentage`),2) AS AveragePaymentReductionRate
FROM
    dialysis_two;

-- another way
SELECT
    SUM(`PY2020PaymentReductionPercentage`) / COUNT(*) AS AveragePaymentReductionRate
FROM
    dialysis_two
WHERE
    `PY2020PaymentReductionPercentage` IS NOT NULL;

-- another way
select round(avg(PY2020PaymentReductionPercentage),2) as 
'AveragePaymentReduction' from dialysis_two where 
PY2020PaymentReductionPercentage <> 'No reduction';



    
