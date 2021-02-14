# Billable Rate System

### Table of Contents

1. [Introduction](#introduction)
2. [Setup](#setup)
3. [Running the Application](#running-the-application)


----


# Introduction
This system allows empoloyees, depending on their grade, to send in a timesheet: the total numbers of hours they've worked and their billable rate, so the finance team can create invoices for their clients to pay.

----


# Setup
Here's how to setup the application on your local computer for development:


### Installation
Follow these instructions to setup your local development environment:

1. Clone the project and `cd` into the project directory

2. Run `bundle install` to install RSpec dependencies.

3. Create a config/application.yml file and check out config/application.yml for more instructions.

4. Run `bundle exec rails db:setup` to setup, run migrations, and seed the database.

5. Happy hacking!



----


# Running the Application
There are three input files in the `lib/assests` folder that serves as the shopping baskets for testing the application

1. Run `bundle exec rails server` to startup the application

2. Run `rspec spec` to run all the tests for the application.

### API endpoints
```
# Create employee
POST localhost:3000/employees

# Create a timesheet for an employee
POST localhost:3000/employees/:employee_id/time_sheets

# Get a particular timesheet for an employee
GET localhost:3000/employees/:employee_id/time_sheets/:id

# Update a particular timesheet for an employee
PUT localhost:3000/employees/:employee_id/time_sheets/:id

# Delete a timesheet for an employee
DELETE localhost:3000/employees/:employee_id/time_sheets/:id

# Generate invoices for each client
GET localhost:3000/invoices/:company_name
```
