
-- Death Percentage Rate

SHOW TABLES;
SELECT location,date,total_cases,total_deaths,(total_deaths / total_cases) * 100 AS DeathPercentage
FROM Cov_Deaths 
WHERE location = 'Ghana' ORDER BY 1,2; 


-- Population vs Cases Percentage

SELECT location,date,population,total_cases,(total_cases / population) * 100 AS PercentPopulationInfected
FROM Cov_Deaths 
WHERE location = 'Ghana' ORDER BY 1,2; 

-- Max Death Count By Continent Drill Down To Location(in Tableau)

SELECT continent,MAX(CAST(total_deaths AS INT)) AS maxdeaths
FROM Cov_Deaths 
WHERE location IS NOT NULL
GROUP BY continent
ORDER BY maxdeaths DESC; 

-- Total Deaths in The world
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
SUM(new_deaths)/SUM(new_cases) * 100 as OverallDeathPercentage
FROM Cov_Deaths
WHERE continent IS NOT NULL
GROUP BY date
order by 1,2;

-- Overall Total Deaths in The world
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
SUM(new_deaths)/SUM(new_cases) * 100 as DeathPercentage
FROM Cov_Deaths
WHERE continent IS NOT NULL
order by 1,2;

-- Total Population vs Vaccinations

SELECT dea.continent,dea.location,dea.date,dea.population,dea.new_vaccinations FROM Cov_Deaths as dea JOIN CovidVaccine as vac
On dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL ;

-- Creating View for Visualizations
CREATE VIEW DeathPercentRate as 
SELECT location,date,total_cases,total_deaths,(total_deaths / total_cases) * 100 AS DeathPercentage
FROM Cov_Deaths 
WHERE location = 'Ghana' ORDER BY 1,2; 

CREATE VIEW PopulationVsCasesPercent as 
SELECT location,date,population,total_cases,(total_cases / population) * 100 AS PercentPopulationInfected
FROM Cov_Deaths 
WHERE location = 'Ghana' ORDER BY 1,2; 

CREATE VIEW MaxDeathCount as 
SELECT continent,MAX(CAST(total_deaths AS INT)) AS maxdeaths
FROM Cov_Deaths 
WHERE location IS NOT NULL
GROUP BY continent
ORDER BY maxdeaths DESC; 

CREATE VIEW TotalWorldDeath as 
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
SUM(new_deaths)/SUM(new_cases) * 100 as OverallDeathPercentage
FROM Cov_Deaths
WHERE continent IS NOT NULL
GROUP BY date
order by 1,2;

CREATE VIEW OverallWorkDeathPercent as
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
SUM(new_deaths)/SUM(new_cases) * 100 as DeathPercentage
FROM Cov_Deaths
WHERE continent IS NOT NULL
order by 1,2;

CREATE VIEW TotalPopVsVaccine as 
SELECT dea.continent,dea.location,dea.date,dea.population,dea.new_vaccinations FROM Cov_Deaths as dea JOIN CovidVaccine as vac
On dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2,3;