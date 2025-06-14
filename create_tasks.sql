CREATE OR REPLACE TASK SELECT_CARD_BRAND
  SCHEDULE = '1 MINUTE'
  AS
    CREATE OR REPLACE VIEW SELECT_CARD_VIEW AS
    SELECT *
    FROM CARDS_DATA2
    WHERE CARD_BRAND='Visa';;
    

CREATE OR REPLACE TASK REMOVE_DOLLAR_SIGN
  AFTER SELECT_CARD_BRAND
AS
  UPDATE CARDS_DATA2 SET CREDIT_LIMIT = REPLACE(CREDIT_LIMIT, '$', '');;    


CREATE OR REPLACE TASK SPLIT_ADDRESS
  AFTER SELECT_CARD_BRAND
AS
  CREATE OR REPLACE VIEW SELECT_ADDRESS_VIEW AS
  SELECT *, LEFT(ADDRESS, CHARINDEX(' ', ADDRESS) - 1) AS HOUSE_NUMBER,    
  RIGHT(ADDRESS, LEN(ADDRESS) - CHARINDEX(' ', ADDRESS)) AS STREET
  FROM USERS_DATA2;;

CREATE OR REPLACE TASK CREATE_TIME_TO_RETIREMENT
  AFTER SPLIT_ADDRESS
AS
  CREATE OR REPLACE VIEW SELECT_RETIREMENT_VIEW AS
  SELECT *, RETIREMENT_AGE - CURRENT_AGE AS YEARS_BEFORE_RETIREMENT
    FROM USERS_DATA2;

CREATE OR REPLACE TASK JOIN_TABLES
  AFTER CREATE_TIME_TO_RETIREMENT, REMOVE_DOLLAR_SIGN
AS
    CREATE OR REPLACE VIEW SELECT_JOIN_VIEW AS
    SELECT cd.ID, cd.CARD_BRAND, cd.CARD_TYPE, us.credit_score, us.num_credit_cards
    FROM CARDS_DATA2 cd
    LEFT JOIN USERS_DATA2 us ON cd.ID = us.ID;

ALTER TASK SELECT_CARD_BRAND SUSPEND;