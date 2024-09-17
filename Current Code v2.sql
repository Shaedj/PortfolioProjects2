-- CLeaning data in SQL queries
Select *
FROM portfolioproject.nashvillehousing;

----------------------------------------------------------------
-- Standardize Date format
SELECT SaleDate, CONVERT(SaleDate, DATE) AS ConvertedSaleDate
FROM portfolioproject.nashvillehousing;

SELECT DISTINCT SaleDate
FROM portfolioproject.nashvillehousing
LIMIT 10;

SELECT SaleDate, 
       DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%m/%d/%Y') AS FormattedSaleDate
FROM portfolioproject.nashvillehousing;

-------------------------------------------------------------------
-- Populate Property Address data
Select PropertyAddress
FROM portfolioproject.nashvillehousing;

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM portfolioproject.nashvillehousing a
JOIN portfolioproject.nashvillehousing b
on a.ParcelID = b.ParcelID
and a.`UniqueID` <> b.`UniqueID`
WHERE a.PropertyAddress is null;
-- No Null found in property adress

------------------------------------------------------------
-- Breaking out address into Individual Columns (Address, city, state)
SELECT
    SUBSTR(PropertyAddress, 1, INSTR(PropertyAddress, ',') - 1) AS Address,
    SUBSTR(PropertyAddress, INSTR(PropertyAddress, ',') + 1, LENGTH(PropertyAddress)) AS City
FROM
    portfolioproject.nashvillehousing;

-- 2. Add a new column for the split address (use VARCHAR instead of NVARCHAR)
ALTER TABLE portfolioproject.nashvillehousing
ADD PropertySplitAddress VARCHAR(255);

-- 3. Update the new column with the extracted address
UPDATE portfolioproject.nashvillehousing
SET PropertySplitAddress = SUBSTR(PropertyAddress, 1, INSTR(PropertyAddress, ',') - 1);

-- 4. Add a new column for the split city (use VARCHAR instead of NVARCHAR)
ALTER TABLE portfolioproject.nashvillehousing
ADD PropertySplitCity VARCHAR(255);

-- 5. Update the new column with the extracted city
UPDATE portfolioproject.nashvillehousing
SET PropertySplitCity = TRIM(SUBSTR(PropertyAddress, INSTR(PropertyAddress, ',') + 1, LENGTH(PropertyAddress)));


    