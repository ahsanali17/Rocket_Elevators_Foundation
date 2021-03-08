Rocket_Elevators_Information_System
🚀	Working with MVC (Model-View-Controller)	📈

Members of this week's team
Kaelen Burroughs -
Ahsan Syed -
Cristiane Santiago -
Olaolu Adetula -
 
🎯 About
Week 4 - The main goal of this week is to transform the static site previously developed during the Genesis program and turn it into a web application on MVC (Model - View - Controller) foundations. The site must be in a state that allows you to create a new section that saves the Javascript form that calculates an estimate in the form of a purchase order.
Expanding the relational database model
Seeding data base with data NB: real address are used

Week 5 - During this week, participants are exposed to a more elaborate data model and must perform basic query exercises. They will be asked to create tables, alter them and extend the concepts managed by their information system.
Two types of databases will be requested for this exercise
a- A relational database
b- A data warehouse for decision-making

Week 7 - This week, the task set to us is to integrate 7 different APIs into the Rocket Elevators website. those APIs include:
1. Google Maps
2. Twilio
3. Slack
4. DropBox
5. SendGrid
6. IBM Watson
7. ZenDesk 
 
 
📌 Instructions to access to the admin panel:

To login as Admin:
1. Navigation bar : My Account
2. Login
3. Username: admin@admin.com
4. Password: password

To login as Employee:
1. Username: Email of any employee
2. Password: codeboxx1
 
 
📌 Gems used:
1. gem 'bootstrap', '~> 5.0.0.beta1'
2. gem 'jquery-rails'
3. gem "font-awesome-rails"
4. gem 'devise'
5. gem 'rails_admin', '~> 2.0'
6. gem 'toastr-rails'
7. gem 'cancancan'
8. gem 'rails_admin_rollincode', '~> 1.0'
9. gem 'chartkick'
10. gem 'faker'
11. gem 'multiverse'
12. gem 'blazer'
13. gem 'figaro'
14. gem 'slack-notifier'


📌 The queries in mysql:
1. Employee
2. Users
3. Quote
4. Address
5. Battery
6. Building
7. Building Details (Extention Building)
8. Column
9. Customer
10. Elevator
11. Lead

📌 The queries in postgres:
1. Fact Quote
2. Fact Contact
3. Fact Elevator
4. Dim Customer


📚 The three queries:

--How many contact requests are made per month?

SELECT to_char(creation_date, 'YYYY-MM') as "Month"
      ,count(contact_id) as ContactPerMonth
  FROM public.fact_contacts
 group by "Month"
 order by "Month" desc;

--How many bid solicitations are made per month?

SELECT to_char(creation_date, 'YYYY-MM') as "Month"
      ,count(quote_id) as QuotePerMonth
  FROM public.fact_quotes
 group by "Month"
 order by "Month" desc;

--How many elevators per customer do we have?

 SELECT customer_id as "Customer", count(id) as ElevPerCustomers
  FROM public.fact_elevators
 group by "Customer";

API Info

3. Slack

The Slack API runs from the Slack App created and posts to the appropriate channel via a WebHook URL, and using the slack-notifier gem to aid in posting the specified message in the channel when an elevators status is changed.
