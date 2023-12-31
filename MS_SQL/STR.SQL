SELECT T0.ItemCode,T0.Quantity  FROM WTQ1 T0 
		INNER JOIN OWTQ T2 ON T2.DOCENTRY= T0.DOCENTRY
		INNER JOIN (SELECT TOP 1 DOCENTRY,SUBSTRING(Comments, PATINDEX('%[0-9]%', Comments), 
        PATINDEX('%[0-9][^0-9]%', Comments + 't') - PATINDEX('%[0-9]%', Comments) + 1) AS Number 
		FROM OWTQ ORDER BY DOCENTRY DESC) P ON P.DOCENTRY = T2.DOCENTRY
		LEFT JOIN (SELECT ITEMCODE,SUM(ONHAND) AS [WIPSTK] FROM OITW           
		WHERE WhsCode IN ('ASM','PWH','PKG','IPQA','FGW')     
		GROUP BY ITEMCODE) T3 ON T3.ItemCode=T0.ItemCode 
		LEFT JOIN (SELECT WOR1.ITEMCODE,SUM(WOR1.PlannedQty) AS [PLANSTK] FROM WOR1  
		INNER JOIN OWOR ON OWOR.DOCENTRY=WOR1.DocEntry 
		WHERE CreateDate >= GETDATE()-4 AND OWOR.CmpltQty IS NULL
		GROUP BY WOR1.ITEMCODE) T5 ON T5.ItemCode=T0.ItemCode 
					   
		WHERE T0.DocEntry = 31248 	AND

		(T0.ITEMCODE NOT LIKE '334%' OR T0.ITEMCODE NOT LIKE '335%' 
		OR T0.ITEMCODE NOT LIKE '2%' OR T0.ITEMCODE NOT LIKE '99900100000') 

		AND T0.Quantity > (T3.WIPSTK + [PLANSTK]) AND 
		T0.ItemCode =((SELECT WOR1.ItemCode, OWOR.DocNum FROM WOR1 
		INNER JOIN OWOR ON OWOR.DOCENTRY = WOR1.DOCENTRY )ON R ON R.DOCNUM = 
		(SELECT TOP 1 DOCENTRY,SUBSTRING(Comments, PATINDEX('%[0-9]%', Comments), 
        PATINDEX('%[0-9][^0-9]%', Comments + 't') - PATINDEX('%[0-9]%', Comments) + 1) )




select top 10 * from owor

SELECT * FROM OWTQ WHERE DOCENTRY = 31248
SELECT * FROM WTQ1 WHERE DOCENTRY = 31248

SELECT SUBSTRING(Comments, PATINDEX('%[0-9]%', Comments), 
PATINDEX('%[0-9][^0-9]%', Comments + 't') - 
PATINDEX('%[0-9]%', Comments) + 1) AS Number
FROM OWTQ WHERE DOCENTRY = 31248
