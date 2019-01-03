# This is DayTrader CLI

Created by: Timothy Quirk

This CLI was created as a final project to completed Module 1 at the Flatiron School. For specific project requirements please refer to the 'Project Guidelines' below.

This meant to be a fun way to play around with stock data, and to see how stocks change over time. I seeded the database with stock information from the IEX stock api. “Data provided for free by IEX. View IEX’s Terms of Use.” https://iextrading.com/developer/docs/#before-we-begin

## Install

To install, fork this repository and run 'bundle install' in your terminal.

## Demo

Please click on the image below if you would like to see how the app functions:
[![alt text][image]][reference link]

[image]: https://img.youtube.com/vi/VJFTkUNRDY8/0.jpg "DayTrader CLI Demo Video"
[reference link]: https://www.youtube.com/watch?v=VJFTkUNRDY8



## Overview  

Investors are able to make fake trades (using live stock data).
Stock data is stored in the Stock class
Trade data is stored in the Trade class
All user account info is kept in the Account class

Users sign in (or create a new account) with their name.
When accounts are created, they are randomly given a bank account balance to play with.
Stock quotes are looked up in real-time. The quotes run on a 15-min delay using IEXtrading information.
For a trade to be completed, the user has to have the appropriate funds to cover the cost of the trade.
Once users own a stock, they can sell all shares or partial shares as they wish.
The program will do an analysis of your stocks and their performance.
You may research (get stock quotes) on any stock you wish.






#  Final Project Guidelines

For your final project for Module One, I built a Command Line database application using stock data from the IEX api.
“Data provided for free by IEX. View IEX’s Terms of Use.” https://iextrading.com/developer/docs/#before-we-begin

## Project Requirements

### Data Analytics Project

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have at minimum three models including one join model. This means you must have a many-to-many relationship.
3. You should seed your database using data that you collect either from a CSV, a website by scraping, or an API.
4. Your models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
5. You should provide a CLI to display the return values of your interesting methods.  
6. Use good OO design patterns. You should have separate classes for your models and CLI interface.

## Instructions

1. Fork and clone this repository.
2. Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.
3. Make sure to create a good README.md with a short description, install instructions, a contributors guide and a link to the license for your code.
4. Make sure your project checks off each of the above requirements.
5. Prepare a video demo (narration helps!) describing how a user would interact with your working project.
    * The video should:
      - Have an overview of your project.(2 minutes max)
6. Prepare a presentation to follow your video.(3 minutes max)
    * Your presentation should:
      - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      - Discuss 3 things you learned in the process of working on this project.
      - Address, if anything, what you would change or add to what you have today?
      - Present any code you would like to highlight.   
7. *OPTIONAL, BUT RECOMMENDED*: Write a blog post about the project and process.
