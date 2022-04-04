SELECT * FROM entitle_arg;


use ods


DROP TABLE ROLE_ARG;

use ods;


CREATE TABLE ROLE_ARG
(
	ROLE_UID             INTEGER NOT NULL,
	L1                   VARCHAR(200) NULL,
	L2                   VARCHAR(200) NULL,
	ROLE_NAME            VARCHAR(100) NULL,
	AGENT_ALIAS_ID       VARCHAR(100) NULL,
	SOURCE_SYSTEM_CODE   VARCHAR(20) NULL,
	PROFILE_CODE         VARCHAR(100) NULL,
	PROFILE_VALUE        VARCHAR(100) NULL,
	MODULE               VARCHAR(100) NULL,
	TRANSACTION          VARCHAR(100) NULL,
	PRIVILEGE            VARCHAR(100) NULL,
	ORG_CODE             VARCHAR(100) NULL,
	PROFILE_TYPE         VARCHAR(100) NULL
);



CREATE UNIQUE INDEX XPKENTITLE_ARG ON ROLE_ARG
(
	ROLE_UID
);



ALTER TABLE ROLE_ARG
ADD PRIMARY KEY (ROLE_UID);


ALTER TABLE ROLE_ARG change ROLE_UID ROLE_UID INT(20) AUTO_INCREMENT;
ALTER TABLE ROLE_ARG AUTO_INCREMENT = 231;

	INSERT INTO ROLE_ARG
	(ROLE_UID,L1, L2, ROLE_NAME,AGENT_ALIAS_ID,SOURCE_SYSTEM_CODE,PROFILE_CODE,PROFILE_VALUE,MODULE,	TRANSACTION,PRIVILEGE,ORG_CODE,PROFILE_TYPE)
	VALUES
	(1001,'Card Management','Block Card', 'Card Mgt Block','LC12345678','B2K','SEC_LEVEL_NAME','PRODUCT INFORMATION','TBS','PBM','UNLIMITED','ALL','CCALTEND');




select * from ROLE_ARG;