# Steps and basic commands: 

1. Create the file repository configuration:
# sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt / 
$(lsb_release -cs)-pgdg main" > / 
/etc/apt/sources.list.d/pgdg.list'

2. Create the file repository configuration:
# sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

3. Import the repository signing key:
# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

4. Update the package lists:
sudo apt-get update

5. Install the latest version of PostgreSQL.
If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
# sudo apt-get -y install postgresql

6 To check postgresql status issue the following: 
# systemctl status postgresql: 
or 
# systemctl stop postgresql > if you want to stop it. 
or 
# systemctl restart postgresql > if you want to restart it. 

7. Let’s configure postgresql which is located in: 
# Edit the below: 

listen_addresses = '*' # what IP address(es) to listen on;
port = 5432                    # (change requires restart)
max_connections = 100          # (change requires restart)
shared_buffers = 1000MB                 # min 128kB
work_mem = 64MB                         # min 64kB
maintenance_work_mem = 128MB            # min 1MB
log_line_prefix = '%m [%p] %q%u@%d '    # special values

# Once you’re done save the configuration and exit. 
8. You need to restart Postgresql once you applied the above: 
# systemctl restart postgresql 
9. Access Postgresql via command line: 
# sudo su -l postgres
# psql

10. Create database:
create database test;

# to access databse via command line: 
\c test 

# to backup database: 
pg_dump yourDatabaseName | gzip > yourDatabaseName.sql.gz
pg_dump test | gzip > test_backup.sql.gz
# to restore: 

gunzip -c yourDatabaseName.sql.gz | psql yourDatabaseName

# to select table sizes: 
select schemaname as table_schema,
       relname as table_name,
       pg_size_pretty(pg_relation_size(relid)) as data_size
from pg_catalog.pg_statio_user_tables
order by pg_relation_size(relid) desc;

# to create a user with full permissions: 
CREATE USER test_user WITH  PASSWORD 'UseStrongPassword';


GRANT CONNECT ON DATABASE test TO test_user;
grant select, update, insert,delete   on ALL TABLES in SCHEMA public to test_user;
grant select, insert ,delete on ALL TABLES in SCHEMA public to test_user;
GRANT USAGE ON all SEQUENCES IN SCHEMA public TO test_user;
GRANT select  ON ALL SEQUENCES IN SCHEMA public TO test_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE  ON SEQUENCES TO test_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT select ON SEQUENCES TO test_user;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO test_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO test_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT select, update, insert, delete ON TABLES TO test_user;
GRANT ALL ON ALL TABLES IN SCHEMA public to test_user;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public to test_user;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public to test_user;




