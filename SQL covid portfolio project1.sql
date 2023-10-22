-- SHOW databases;
-- use portfolioproject
-- show tables;
-- desc covid_death

SELECT * from covid_death
where continent is not null
order by 3,4;

SELECT * from covid_death
where continent is null
order by 3,4;

desc covid_death;
Select *
From covid_death 
order by 3,4;

-- Select *
-- From covidvaccination
-- order by 3,4;

-- Data sets


Select location, date, total_cases, new_cases, total_deaths, population
From covid_death 
order by 1,2;

-- Looking at Total Cases vs Total Deaths
--  shows Likelihood of dying if your contract covid in your country


Select location, date, total_cases, total_deaths, (total_deaths/total_cases)
From covid_death 
order by 1,2;

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage 
From covid_death 
order by 1,2;

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage 
From covid_death 
where location like '%states'
order by 1,2;

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage 
From covid_death 
where location like '%Africa'
order by 1,2;

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage 
From covid_death 
where location like '%Asia'
order by 1,2;

-- Looking at the Total Cases vs the Population
-- Shows what percentage of population got covid


Select location, date, population, total_cases, (total_cases/population)*100 as Deathpercentage 
From covid_death 
-- where location like '%Africa'
order by 1,2;

-- Looking at country with highest infection rate compared to population

Select location, population, MAX(total_cases) as highestinfectioncount, MAX(total_cases/population)*100 as Percentofpopulationinfected
From covid_death 
-- where location like '%Africa'
group by location, population
order by 1,2;

Select location, population, MAX(total_cases) as highestinfectioncount, MAX(total_cases/population)*100 as Percentofpopulationinfected
From covid_death 
-- where location like '%Africa'
group by location, population
order by Percentofpopulationinfected;

Select location, population, MAX(total_cases) as highestinfectioncount, MAX(total_cases/population)*100 as Percentofpopulationinfected
From covid_death 
-- where location like '%Africa'
group by location, population
order by Percentofpopulationinfected desc;

-- Showing Countries with Highest Death Count per population

Select location, MAX(total_deaths) as TotalDeathCount
From covid_death 
-- where location like '%Africa'
group by location
order by TotalDeathCount desc;

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From covid_death 
where continent is not null
group by location
order by TotalDeathCount desc;

-- LEST'S BEAK THINGS DOWN TO CONTINENTS 

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From covid_death 
where continent is not null
group by continent
order by TotalDeathCount desc;

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From covid_death 
where continent is  null
group by location
order by TotalDeathCount desc;

-- Showing continent with highest Deathcount per population

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From covid_death 
where continent is  null
group by location
order by TotalDeathCount desc;

-- Global numbers

Select date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage 
From covid_death 
-- where location like '%Africa'
where continent is not null
group by date
order by 1,2;

Select date, SUM(new_cases) -- , total_deaths, (total_deaths/total_cases)*100 as Deathpercentage 
From covid_death 
-- where location like '%Africa'
where continent is not null
group by date
order by 1,2;

Select date, SUM(new_cases), SUM(new_deaths) -- , total_deaths, (total_deaths/total_cases)*100 as Deathpercentage 
From covid_death 
-- where location like '%Africa'
where continent is not null
group by date
order by 1,2;

-- Looking at Total Population vs vaccinatons

select dea.continent, dea.population, dea.date, dea.location, vac.new_vaccination
from portfolioproject.covid_death dea
join portfolioproject.covid_vaccination vac
on dea.location=location
and dea.date=date
where continent is not null
order by 1,2,3;

select dea.continent, dea.population, dea.date, dea.location, vac.new_vaccination
sum(CONVERT(int, new_vaccination)) over (partition by dea.location)
as rollingpeoplevaccinated 
from portfolioproject.covid_death dea
join portfolioproject.covid_vaccination vac
     on dea.location=location
     and dea.date=date
where continent is not null
order by 2,3;
