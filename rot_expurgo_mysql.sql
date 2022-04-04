The purpose of the Purge process is the deletion of data that does not need to remain in the database using unnecessarily space in a cloud environment that has a high cost for storing data.
 

1) what are the tables with historical data for deletion? Ans: the 4 TASK , TASK_ASSIGNEE , SUSP_TRANSACTION , AUDIT
2) how long should the data stay in the database? Proposal D-10 keep 10 days later will be deleted
 

1) are the 4 tables
"TASK" Table
CREATED_DT DATE
LAST_UPDATED_DT DATE
column IS_DELETED: Boolean flag that indicates if the ticket is deleted Mandatory: N Sample: true, false

 

"TASK_ASSIGNEE" Table
DT_TASK_ASSIGNED DATE
DT_TASK_UNASSIGNED TIMESTAMP

 
"AUDIT" Table
TASK_UPDATED_DT DATE

"SUSP_TRANSACTION" Table
TRANSACTION_DT DATE

 
2)
Proposal D-10
Reason: Cost on Azure


3) Archival Audit table
Create a dump file of Audit table in file system:
Dump:
mysqldump -u [username] -p [database name] [tablename] > [filename.sql]
mysql -u root -p ods audit > audit.sql

 
Perform the backup of Audit.sql dump file in backup tool.

Delete the file from file system:
rm audit.sql

 
In case there is a need to restore the table, command is:
mysql -u [username] -p [db_name] < [table_name.sql]
mysql -u root -p ods < audit.sql.sql

 

 --TEST
-------------------------------
SHOW VARIABLES WHERE Variable_name='autocommit';
-- autocommit on

--TASK_ASSIGNEE tem menos colunas para teste



    INSERT INTO TASK_ASSIGNEE
   (TASK_ASSIGNEE_UID, AGENT_ALIAS_ID, DT_TASK_ASSIGNED, DT_TASK_UNASSIGNED, TASK_ID ) VALUES
   (null,              'E1234987',     CURDATE(),        CURDATE() - 2,      1003);
 
 
  delete from TASK_ASSIGNEE where TASK_ID=10002 ;
  



ALTER TABLE TASK_ASSIGNEE AUTO_INCREMENT=1001;

--inserir milhoes de registros na tabela para teste

##TEST
CREATE PROCEDURE dorepeat(p1 INT)
BEGIN
    SET @x = 0;
    REPEAT 
            INSERT INTO TASK_ASSIGNEE (TASK_ASSIGNEE_UID, AGENT_ALIAS_ID, DT_TASK_ASSIGNED, DT_TASK_UNASSIGNED, TASK_ID ) VALUES 
			(null, 'E1234987', CURDATE(),CURDATE() - 2, 1003);
        SET @x = @x + 1; 
    UNTIL @x > p1 END REPEAT;
END

CALL dorepeat(10000000); 




##COM ERRO
drop PROCEDURE if  EXISTS insert_mil;
CREATE PROCEDURE insert_mil()
BEGIN
    DECLARE i int DEFAULT 1;
	DECLARE tid int;
    WHILE i <= 10000000 DO
		#SELECT MAX(TASK_ID) INTO tid FROM TASK_ASSIGNEE;
     INSERT INTO TASK_ASSIGNEE
	(TASK_ASSIGNEE_UID, AGENT_ALIAS_ID, DT_TASK_ASSIGNED, DT_TASK_UNASSIGNED, TASK_ID ) VALUES
	(null,              'E1234987',     CURDATE(),        CURDATE() - 2,      1003);
        SET i = i + 1;
    END WHILE;
END;

CALL insert_mil(); 



 -- D-10
SELECT CURDATE() - 10 ;


 

 

Purging commands

 

create index
Better:
CREATE INDEX arr_dep ON history (arrival, departure);
Best:
CREATE INDEX arr_dep ON history (arrival, departure, ...the columns in your select statement...);
CREATE INDEX startdate_idx ON history (`startdate`);
CREATE INDEX enddate_idx ON history (`enddate`);

mysql> EXPLAIN
-> SELECT *
-> FROM history
-> WHERE pid = '003'
-> AND arrival >= '2008-02-04'
-> AND departure <= '2008-02-04'
-> ;



delete
To delete records from a table that have a datetime value in Date_column older than 10 days use this query:

USE Database_name;
DELETE FROM Table_name
WHERE Date_column < GETDATE() - 10;

 

 

 

 

---------------------------------

 

 

 

 

O objetivo do Expurgo � deletar dados que n�o tem necessidade de permanecer no banco de dados, ocupando espa�o desnecessariamente em ambiente Cloud que tem um alto custo de uso

 

 

 

1)quais s�o as tabelas com dados hist�ricos para dele��o ? Resp: as 4 TASK , TASK_ASSIGNEE , SUSP_TRANSACTION , AUDIT

2)quanto tempo os dados devem ficar no database ? Proposta D-10 manter 10 dias depois ser�o deletados

 

1) sao as 4 tabelas

 

"TASK" Table

CREATED_DT      DATE

LAST_UPDATED_DT        DATE

coluna IS_DELETED: Boolean flag that indicates if the ticket is deleted Mandatory: N Sample: true, false

 

"TASK_ASSIGNEE" Table

DT_TASK_ASSIGNED       DATE

DT_TASK_UNASSIGNED TIMESTAMP

 

"AUDIT" Table

TASK_UPDATED_DT        DATE

 

 

"SUSP_TRANSACTION" Table

TRANSACTION_DT           DATE

 

 

2)

Proposta D-10

Motivo: Custo no Azure

 

 