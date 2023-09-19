USE [SHAPLLIVE]
GO
/****** Object:  StoredProcedure [dbo].[SBO_SP_PostTransactionNotice]    Script Date: 19/09/2023 11:09:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[SBO_SP_PostTransactionNotice]

@object_type nvarchar(30), 				-- SBO Object Type
@transaction_type nchar(1),			-- [A]dd, [U]pdate, [D]elete, [C]ancel, C[L]ose
@num_of_cols_in_key int,
@list_of_key_cols_tab_del nvarchar(255),
@list_of_cols_val_tab_del nvarchar(255)

AS

begin

-- Return values
declare @error  int				-- Result (0 for no error)
declare @error_message nvarchar (200) 		-- Error string to be displayed
select @error = 0
select @error_message = N'Ok'
declare @DocEntry nvarchar(200)
declare @LineId nvarchar(200)
declare @U_UTL_STATS nvarchar(200)
declare @status  int 
select @status=1
declare @GEDocEntry nvarchar(50)

--------------------------------------------------------------------------------------------------------------------------------

--	ADD	YOUR	CODE	HERE
----------------------------------------------------Purchase Order Remaining Quantity(Gate Inward)---------------------
IF ((@transaction_type = 'U') AND @object_type = '22')
BEGIN
UPDATE T6
SET 
T6."U_UTL_RQTY" = 
(Select ( Case When ISNULL(T1."OpenQty",0.0)-ISNULL(SUM(T2."U_UTL_RQTY"), 0.0) >0.0 Then 
(ISNULL(T1."OpenQty",0.0)-ISNULL(SUM(T2."U_UTL_RQTY"), 0.0))
+ISNULL(SUM(T2.U_UTL_RQTY), 0.0)
ELSE
(ISNULL(T1."OpenQty",0.0)-ISNULL(SUM(T2."U_UTL_RQTY"), 0.0))
+ISNULL(SUM(T2.U_UTL_RQTY), 0.0)
END) As "Re"
from OPOR T0 
Inner Join POR1 T1 On T0."DocEntry" = T1."DocEntry" 
INNER JOIN "@UTL_GE_GIN1" T2 ON T2."U_UTL_BASENTR" = T0."DocEntry" and T2."U_UTL_ITCD" = T1."ItemCode" 
AND T2."U_UTL_BASELINE" = T1."LineNum"
inner join "@UTL_GE_OGIN" T3 on T2."DocEntry" =T3."DocEntry" 
WHERE  T3."Canceled" = 'N'   and T0."DocEntry"=@list_of_cols_val_tab_del AND T2."U_UTL_TRGTNTR" IS NOT NULL
Group By T1."OpenQty" )

from OPOR T4 
Inner Join POR1 T5 On T4."DocEntry" = T5."DocEntry" 
INNER JOIN "@UTL_GE_GIN1" T6 ON T6."U_UTL_BASENTR" = T4."DocEntry" and T6."U_UTL_ITCD" = T5."ItemCode" 
AND T6."U_UTL_BASELINE" = T5."LineNum"
inner join "@UTL_GE_OGIN" T7 on T6."DocEntry" =T7."DocEntry" 
WHERE  T7."Canceled" = 'N' AND T6."U_UTL_TRGTNTR" IS NOT NULL  and T4."DocEntry"=@list_of_cols_val_tab_del;
 
END

---------------TAX CODE FILL AS PER GRPO IN ITEM MASTER UDF-----------------------------------------------

If (@object_type ='20') and (@transaction_type='A')
    
BEGIN

UPDATE OITM
SET OITM.U_RATE = CONVERT (NUMERIC(10,2),OSTC.Rate) from OSTC
inner join PDN1 on PDN1.TaxCode = OSTC.Code 
where PDN1.ItemCode= OITM.ItemCode
  
     END

------------------------------------GRPO------------------------------------------------
IF ((@transaction_type = 'A') AND @object_type = '20')
BEGIN

DECLARE cur_row CURSOR
STATIC FOR 
SELECT  T1.DocEntry,T1.LineId,T1.U_UTL_STATS, T0.DocEntry as GEHED_DocEntry FROM [@UTL_GE_GIN1] T1 INNER JOIN [@UTL_GE_OGIN] T0 on T1.DocEntry=T0.DocEntry INNER JOIN PDN1 T2 ON T1.DocEntry=T2.U_UTL_GE_DocE and T1.LineId=T2.U_UTL_GE_Line where T2.DocEntry=@list_of_cols_val_tab_del;
OPEN cur_row
IF @@CURSOR_ROWS > 0
 BEGIN 
 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS,@DocEntry
 WHILE @@Fetch_status = 0
 BEGIN


  UPDATE [@UTL_GE_GIN1]  set U_UTL_STATS ='C',U_UTL_TRGTDOC=(SELECT DocNum from OPDN WHERE DocEntry=@list_of_cols_val_tab_del), U_UTL_TRGTNTR=@list_of_cols_val_tab_del, U_UTL_OBJTR=@object_type WHERE DocEntry= @DocEntry and  LineId=@LineId;

 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS,@DocEntry
 END
END
CLOSE cur_row
DEALLOCATE cur_row
SET NOCOUNT OFF 

END


IF ((@transaction_type = 'A') AND @object_type = '20')
BEGIN

DECLARE cur_row CURSOR
STATIC FOR 

   SELECT  DISTINCT T1.DocEntry,T1.LineId,ISNULL(T1.U_UTL_STATS,'O') AS U_UTL_STATS FROM [@UTL_GE_GIN1] T1 
 LEFT JOIN PDN1 T0 on T1.DocEntry=T0.U_UTL_GE_DocE
 WHERE ISNULL(T1.U_UTL_ITCD,'NULL') !='NULL' and T0.DocEntry=@list_of_cols_val_tab_del

OPEN cur_row
IF @@CURSOR_ROWS > 0
 BEGIN 
 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS
 WHILE @@Fetch_status = 0
 BEGIN

  set @GEDocEntry = @DocEntry;
		               IF(@U_UTL_STATS='O')
		               BEGIN
		              set   @status = 0;
		               END ;
 

 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS
 END
            IF(@status=1)
                BEGIN
                
                 UPDATE [@UTL_GE_OGIN]  set Status='C',U_UTL_STATS='C' WHERE DocEntry=@GEDocEntry;
                END ;
END
CLOSE cur_row
DEALLOCATE cur_row
SET NOCOUNT OFF 

END

IF ((@transaction_type = 'A') AND @object_type = '20')
BEGIN


SELECT DISTINCT isnull(T3.OpenQty,0) AS 'Quantity',  isnull(T3.OpenQty,0) AS 'RemQuantity',
T3.DocEntry,T3.LineNum,T3.ObjType,T0.DocEntry As 'GRPODocEntry',T0.ObjType As 'GRPOObjectType'
into #TEMP2 
FROM OPDN T0
INNER JOIN PDN1 T1 ON T1.DocEntry=T0.DocEntry
INNER JOIN PDN1 T2 ON T2.DocEntry=T1.BaseEntry AND T2.LineNum=T1.BaseLine AND T2.ObjType=T1.BaseType
INNER JOIN POR1 T3 ON T3.DocEntry=T2.BaseEntry AND T3.LineNum=T2.BaseLine AND T3.ObjType=T2.BaseType
INNER JOIN [@UTL_GE_GIN1] T4 ON T4.U_UTL_BASENTR=T3.DocEntry AND T4.U_UTL_BASELINE=T3.LineNum 
and T4.U_UTL_OBJTYP=T3.ObjType 
WHERE T0.DocEntry=@list_of_cols_val_tab_del AND (T0.CANCELED='C' or T0.DocStatus='C')

UPDATE T4
SET T4.U_UTL_RQTY = ISNULL(T3.RemQuantity,0)
FROM  [@UTL_GE_GIN1] T4 
INNER JOIN #TEMP2 T3 ON T4.U_UTL_BASENTR=T3.DocEntry AND T4.U_UTL_BASELINE=T3.LineNum and T4.U_UTL_OBJTYP=T3.ObjType 
and T4.U_UTL_TRGTNTR=T3.GRPODocEntry and T4.U_UTL_OBJTR=T3.GRPOObjectType

DROP TABLE #TEMP2

SELECT DISTINCT isnull(T3.OpenQty,0) AS 'Quantity',  isnull(T3.OpenQty,0) AS 'RemQuantity',
T3.DocEntry,T3.LineNum,T3.ObjType,T0.DocEntry As 'GRPODocEntry',T0.ObjType As 'GRPOObjectType'
into #TEMP4 
FROM OPDN T0
INNER JOIN PDN1 T2 ON T2.DocEntry=T0.DocEntry
INNER JOIN POR1 T3 ON T3.DocEntry=T2.BaseEntry AND T3.LineNum=T2.BaseLine AND T3.ObjType=T2.BaseType
INNER JOIN [@UTL_GE_GIN1] T4 ON T4.U_UTL_BASENTR=T3.DocEntry AND T4.U_UTL_BASELINE=T3.LineNum and T4.U_UTL_OBJTYP=T3.ObjType 
WHERE T0.DocEntry=@list_of_cols_val_tab_del AND T0.DocStatus='O'

UPDATE T4
SET T4.U_UTL_RQTY = ISNULL(T3.RemQuantity,0)
FROM  [@UTL_GE_GIN1] T4 
INNER JOIN #TEMP4 T3 ON T4.U_UTL_BASENTR=T3.DocEntry AND T4.U_UTL_BASELINE=T3.LineNum 
and T4.U_UTL_OBJTYP=T3.ObjType --and T4.U_UTL_TRGTNTR=T3.GRPODocEntry and T4.U_UTL_OBJTR=T3.GRPOObjectType

DROP TABLE #TEMP4
END;

----------------------------------------------------------------GOODS RETURN-----------------------------

IF ((@transaction_type = 'A') AND @object_type = '21')
BEGIN

Select DISTINCT T2.Quantity,T2.OpenQty,T2.DocEntry,T2.LineNum,T2.ObjType
into #TEMP1 FROM RPD1 T0
INNER JOIN ORPD T4 ON T4.DocEntry=T0.DocEntry
INNER JOIN PDN1 T1 on T1.DocEntry=T0.BaseEntry and T1.ObjType=T0.BaseType and T1.LineNum=T0.BaseLine 
INNER JOIN POR1 T2 on T2.DocEntry=T1.BaseEntry and T2.LineNum=T1.BaseLine and T2.ObjType=T1.BaseType
INNER JOIN [@UTL_GE_GIN1] T3 ON T3.U_UTL_BASENTR = T2.DocEntry AND T3.U_UTL_BASELINE=T2.LineNum 
and T2.ObjType=T3.U_UTL_OBJTYP
where T0.DocEntry=@list_of_cols_val_tab_del and DocStatus='C' --and T0.Quantity<>T2.Quantity

UPDATE T3 
SET  T3.U_UTL_RQTY = isnull(T2.OpenQty,0)
FROM [@UTL_GE_GIN1] T3
INNER JOIN #TEMP1 T2 ON T2.ObjType=T3.U_UTL_OBJTYP and T3.U_UTL_BASENTR = T2.DocEntry AND T3.U_UTL_BASELINE=T2.LineNum 

DROP TABLE #TEMP1


Select DISTINCT T2.Quantity,T2.OpenQty,T2.DocEntry,T2.LineNum,T2.ObjType
into #TEMP3 FROM RPD1 T0
INNER JOIN ORPD T4 ON T4.DocEntry=T0.DocEntry
INNER JOIN PDN1 T1 on T1.DocEntry=T0.BaseEntry and T1.ObjType=T0.BaseType and T1.LineNum<>T0.BaseLine 
INNER JOIN POR1 T2 on T2.DocEntry=T1.BaseEntry and T2.LineNum=T1.BaseLine and T2.ObjType=T1.BaseType
INNER JOIN [@UTL_GE_GIN1] T3 ON T3.U_UTL_BASENTR = T2.DocEntry AND T3.U_UTL_BASELINE=T2.LineNum 
and T2.ObjType=T3.U_UTL_OBJTYP
where T0.DocEntry=@list_of_cols_val_tab_del and DocStatus='C' --and T0.Quantity<>T2.Quantity

UPDATE T3 
SET  T3.U_UTL_RQTY = isnull(T2.OpenQty,0)
FROM [@UTL_GE_GIN1] T3
INNER JOIN #TEMP3 T2 ON T2.ObjType=T3.U_UTL_OBJTYP and T3.U_UTL_BASENTR = T2.DocEntry AND T3.U_UTL_BASELINE=T2.LineNum 

DROP TABLE #TEMP3
END;
----------------------------------------------------------------GOODS RECEIPT-----------------------------
IF ((@transaction_type = 'A') AND @object_type = '59')
BEGIN

DECLARE cur_row CURSOR
STATIC FOR 
SELECT  T1.DocEntry,T1.LineId,T1.U_UTL_STATS, T0.DocEntry as GEHED_DocEntry FROM [@UTL_GE_GIN1] T1 INNER JOIN [@UTL_GE_OGIN] T0 on T1.DocEntry=T0.DocEntry INNER JOIN IGN1 T2 ON T1.DocEntry=T2.U_UTL_GE_DocE and T1.LineId=T2.U_UTL_GE_Line where T2.DocEntry=@list_of_cols_val_tab_del;
OPEN cur_row
IF @@CURSOR_ROWS > 0
 BEGIN 
 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS,@DocEntry
 WHILE @@Fetch_status = 0
 BEGIN


  UPDATE [@UTL_GE_GIN1]  set U_UTL_STATS ='C',U_UTL_TRGTDOC=(SELECT DocNum from OIGN WHERE DocEntry=@list_of_cols_val_tab_del), U_UTL_TRGTNTR=@list_of_cols_val_tab_del, U_UTL_OBJTR=@object_type WHERE DocEntry= @DocEntry and  LineId=@LineId;

 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS,@DocEntry
 END
END
CLOSE cur_row
DEALLOCATE cur_row
SET NOCOUNT OFF 

END


IF ((@transaction_type = 'A') AND @object_type = '59')
BEGIN

DECLARE cur_row CURSOR
STATIC FOR 

   SELECT  DISTINCT T1.DocEntry,T1.LineId,ISNULL(T1.U_UTL_STATS,'O') AS U_UTL_STATS FROM [@UTL_GE_GIN1] T1 
 LEFT JOIN IGN1 T0 on T1.DocEntry=T0.U_UTL_GE_DocE
 WHERE ISNULL(T1.U_UTL_ITCD,'NULL') !='NULL' and T0.DocEntry=@list_of_cols_val_tab_del

OPEN cur_row
IF @@CURSOR_ROWS > 0
 BEGIN 
 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS
 WHILE @@Fetch_status = 0
 BEGIN

  set @GEDocEntry = @DocEntry;
		               IF(@U_UTL_STATS='O')
		               BEGIN
		              set   @status = 0;
		               END ;
 

 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS
 END
            IF(@status=1)
                BEGIN
                
                 UPDATE [@UTL_GE_OGIN]  set Status='C',U_UTL_STATS='C' WHERE DocEntry=@GEDocEntry;
                END ;
END
CLOSE cur_row
DEALLOCATE cur_row
SET NOCOUNT OFF 

END

----------------------------------------------------AR CREDIT MEMO-----------------------------------------------------
IF ((@transaction_type = 'A') AND @object_type = '14')
BEGIN

DECLARE cur_row CURSOR
STATIC FOR 
SELECT  T1.DocEntry,T1.LineId,T1.U_UTL_STATS, T0.DocEntry as GEHED_DocEntry FROM [@UTL_GE_GIN1] T1 INNER JOIN [@UTL_GE_OGIN] T0 on T1.DocEntry=T0.DocEntry INNER JOIN RIN1 T2 ON T1.DocEntry=T2.U_UTL_GE_DocE and T1.LineId=T2.U_UTL_GE_Line where T2.DocEntry=@list_of_cols_val_tab_del;
OPEN cur_row
IF @@CURSOR_ROWS > 0
 BEGIN 
 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS,@DocEntry
 WHILE @@Fetch_status = 0
 BEGIN


  UPDATE [@UTL_GE_GIN1]  set U_UTL_STATS ='C',U_UTL_TRGTDOC=(SELECT DocNum from ORIN WHERE DocEntry=@list_of_cols_val_tab_del), U_UTL_TRGTNTR=@list_of_cols_val_tab_del, U_UTL_OBJTR=@object_type WHERE DocEntry= @DocEntry and  LineId=@LineId;

 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS,@DocEntry
 END
END
CLOSE cur_row
DEALLOCATE cur_row
SET NOCOUNT OFF 

END


IF ((@transaction_type = 'A') AND @object_type = '14')
BEGIN

DECLARE cur_row CURSOR
STATIC FOR 

   SELECT  DISTINCT T1.DocEntry,T1.LineId,ISNULL(T1.U_UTL_STATS,'O') AS U_UTL_STATS FROM [@UTL_GE_GIN1] T1 
 LEFT JOIN RIN1 T0 on T1.DocEntry=T0.U_UTL_GE_DocE
 WHERE ISNULL(T1.U_UTL_ITCD,'NULL') !='NULL' and T0.DocEntry=@list_of_cols_val_tab_del

OPEN cur_row
IF @@CURSOR_ROWS > 0
 BEGIN 
 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS
 WHILE @@Fetch_status = 0
 BEGIN

  set @GEDocEntry = @DocEntry;
		               IF(@U_UTL_STATS='O')
		               BEGIN
		              set   @status = 0;
		               END ;
 

 FETCH NEXT FROM cur_row INTO @DocEntry,@LineId,@U_UTL_STATS
 END
            IF(@status=1)
                BEGIN
                
                 UPDATE [@UTL_GE_OGIN]  set Status='C',U_UTL_STATS='C' WHERE DocEntry=@GEDocEntry;
                END ;
END
CLOSE cur_row
DEALLOCATE cur_row
SET NOCOUNT OFF 

END


----------------------------------------------------------------AP CREDIT MEMO-----------------------------

IF ((@transaction_type = 'A') AND @object_type = '19')
BEGIN

SELECT DISTINCT T5.Quantity,T5.OpenQty,T5.DocEntry,T5.LineNum,T6.ObjType
into #TEMP6 
FROM PCH1 T1
INNER JOIN OPCH T3 ON T3."DocEntry"=T1."DocEntry"
INNER JOIN RPC1 T2 ON T1."DocEntry" = T2."BaseEntry" AND T1."LineNum" = T2."BaseLine" AND T1."ObjType" = T2."BaseType"
INNER JOIN PDN1 T4 ON T4."DocEntry"=T1."BaseEntry" AND T4."LineNum"=T1."BaseLine"
INNER JOIN POR1 T5 on T5."DocEntry"=T4."BaseEntry" and T5."LineNum"=T4."BaseLine" and T5."ObjType"=T4."BaseType"
INNER JOIN OPOR T6 ON T6."DocEntry"=T5."DocEntry"
Where T2."DocEntry"=@list_of_cols_val_tab_del


UPDATE T3 
SET  T3.U_UTL_RQTY = isnull(T6.OpenQty,0)
FROM [@UTL_GE_GIN1] T3
INNER JOIN #TEMP6 T6 ON T6.ObjType=T3.U_UTL_OBJTYP and T3.U_UTL_BASENTR = T6.DocEntry AND T3.U_UTL_BASELINE=T6.LineNum 

DROP TABLE #TEMP6
END;



---------------------------------------------------------------------- gate entry canceled

IF ((@transaction_type = 'C') AND @object_type = 'UTL_GE_UDO_INWARD')
BEGIN
      UPDATE [@UTL_GE_OGIN]   set Canceled='Y',U_UTL_STATS='X' WHERE DocEntry=@list_of_cols_val_tab_del; 
END ;
-------------------------------------------------------------------- gate pass canceled
IF ((@transaction_type = 'C') AND @object_type = 'UTL_GE_UDO_OUTWARD')
BEGIN
      UPDATE [@UTL_GE_OGPS]  set Canceled='Y',U_UTL_STATS='X' WHERE DocEntry=@list_of_cols_val_tab_del; 
END ;
------------------------------------------------------------------------

---------------------------------------------------------------------- gate entry closed

IF ((@transaction_type = 'L') AND @object_type = 'UTL_GE_UDO_INWARD')
BEGIN
      UPDATE [@UTL_GE_OGIN]   set Status='C',U_UTL_STATS='C' WHERE DocEntry=@list_of_cols_val_tab_del; 
END ;
-------------------------------------------------------------------- gate pass closed
IF ((@transaction_type = 'L') AND @object_type = 'UTL_GE_UDO_OUTWARD')
BEGIN
      UPDATE [@UTL_GE_OGPS]   set Status='C',U_UTL_STATS='C' WHERE DocEntry=@list_of_cols_val_tab_del; 
END ;
------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- Select the return values
select @error, @error_message

end

