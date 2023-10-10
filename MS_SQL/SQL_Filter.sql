SELECT T0.[DocNum], T0.[DocStatus], T0.[CardCode], T0.[CardName], T0.[DocDate], T0.[DocDueDate], 
T1.[ItemCode], T1.[Dscription], T1.[Quantity], T1.[Price], T1.[LineTotal] ,t1.openqty

FROM OPOR T0  
INNER JOIN POR1 T1 ON T0.[DocEntry] = T1.[DocEntry]

where 

(T0.DocDate >= CONVERT(DATETIME, '[%0]', 112) OR '[%0]' = '') 
AND (T0.DocDate <= CONVERT(DATETIME, '[%1]', 112) OR '[%1]' = '')
AND (T0.CardName = N'[%2]' OR '[%2]' = '') 
AND (T1.ItemCode = N'[%3]' OR '[%3]' = '') 
