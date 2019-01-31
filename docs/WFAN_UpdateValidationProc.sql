create or replace PROCEDURE WFAN_UpdateValidationProc (UpdIdlist IN NCLOB, TblName IN nvarchar2,  p_IdsProcessed OUT INT)
AS
BEGIN
    IF (TblName = 'COMBHOMEACCT') THEN 
    BEGIN
        UPDATE COMBHOMEACCT SET UPDATEDTM = sysdate
        WHERE COMBHOMEACCTID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
    ELSIF (TblName = 'DATASOURCE') THEN  
    BEGIN
        UPDATE DATASOURCE SET UPDATEDTM = sysdate
        WHERE DATASOURCEID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
	    ELSIF (TblName = 'EMPLOYMENTSTAT') THEN  
    BEGIN
        UPDATE EMPLOYMENTSTAT SET UPDATEDTM = sysdate
        WHERE EMPLOYMENTSTATID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
	    ELSIF (TblName = 'LABORACCT') THEN  
    BEGIN
        UPDATE LABORACCT SET UPDATEDTM = sysdate
        WHERE LABORACCTID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
	    ELSIF (TblName = 'ORG') THEN  
    BEGIN
        UPDATE ORG SET UPDATEDTM = sysdate
        WHERE ORGID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
	    ELSIF (TblName = 'PAYCODE') THEN  
    BEGIN
        UPDATE PAYCODE SET UPDATE_DTM = sysdate
        WHERE PAYCODEID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
	    ELSIF (TblName = 'PERSON') THEN  
    BEGIN
        UPDATE PERSON SET UPDATEDTM = sysdate
        WHERE PERSONID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
	    ELSIF (TblName = 'WFCJOBORG') THEN  
    BEGIN
        UPDATE WFCJOBORG SET UPDATEDTM = sysdate
        WHERE WFCJOBORGID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
	    ELSIF (TblName = 'WFCTOTAL') THEN  
    BEGIN
        UPDATE WFCTOTAL SET UPDATEDTM = sysdate, TOTALEDVERSION = null
        WHERE WFCTOTALID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
		ELSIF (TblName = 'SCHEDULEDTOTAL') THEN  
    BEGIN
        UPDATE SCHEDULEDTOTAL SET UPDATEDTM = sysdate, TOTALEDVERSION = null
        WHERE SCHEDULEDTOTALID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
        ELSIF (TblName = 'NRTWFCTOTALDEL') THEN  
    BEGIN
        UPDATE NRTWFCTOTALDEL SET UPDATEDTM = sysdate, TOTALEDVERSION = null
        WHERE WFCTOTALID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;
        ELSIF (TblName = 'NRTSCHEDULEDTOTALDEL') THEN  
    BEGIN
        UPDATE NRTSCHEDULEDTOTALDEL SET UPDATEDTM = sysdate, TOTALEDVERSION = null
        WHERE SCHEDULEDTOTALID IN (SELECT column_value FROM TABLE (fn_IntegerInList (UpdIdlist)));
        p_IdsProcessed := SQL%ROWCOUNT;
    END;

    ELSE -- No Update for Table found
     BEGIN
        p_IdsProcessed := 0;
     END;
    END IF;
    COMMIT;

END;
/

CREATE OR REPLACE PUBLIC SYNONYM "WFAN_UPDATEVALIDATIONPROC" FOR "TKCSOWNER"."WFAN_UPDATEVALIDATIONPROC";
/

create or replace
TRIGGER NRTTRG_WFCTOTAL_UPD 
  BEFORE UPDATE ON WFCTOTAL FOR EACH ROW
   BEGIN
   
   IF :new.totaledversion IS NOT NULL THEN
   
        select TOTALEDVERSION into :new.totaledversion 
        from NRTBGPTOTALEDVERSION WHERE EMPLOYEEID = :new.employeeid;
        

        
     END IF;

	 :new.UPDATEDTM := SYSDATE;
        
   END;
   /

   create or replace
TRIGGER NRTTRG_SCHEDULEDTOTAL_UPD 
  BEFORE UPDATE ON SCHEDULEDTOTAL FOR EACH ROW
   BEGIN
   
   IF :new.totaledversion IS NOT NULL THEN
   
        select TOTALEDVERSION into :new.totaledversion 
        from NRTBGPTOTALEDVERSION WHERE EMPLOYEEID = :new.employeeid;
        
        
     END IF;

	:new.UPDATEDTM := SYSDATE;
        
   END;
   /




