# ansible-mssql-callback

## Introduction
Ansible Callback plugin to log Playbook runs in a MS SQL database

This callback plugin is based on [ansible-logger](https://github.com/sipgate/ansible-logger) but has been deeply modified due to changes in Callback plugins schema after Ansible 2.X, and of course because we ar using MS SQL as database backend.

Absolutely no warranty to work. Just for fun.
Now I'm going to paste some random notes and i will sort them out later:

## Prerequisites Setup
We are going to use a dockerized image of MS SQL for the tests.

### SQL database 

```bash
mkdir /var/opt/mssql # You know, for persistance
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=1234_abcd' -v /var/opt/mssql:/var/opt/mssql --name sqlserver -e 'MSSQL_PID=Express' -p 1433:1433 -d microsoft/mssql-server-linux:latest
```
### SQLcmd and pyodbc
Download last version of mssql tools and pyodbc:

```bash
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

ACCEPT_EULA=Y yum install msodbcsql17 mssql-tools unixODBC-devel

echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
```
Reference for [pyodb](https://docs.microsoft.com/es-es/sql/connect/python/pyodbc/step-1-configure-development-environment-for-pyodbc-python-development?view=sql-server-2017):

```bash
yum install gcc python2-pip python-devel 
pip install --upgrade pip
pip install pyodbc
```
### Create database for ansible

Our SQL server is running on that IP and port:

  sqlcmd -S 192.168.1.136,1433 -U SA
```sql
create database ansible;
GO
SELECT Name from sys.Databases
GO
```
Exit and load the schema in `schema.sql`:

```bash
sqlcmd -S 192.168.1.136,1433 -U SA -i schema.sql
```

For schema conversion we used the tool below:
http://www.sqlines.com/online

## Enabling the callback

Edit your ansible.cfg and whitelist this callback