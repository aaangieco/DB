--CREATING DB--
CREATE DATABASE "CoinControlDB"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

---CREATING TABLES ---
---- 1. ACCOUNTS (with 2 errors)----
CREATE TABLE public.accounts
(
    accountId serial NOT NULL,
    accountname varchar (50) NOT NULL,
    accountPhonenumber integer NOT NULL,
    accountEmailaddress varchar(50) NOT NULL UNIQUE,
    accountPassword varchar(50) NOT NULL,
    accountaddress varchar(50) NOT NULL,
    PRIMARY KEY (accountId)
);
ALTER TABLE IF EXISTS public.accounts
    OWNER to postgres;

---- 2. PERIODICITY----
CREATE TABLE public.periodicity
(
    periodicityid serial NOT NULL,
    periodicityname varchar(50) NOT NULL,
    PRIMARY KEY (periodicityid)
);
ALTER TABLE IF EXISTS public.periodicity
    OWNER to postgres;

---- 3. INCOMES----
CREATE TABLE public.incomes
(
    incomeid serial NOT NULL,
    incomeconcept varchar(50) NOT NULL,
    incomequantity integer NOT NULL,
    incomedate date  NULL,
    periodicityid integer NOT NULL,
    PRIMARY KEY (incomeid),
    FOREIGN KEY (periodicityid)
        REFERENCES public.periodicity (periodicityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE IF EXISTS public.incomes
    OWNER to postgres;

---- 4. ACCOUNT INCOMES----
CREATE TABLE public.accountincomes
(
    incomeid integer NOT NULL,
    accountid integer NOT NULL,
        PRIMARY KEY (incomeid),
    FOREIGN KEY (accountid)
        REFERENCES public.accounts (accountid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    FOREIGN KEY (incomeid)
        REFERENCES public.incomes (incomeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE IF EXISTS public.accountincomes
    OWNER to postgres;
	
---- 5. EXPENSES----
CREATE TABLE public.expenses
(
    expenseid serial NOT NULL,
    expenseconcept varchar(50) NOT NULL,
    expensequantity integer NOT NULL,
    expensedate date  NULL,
    periodicityid integer NOT NULL,
    PRIMARY KEY (expenseid),
    FOREIGN KEY (periodicityid)
        REFERENCES public.periodicity (periodicityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE IF EXISTS public.expenses
    OWNER to postgres;

---- 6. ACCOUNT EXPENSES----
CREATE TABLE public.accountexpenses
(
    expenseid integer NOT NULL,
    accountid integer NOT NULL,
    PRIMARY KEY (expenseid),
    FOREIGN KEY (accountid)
        REFERENCES public.accounts (accountid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    FOREIGN KEY (expenseid)
        REFERENCES public.expenses (expenseid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE IF EXISTS public.accountexpenses
    OWNER to postgres;

---- 7. SAVINGS (UNNECESSARY TABLE)----
CREATE TABLE public.savings
(
    savingid serial NOT NULL,
    savingdate date NOT NULL,
    PRIMARY KEY (savingid)
);
ALTER TABLE IF EXISTS public.savings
    OWNER to postgres;

---- 8. ACCOUNT SAVINGS (UNNECESSARY TABLE)----
CREATE TABLE public.accountsavings
(
    accountid integer NOT NULL,
    savingid integer NOT NULL,
    PRIMARY KEY (accountid),
    FOREIGN KEY (accountid)
        REFERENCES public.accounts (accountid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    FOREIGN KEY (savingid)
        REFERENCES public.savings (savingid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE IF EXISTS public.accountsavings
    OWNER to postgres;
	
---SIMPLE CONSULTATIONS---
SELECT * FROM accounts;
SELECT * FROM periodicity;
SELECT * FROM incomes;
SELECT * FROM expenses;
SELECT * FROM accountexpenses;
SELECT * FROM accountincomes;
SELECT * FROM savings;
SELECT * FROM accountsavings;

---TABLE MODIFICATIONS---
ALTER TABLE accounts DROP COLUMN accountaddress;
DROP TABLE accountsavings;
DROP TABLE savings;
ALTER TABLE accounts ALTER COLUMN accountphonenumber TYPE VARCHAR;

---INSERTING DATA---
---- 1. ACCOUNTS----
INSERT INTO public.accounts(
	accountname, accountphonenumber, accountemailaddress, accountpassword)
	VALUES ('Angie Corde', '9985361058', 'aaangieco@icloud.com', '@ngieeC0'),
	('Citlaly Bocanegra', '9988765466', 'citboc11@icloud.com', '$$citl22'),
	('Dalia Chim', '9987656678', 'daly099@gmail.com', 'Da@lch33'),
	('Francisco Uc', '9982536474', 'franuc1@gicloud.com', 'franan99$'),
	('Uriel Lampon', '9981116354', 'urilamp@icloud.com', 'uriri89?'),
	('Alexis Yam', '9983354627', 'alyamm@icloud.com', 'hdh#@jjd'),
	('Ada Sanchez', '9876354638', 'adaddds@gmail.com', 'adalin77'),
	('Karla Juarez', '9987453643', 'karljc@outlook.com', 'kQrlQ99@'),
	('Lizbeth Concepcion', '9987654378', 'lconcepcion6@gmail.com', 'c0nC0s23'),
	('Roger Santana', '9987645367', 'rogeliosan@gmail.com', '--yasb33'),
	('Emanuel', '9987645241', 'emac22@gmail.com', '99Angxx3'),
	('Danieer Galvez', '9987446677', 'dgalvez0@icloud.com', 'd@ng77dt'),
	('Nadia Huer', '9987882112', 'pphnad@icloud.com', 'n@dhu3#'),
	('Yareli Cordero', '9988233345', 'yarcor22@icloud..com', 'dag%nf55'),
	('Jhossie Piña', '9982661022', 'yosip@gmail.com', 'dAl88#45');

---SIMPLE CONSULTATIONS---
SELECT * FROM accounts;

----TABLE MODIFICATIONS----
UPDATE accounts SET accountname = 'Angie Cordero' WHERE accountid = 1;
UPDATE accounts SET accountname = 'Adayarith Sanchez' WHERE accountid = 7;
UPDATE accounts SET accountname = 'Emanuel Colli' WHERE accountid = 11;
UPDATE accounts SET accountname = 'Nadia Huerta' WHERE accountid = 13

---SIMPLE CONSULTATIONS---
SELECT * FROM accounts;

---FUNCTION---
----ADD PERIODICITY----
CREATE OR REPLACE FUNCTION add_periodicity(periodicityname VARCHAR(50))
RETURNS VOID AS $$
BEGIN
    INSERT INTO periodicity (periodicityname) VALUES (periodicityname);
END;
$$ LANGUAGE plpgsql;

---INSERTING DATA (using a function)---
---- 2. PERIODICITY----
SELECT add_periodicity('Weekly');
SELECT add_periodicity('Biweekly');
SELECT add_periodicity('Monthly');

----INSERTING DATA----
---- 3. INCOMES----
INSERT INTO public.incomes(
	incomeconcept, incomequantity, incomedate, periodicityid)
	VALUES ('Salary', 25000, '2024/01/31', 3),
	('Bonus', 5000, '2024/01/31', 3),
	('Salary', 25000, '2024/01/31', 3),
	('Salary', 12500, '2024/01/31', 2),
	('Bonus', 3000, '2024/01/15', 2),
	('Salary', 12500, '2024/01/15', 2),
	('Gift', 2500, '2024/01/07', 1),
	('Gift', 2750, '2024/02/07', 1),
	('Salary', 6250, '2024/02/07', 1),
	('Salary', 12500, '2024/02/15', 2),
	('Bonus', 5000, '2024/02/29', 3),
	('Gift', 2150, '2024/02/07', 1),
	('Bonus', 2200, '2024/02/07', 1),
	('Gift', 2350, '2024/02/15', 2),
	('Gift', 2350, '2024/03/07', 1),
	('Salary', 2350, '2024/03/15', 2),
	('Gift', 2350, '2024/03/07', 1),
	('Bonus', 2350, '2024/03/15', 2),
	('Bonus', 2350, '2024/03/07', 1),
	('Salary', 25000, '2024/03/31', 3);

----4. ACCOUNT INCOMES----
INSERT INTO public.accountincomes(
	incomeid, accountid)
	VALUES (1, 1),
	(2, 1),
	(3, 2),
	(5, 3),
	(7, 3),
	(8, 3),
	(11, 4),
	(12, 4),
	(4, 5),
	(13, 5),
	(14, 5),
	(6, 6),
	(15, 6),
	(9, 7),
	(17, 7),
	(10, 8),
	(18, 8),
	(19, 9),
	(16, 9),
	(20, 10);

---TABLE MODIFICATIONS---
ALTER TABLE expenses ADD COLUMN expensebill VARCHAR;

---INSERTING DATA---
----5. EXPENSES----
INSERT INTO public.expenses(
	expenseconcept, expensequantity, expensedate, periodicityid, expensebill)
	VALUES ('Rent', 3500, '2024/01/31', 3, 'Fixed'),
	('Rent', 3500, '2024/01/31', 3, 'Fixed'),
	('Rent', 4000, '2024/02/29', 3, 'Fixed'),
	('Rent', 4000, '2024/03/31', 3, 'Fixed'),
	('Electricity', 1000, '2024/01/31', 3, 'Fixed'),
	('Electricity', 1250, '2024/01/31', 3, 'Fixed'),
	('Electricity', 1500, '2024/03/31', 3, 'Fixed'),
	('Water', 800, '2024/01/31', 3, 'Fixed'),
	('Water', 850, '2024/02/29', 3, 'Fixed'),
	('Water', 750, '2024/03/31', 3, 'Fixed'),
	('Water', 600, '2024/03/31', 3, 'Fixed'),
	('Internet', 560, '2024/01/31', 3, 'Fixed'),
	('Internet', 660, '2024/01/31', 3, 'Fixed'),
	('Internet', 560, '2024/02/29', 3, 'Fixed'),
	('Food', 1200, '2024/01/07', 1, 'Fixed'),
	('Food', 1200, '2024/02/07', 1, 'Fixed'),
	('Food', 1200, '2024/03/15', 2, 'Fixed'),
	('Transportation', 550, '2024/01/15', 2, 'Variable'),
	('Transportation', 450, '2024/02/07', 1, 'Variable'),
	('Accident', 2000, '2024/01/15', 2, 'Contingencies');

----6. ACCOUNT EXPENSES----
INSERT INTO public.accountexpenses(
	expenseid, accountid)
	VALUES (1, 1),
	(5, 1),
	(6, 2),
	(7, 3),
	(8, 3),
	(2, 3),
	(9, 4),
	(15, 4),
	(10, 5),
	(16, 5),
	(20, 5),
	(3, 6),
	(11, 6),
	(12, 7),
	(17, 7),
	(13, 8),
	(18, 8),
	(14, 9),
	(19, 9),
	(4, 10);

---SIMPLE CONSULTATIONS---
SELECT accountid, accountname FROM accounts;
SELECT incomeid, incomeconcept, incomequantity FROM incomes;
SELECT * FROM incomes WHERE incomedate > '2024/02/29';
SELECT * FROM incomes WHERE incomedate > '2024/02/29' AND incomeconcept = 'Gift';
SELECT * FROM expenses ORDER BY expensedate DESC;
SELECT * FROM incomes ORDER BY incomedate ASC;
SELECT * FROM accounts ORDER BY accountid LIMIT 7;
SELECT * FROM accountincomes OFFSET 2;
SELECT periodicityid, COUNT(*) FROM expenses GROUP BY periodicityid;
SELECT * FROM incomes WHERE incomeconcept = 'Bonus' OR incomeconcept = 'Gift';

---INNER JOIN---
SELECT incomes.incomeconcept AS income_concept, periodicity.periodicityname AS periodicity_name
FROM incomes
INNER JOIN periodicity ON incomes.periodicityid = periodicity.periodicityid;

---LEFT JOIN---
SELECT accounts.accountid, accounts.accountname, accountincomes.incomeid
FROM accounts
LEFT JOIN accountincomes ON accounts.accountid = accountincomes.accountid;

---RIGHT JOIN---
SELECT accounts.accountid, accounts.accountname, accountexpenses.expenseid
FROM accounts
RIGHT JOIN accountexpenses ON accounts.accountid = accountexpenses.accountid;

---FULL JOIN---
SELECT incomes.incomeid, incomes.incomequantity, accountincomes.accountid
FROM incomes
FULL JOIN accountincomes ON incomes.incomeid = accountincomes.incomeid;

---CREATING TABLE: ACCOUNT_AUDITS---
CREATE TABLE accounts_audits(
	accountid integer,
	accountname varchar(50),
	modifieddate timestamp
)

---TABLE MODIFICATIONS---
DELETE FROM accounts WHERE accountid BETWEEN 11 AND 15;
update accounts set accountname='Jimena Chim' where accountid=3;

---FUNCTIONS---
----COUNT ACCOUNTS----
CREATE OR REPLACE FUNCTION count_accounts() 
RETURNS INT 
AS 
$$
DECLARE
  total_accounts INT;
BEGIN
  SELECT COUNT(*) INTO total_accounts FROM accounts;
  RETURN total_accounts;
END;
$$ LANGUAGE plpgsql;

----COUNT PASSWORD DIGITS----
CREATE OR REPLACE FUNCTION count_password_digits(password VARCHAR) 
RETURNS BOOLEAN 
AS 
$$
DECLARE
    password_quantity INTEGER;
BEGIN
    password_quantity := LENGTH(password);
    
    IF password_quantity = 8 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

----COUNT PHONE NUMBER DIGITS----
CREATE OR REPLACE FUNCTION count_phonenumber_digits(phonenumber VARCHAR)
 RETURNS BOOLEAN AS
 $$
DECLARE
    phonenumber_quantity INTEGER;
BEGIN
    phonenumber_quantity := LENGTH(phonenumber);
    
    IF phonenumber_quantity = 10 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

----FIND MAX INCOME----
CREATE OR REPLACE FUNCTION find_max_income() 
RETURNS RECORD 
AS 
$$
DECLARE
    income RECORD;
BEGIN
    SELECT * INTO income FROM incomes ORDER BY incomequantity DESC LIMIT 1;
    RETURN income;
END;
$$ LANGUAGE plpgsql;

---SIMPLE CONSULTATIONS---
SELECT count_accounts();
SELECT count_password_digits('@ngi3C0o');
SELECT count_phonenumber_digits('9985361058');
SELECT find_max_income();

---TRIGGER (AUDITS)---
----LOG ACCOUNT NAME CHANGES----
CREATE OR REPLACE FUNCTION log_account_name_changes()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.accountname <> OLD.accountname THEN
		 INSERT INTO accounts_audits(accountid,accountname,modifieddate)
		 VALUES(OLD.accountid,OLD.accountname,now());
	END IF;

	RETURN NEW;
END;
$$

CREATE OR REPLACE TRIGGER accountstrackaccountnamechanges
    BEFORE UPDATE
    ON public.accounts
    FOR EACH ROW
    EXECUTE FUNCTION public.log_account_name_changes();

COMMENT ON TRIGGER accountstrackaccountnamechanges ON public.accounts
    IS 'audita los cambios de accountname';

---SIMPLE CONSULTATIONS---
SELECT * FROM accounts_audits;

---TRIGGERS---
----UPDATE INCOME DATE----
CREATE OR REPLACE FUNCTION updateincomedate()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	
	UPDATE incomes
	SET incomedate=now()
	where incomeid=NEW.incomeid;

	RETURN NEW;
END;
$$

CREATE OR REPLACE TRIGGER triggerupdateincomedate 
AFTER INSERT
ON incomes
FOR EACH ROW
	EXECUTE FUNCTION updateincomedate()
	
----UPDATE EXPENSE DATE----
CREATE OR REPLACE FUNCTION updateexpensedate()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	
	UPDATE expenses
	SET expensedate=now()
	where expenseid=NEW.expenseid;

	RETURN NEW;
END;
$$

CREATE OR REPLACE TRIGGER triggerupdateexpensedate 
AFTER INSERT
ON expenses
FOR EACH ROW
	EXECUTE FUNCTION updateexpensedate()

----UPDATE ACCOUNT DATE----
CREATE OR REPLACE FUNCTION updateaccountdate()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	
	UPDATE accounts
	SET accountdate=now()
	WHERE accountid=NEW.accountid;

	RETURN NEW;
END;
$$

CREATE OR REPLACE TRIGGER triggerupdateaccountdate 
AFTER INSERT
ON accounts
FOR EACH ROW
	EXECUTE FUNCTION updateaccountdate()

---SIMPLE CONSULTATIONS---
ALTER TABLE accounts ADD COLUMN accountdate timestamp

---STORED PROCEDURE---
----UPDATE ACCOUNT NAME----
CREATE PROCEDURE update_accountname(accId integer, newaccountname varchar)
LANGUAGE SQL
AS $$

update accounts
set
	accountname=newaccountname
where accountid=accId;
$$;

----SIMPLE CONSULTATIONS----
CALL public.update_accountname(
	3, 'Delannie Chim')
	
----INSERT ACCOUNTS----
CREATE OR REPLACE PROCEDURE insert_accounts(accountname varchar, accountphonenumber varchar, accountemailaddress varchar, accountpassword varchar)
LANGUAGE SQL
AS $$
	INSERT INTO accounts(accountname, accountphonenumber, accountemailaddress, accountpassword)
		VALUES(accountname, accountphonenumber, accountemailaddress, accountpassword)
$$;

SELECT accountid, accountname, accountphonenumber, accountemailaddress, accountpassword
	FROM public.accounts;

---SIMPLE CONSULTATIONS---
CALL  insert_accounts('Juan Bocanegra', '9981156118', 'figo@mail.com', '16363vduyg$');
CALL insert_accounts('Cecilia Martinez', '9922256138', 'ceci@mail.com', '$djd$$');
CALL insert_accounts('Enrique Mata','9954275987','kike@gmail.com','krea678');
SELECT accountid, accountname, accountphonenumber,accountemailaddress
	FROM public.accounts;
SELECT * FROM accounts

---STORED PROCEDURE---
----INSERT EXPENSE----
CREATE OR REPLACE PROCEDURE insert_expense(expenseconcept varchar,expensequantity integer ,expensedate date,periodicityid integer,expensebill varchar)
LANGUAGE SQL
AS $$
	INSERT INTO expenses(expenseconcept ,expensequantity ,expensedate ,periodicityid ,expensebill )
		VALUES(expenseconcept , expensequantity , expensedate , periodicityid , expensebill )
$$;

---SIMPLE CONSULTATIONS---
CALL insert_expense('Water',235,'2024/04/10', 3,'Fixed');
SELECT expenseid, expenseconcept, expensequantity, periodicityid
	FROM public.expense;
SELECT * FROM expenses

----INSERT INCOME----
CREATE OR REPLACE PROCEDURE insert_income(incomeconcept varchar ,incomequantity integer ,incomedate date ,periodicityid integer)
LANGUAGE SQL
AS $$
	INSERT INTO incomes( incomeconcept,incomequantity,incomedate,periodicityid)
		VALUES(incomeconcept ,incomequantity ,incomedate ,periodicityid  )
$$;


---VIEWS---
----EXPENSES CONCEPT----
CREATE OR REPLACE VIEW expensesconcept
AS
	SELECT expenseconcept, expensedate
    FROM expenses

----INCOMES QUANTITY----
CREATE OR REPLACE VIEW incomesquantity
AS
	SELECT incomequantity, incomeconcept
    FROM incomes

---SIMPLE CONSULTATIONS---
SELECT * FROM expensesconcept
SELECT * FROM incomesquantity
