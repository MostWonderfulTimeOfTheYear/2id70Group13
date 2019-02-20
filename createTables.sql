-- This file should create the tables
-- An example follows, replace it with your own commands.
-- SQL files can be executed from command-line using psql -d THE_DATABASE_NAME -f THE_FILENAME
-- Notice the UNLOGGED option, which drastically increases performance and reduces space usage

CREATE UNLOGGED TABLE myPhonebook(id int, name varchar(50), address varchar(200), phoneNumber varchar(100));
