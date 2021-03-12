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
15. gem twilio-ruby


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

1. Google Maps

    In the backoffice, there is a tab labeled Map that shows all of the buildings in tehe Rocket Elevators database, and when a pin is clicked, information about that building is shown.

2. Twilio

    The Twilio API makes it easy to send SMS.
    Whenever the elevator status changes to Intervention, the technical contact responsible for that building will receive an SMS, with the ID, Serial Number and Status of that elevator.

    Note: in order to receive the message, your number needs to be verified by the Twilio platform.
    https://www.twilio.com/
    

3. Slack

    The Slack API runs from the Slack App created and posts to the appropriate channel via a WebHook URL, and using the slack-notifier gem to aid in posting the specified message in the channel when an elevators status is changed.

4. DropBox

    The DropBox API uses the dropbox_api gem as well as the DropBox App that was created to move and store files assiciated to a customer whenever the specific customer is updated or created. It does so by comparing the customers email address to the adresses of the leads, and if they match it creates a directory using the customer contact name for it and sends the file to dropbox if it isn't already there, and deletes the file from the MySQL database. The files can be viewed here: https://www.dropbox.com/home/Apps/Rocket%20Elevators%20API%20Team%203. After clicking the link, you should be able to view all the directories created by the DropBox API. If for whatever reason this link does not work, the account email is burroughsdevtest@gmail.com, and the password is Codeboxx1! . The file path to the files is then Apps/Rocket Elevators API Team 3/.

5. SendGrid

    For our required purposes the SendGrid API allows us the ability to create autogenerated emails that can be sent to users/clients who sign up or complete forms on Rocket Elevators, and is sent to the email used in the Contact Us form.  

6. IBM Watson

7. ZenDesk

    ZenDesk takes the info from a submitted lead or quote and submits it to a ticket in the ZenDesk workspace for RocketElevators to see and deal with. The tickets can be seen at https://rocketelevators8608.zendesk.com/agent/filters/360208008033, and logged into using the email "olaadetula@gmail.com" and password "123456".
