SELECT DISTINCT T0.DocEntry,T0.DocNum,CONVERT(DATE,T0.DocDate,103) AS 'DocDt.',T0.CardCode,T0.CardName,
T1.ItemCode,T1.Dscription,REPLACE (T8.ChapterID,'.','') as 'HSN',T1.UnitMsr,
SUM(T1.Quantity) AS 'Total Qty',
Avg(T1.Price) as 'Price',
SUM(T1.LineTotal) As 'Tot Line Amt' ,
SUM(T1.U_UTL_RCQT) as 'Tot Recv',
SUM(T1.U_UTL_SHQT) as 'Total Short',
SUM(CONVERT(NUMERIC(19,2),0.00))  as 'RejectedQty',
SUM(T1.Quantity) - SUM(T1.U_UTL_SHQT)- SUM(CONVERT(NUMERIC(19,2),0.00)) as 'AcceptQty',
T0.DocTotal,T0.VatSum as 'Tax',
TRIM(UPPER(CAST((ISNULL(T5.Building,'')) AS NVARCHAR)+ISNULL(T5.Address2,'')+' '+
ISNULL(T5.Address3,'')+' '+ISNULL(T5.STREET,'')+' '+ISNULL(T5.BLOCK,'')+' '+ISNULL(T5.CITY,'')+'-'+
ISNULL(T5.ZipCode,'')+', '+T9.NAME+', '+T10.[Name])) AS 'Pay To Address' ,
UPPER(T5.CITY) as 'BillCity',
UPPER(T9.[Name]) as 'BillState',
T5.GSTRegnNo as 'BillGSTIN' ,
T9.GSTCode AS 'BScode',
T0.U_UTL_GE_EWayBilNo AS 'EwayNo',
T0.U_UTL_GE_VehicleNo as 'VehNo',
T0.U_UTL_GE_DNUM AS 'GENo',
CONVERT(DATE,t0.U_GEDT,103) as 'GEDt' , 
t0.DocCur, T0.NumAtCard as 'INVNo',CONVERT(DATE,T0.TaxDate,103) as 'INVDt',OUSR.U_NAME AS 'Created By',
UPPER(T0.Comments) AS 'Remarks'

FROM OPDN T0 
INNER JOIN PDN1 T1 ON T0.DocEntry=T1.DocEntry
INNER JOIN [@UTL_OQCHK] on T0.DocEntry = [@UTL_OQCHK].DocEntry 
INNER JOIN OCRD T4 ON T4.CardCode=T0.CardCode
LEFT JOIN CRD1 T5 ON T5.CardCode=T0.CardCode AND T5.AdresType='B' AND T0.PayToCode=T5.Address
INNER JOIN OITM T7 ON T7.ItemCode=T1.ItemCode
LEFT JOIN OCHP T8 ON T8.AbsEntry=t7.ChapterID
LEFT JOIN OCST T9 ON T9.Code=T5.State
LEFT JOIN OCRY T10 ON T10.Code=T5.Country
INNER JOIN OUSR ON T0.UserSign = OUSR.USERID 
WHERE T0.DocEntry=16725
GROUP BY
T0.DocEntry,T0.DOCNUM,t0.CardCode,T0.DocDate,T1.ItemCode,T1.Price,T8.ChapterID,T0.CardName,T1.Dscription,
T5.Address2,T5.Address3,T5.STREET,T5.[BLOCK],T5.CITY,T5.GSTRegnNo ,T9.GSTCode,
T5.ZipCode,T9.[NAME],T10.[Name],CAST((ISNULL(T5.Building,'')) AS NVARCHAR),T1.UnitMsr,T0.DocTotal,
T0.U_UTL_GE_EWayBilNo,T0.U_UTL_GE_VehicleNo,T0.U_UTL_GE_DNUM,t0.U_GEDT,t0.DocCur,t0.NumAtCard,T0.TaxDate,
OUSR.U_NAME,T0.VatSum,t0.Comments