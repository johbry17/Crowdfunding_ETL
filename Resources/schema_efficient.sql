/*
Alternate verson of schema that automatically imports data, bypassing the need for the pgAdmin GUI 'Import/Export'

Saves a lot of time

Unfortunately, it relies on a local path
I tried to use github, 'https://raw.githubusercontent.com/blah/blah'blah.csv', but pgAdmin does not like remote data sources
If you can figure it out, let me know
So, to get it to work, I had to create a local path to each .csv
AND I had to edit permissions on each .csv to allow Everyone access to read each individual file
Bit of a security risk, but I believe it's acceptable when dealing with 4 .csv's from a crowdfunding campaign for a school assignment on my personal laptop
Something to consider in professional settings, though

To use this, one would have to save all six .csv's locally, 
edit each of the six below 'Local\Path\Resources\blah.csv' in COPY FROM, 
and grant permissions to each csv
*/

-- drop tables (in reverse order, to avoid errors) if they already exist
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS campaign;
DROP TABLE IF EXISTS subcategory;
DROP TABLE IF EXISTS category;

-- create category table
-- import data from /Resources/titles.csv with pgAdmin GUI
CREATE TABLE category (
    category_id varchar PRIMARY KEY,
    category varchar NOT NULL
);
COPY category (category_id, category)
FROM 'Local\Path\Resources\titles.csv'
DELIMITER ','
CSV HEADER;

-- create subcategory table
CREATE TABLE subcategory (
    subcategory_id varchar PRIMARY KEY,
    subcategory varchar NOT NULL
);
COPY subcategory (subcategory_id, subcategory)
FROM 'Local\Path\Resources\subcategory.csv'
DELIMITER ','
CSV HEADER;

-- create campaign table
CREATE TABLE campaign (
    cf_id int NOT NULL,
    contact_id int PRIMARY KEY,
    company_name varchar NOT NULL,
    description varchar NOT NULL,
    goal float NOT NULL,
    pledged float NOT NULL,
    outcome varchar NOT NULL,
    backers_count int NOT NULL,
    country varchar NOT NULL,
    currency varchar NOT NULL,
    launch_date timestamp NOT NULL,
    end_date timestamp NOT NULL,
    category_id varchar NOT NULL REFERENCES category (category_id),
    subcategory_id varchar NOT NULL REFERENCES subcategory (subcategory_id)
);
COPY campaign (cf_id, contact_id, company_name, description, goal, pledged, outcome, backers_count, country, currency, launch_date, end_date, category_id, subcategory_id)
FROM 'Local\Path\Resources\campaign.csv'
DELIMITER ','
CSV HEADER;

-- create contacts table
CREATE TABLE contacts (
    contact_id int PRIMARY KEY REFERENCES campaign (contact_id),
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    email varchar NOT NULL
);
COPY contacts (contact_id, first_name, last_name, email)
FROM 'Local\Path\Resources\contacts.csv'
DELIMITER ','
CSV HEADER;

