https://mariadb.com/kb/en/sql-99-complete-really/
https://mariadb.com/kb/en/alter-table-statement/
ALTER TABLE Table_1 ADD COLUMN 
      column_1 SMALLINT DEFAULT 150;
-- The <keyword> COLUMN in the ADD [COLUMN] clause is noise and can be omitted.
	ALTER TABLE Table_1 ADD 
      column_1 SMALLINT DEFAULT 150;
-- change column name
https://mariadb.com/kb/en/alter-table/
ALTER [ONLINE] [IGNORE] TABLE tbl_name CHANGE [COLUMN] old_col_name new_col_name column_definition [FIRST|AFTER col_name]
ALTER TABLE tbl_name CHANGE old_col_name new_col_name column_definition [FIRST|AFTER col_name]
-- change column
ALTER TABLE MODIFY [COLUMN] col_name column_definition
        [FIRST | AFTER col_name]
-- boolean data type
https://mariadb.com/kb/en/boolean-data-types/
CREATE TABLE Logicals (
  boolean_1 BOOLEAN,
  boolean_2 BOOLEAN,
  boolean_3 BOOLEAN);

INSERT INTO Logicals VALUES (TRUE,FALSE,UNKNOWN);

https://mariadb.com/kb/en/boolean-literal-s/
 A <Boolean literal> is one of these three words:

    TRUE
    FALSE
    UNKNOWN
-- combine two columns
https://stackoverflow.com/questions/6157573/mysql-trying-to-populate-data-into-one-column-from-another-table
https://stackoverflow.com/questions/11193924/mysql-conditionally-populate-column-3-based-on-distinct-involving-2-other-column
