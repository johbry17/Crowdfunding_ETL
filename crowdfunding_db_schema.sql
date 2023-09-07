-- drop tables (in reverse order, to avoid errors) if they already exist
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS campaign;
DROP TABLE IF EXISTS subcategory;
DROP TABLE IF EXISTS category;

-- create category table
-- import data from /Resources/category.csv with pgAdmin GUI
CREATE TABLE category (
    category_id varchar PRIMARY KEY,
    category varchar NOT NULL
);

-- create subcategory table
-- import data from /Resources/subcategory.csv with pgAdmin GUI
CREATE TABLE subcategory (
    subcategory_id varchar PRIMARY KEY,
    subcategory varchar NOT NULL
);

-- create campaign table
-- import data from /Resources/campaign.csv with pgAdmin GUI
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

-- create contacts table
-- import data from /Resources/contacts.csv with pgAdmin GUI
CREATE TABLE contacts (
    contact_id int PRIMARY KEY REFERENCES campaign (contact_id),
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    email varchar NOT NULL
);

