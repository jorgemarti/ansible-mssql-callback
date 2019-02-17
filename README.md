# ansible-mssql-callback
Ansible Callback plugin to log Playbook runs in a MS SQL database

This callback plugin is based on https://github.com/sipgate/ansible-logger but has been deeply modified due to changes in Callback plugins schema after Ansible 2.X, and of course because we ar using MS SQL as database backend.

Absolutely no warranty to work. Just for fun.

Now I'm going to paste some random notes and i will sort them out later:


docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=1234_abcd' -e 'MSSQL_PID=Express' -p 1433:1433 -d microsoft/mssql-server-linux:latest

curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

ACCEPT_EULA=Y yum install msodbcsql17 mssql-tools unixODBC-devel

echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc


https://docs.microsoft.com/es-es/sql/connect/python/pyodbc/step-1-configure-development-environment-for-pyodbc-python-development?view=sql-server-2017

yum install gcc python2-pip python-devel 
pip install --upgrade pip
pip install pyodbc


sqlcmd -S 192.168.1.136,1433 -U SA

CREATE DATABASE TestDB;
USE TestDB;
CREATE TABLE Inventory (id INT, name NVARCHAR(50), quantity INT);
INSERT INTO Inventory VALUES (1, 'banana', 150); INSERT INTO Inventory VALUES (2, 'orange', 154);


create database ansible;
GO
SELECT Name from sys.Databases
GO

For schema conversion:
http://www.sqlines.com/online
