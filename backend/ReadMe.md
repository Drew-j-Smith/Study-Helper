## Creating the mysql database

Creating user

`CREATE USER 'user' IDENTIFIED BY 'password';`

Grant privilages

`GRANT ALL PRIVILEGES ON * . * TO 'user';`

Create Database

`CREATE DATABASE StudyHelperDatabase;`

Create Table

`CREATE TABLE StudyHelperUsers (email TEXT, hash VARCHAR(43), salt VARCHAR(16), data TEXT);`

## Installing python packages

dotenv

`python -m pip install --target packages python-dotenv`

mysql

`python -m pip install --target packages mysql-connector-python`
