SELECT ORPC.DocEntry, CONVERT(VARCHAR,orpc.DOCDATE,103) as 'DocDate',ORPC.CreateDate,
ORPC.CardCode,ORPC.CardName,
ORPC.NumAtCard,ORPC.TaxDate, 
UPPER(ORPC.ADDRESS) AS 'BILL TO',
UPPER(ORPC.ADDRESS) AS 'SHIP TO'  ,

(SELECT TOP 1 (CAST((ISNULL(T.Building,'')) AS NVARCHAR) + ' ' + ISNULL(T.Street,'') + ' ' + ISNULL(T.Block,'') + 
ISNULL(T.City,'')  + ' ' +  ISNULL(OCST.Name,'') + ' ' +  
ISNULL(T.ZipCode,'') + ' ' +  ISNULL(OCRY.Name,'')) As BillToAddess
FROM CRD1 T 
LEFT OUTER JOIN OCST ON OCST.CODE  = T.STATE  AND OCST.COUNTRY = 'IN'    
LEFT OUTER JOIN OCRY ON OCRY.CODE   = T.COUNTRY  
WHERE T.AdresType = 'B' AND T.CardCode = OCRD.CARDCODE)  As 'Bill To Address' ,

(CAST((ISNULL(crd1.building,'')) as nvarchar) + ' ' + ISNULL(crd1.Street,'')+ ' ' + ISNULL(crd1.Block,'') + ISNULL(CRD1.City,'')  + ' ' ISNULL(OCST.Name,'') + ' ' +  ISNULL(CRD1.ZipCode,'') + ' ' +  ISNULL(OCRY.Name,'')) 'Ship to Address',



rpc1.ITEMCODE, 
(CASE WHEN rpc1.CURRENCY = 'INR' THEN isnull((rpc1.LineTotal),0)ELSE isnull((rpc1.TotalFrgn),0) END ) as VATSUM,
orpc.DISCSUM,rpc1.QUANTITY,OCRD.SHIPTODEF,

rpc1.DSCRIPTION,rpc1.PriceBefDi as PRICE,
(CASE WHEN rpc1.CURRENCY = 'INR' THEN isnull((SELECT SUM(AAA.LineTotal) FROM rpc1 AAA WHERE AAA.DocEntry=orpc.DocEntry),0)ELSE isnull((rpc1.TotalFrgn),0) END ) AS LINETOTAL, 
ISNULL((SELECT TOP 1 ISNULL(TAXRATE,0) FROM rpc4 WHERE  rpc4.DOCENTRY =  rpc1.DOCENTRY AND rpc4.STATYPE   IN ('-100') AND rpc4.RELATETYPE = 1 and rpc4.LINENUM=rpc1.LINENUM) ,0) AS CGSTRATE, 
ISNULL((SELECT CASE WHEN SUM(rpc4.RvsChrgPrc)!=0 
       THEN ((Case When orpc.DocCur = 'INR' Then  SUM(rpc4.TaxSum) Else Sum(rpc4.TaxSumFrgn) End) - (Case When orpc.DocCur = 'INR' Then SUM(rpc4.RvsChrgTax) Else Sum(rpc4.RvsChrgFC) End)) ELSE (Case When orpc.DocCur = 'INR' Then  SUM(rpc4.TaxSum) Else Sum
(rpc4.TaxSumFrgn) End) END  FROM rpc4
       WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND
  rpc4.STATYPE = '-100' AND rpc4.LINENUM=rpc1.LINENUM AND rpc4.RELATETYPE = 1),0) AS CGSTAMNT,

ISNULL((SELECT TOP 1 ISNULL(TAXRATE,0) FROM rpc4 WHERE  rpc4.DOCENTRY =  rpc1.DOCENTRY AND rpc4.STATYPE   IN ('-110','-150') AND rpc4.RELATETYPE = 1 and rpc4 .LINENUM=rpc1 .LINENUM) ,0) AS SGSTRATE,  
ISNULL((SELECT CASE WHEN SUM(rpc4.RvsChrgPrc)!=0 
       THEN ((Case When orpc.DocCur = 'INR' Then  SUM(rpc4.TaxSum) Else Sum(rpc4.TaxSumFrgn) End) - (Case When orpc.DocCur = 'INR' Then SUM(rpc4.RvsChrgTax) Else Sum(rpc4.RvsChrgFC) End)) ELSE (Case When orpc.DocCur = 'INR' Then  SUM(rpc4.TaxSum) Else Sum
(rpc4.TaxSumFrgn) End) END  FROM rpc4
       WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND
  rpc4.STATYPE IN ( '-110','-150') AND rpc4.LINENUM=rpc1.LINENUM AND rpc4.RELATETYPE = 1),0) AS SGSTAMNT, 
   
ISNULL((SELECT TOP 1 ISNULL(TAXRATE,0) FROM rpc4 WHERE  rpc4.DOCENTRY =  rpc1.DOCENTRY AND rpc4.STATYPE   IN ('-120') AND rpc4.RELATETYPE = 1 and rpc4.LINENUM=rpc1.LINENUM) ,0) AS IGSTRATE,   
ISNULL((SELECT CASE WHEN SUM(rpc4.RvsChrgPrc)!=0 
       THEN ((Case When orpc.DocCur = 'INR' Then  SUM(rpc4.TaxSum) Else Sum(rpc4.TaxSumFrgn) End) - (Case When orpc.DocCur = 'INR' Then SUM(rpc4.RvsChrgTax) Else Sum(rpc4.RvsChrgFC) End)) ELSE (Case When orpc.DocCur = 'INR' Then  SUM(rpc4.TaxSum) Else Sum
(rpc4.TaxSumFrgn) End) END  FROM rpc4
       WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND
  rpc4.STATYPE In ( '-120') AND rpc4.LINENUM=rpc1.LINENUM AND rpc4.RELATETYPE = 1),0) AS IGSTAMNT,  
   
ISNULL((SELECT SUM(rpc4.RvsChrgPrc) FROM rpc4 WHERE rpc4.DOCENTRY = rpc1.DOCENTRY),0) AS 'Reverse Charges',
(CASE WHEN rpc1.CURRENCY = 'INR' THEN ISNULL((SELECT SUM(rpc4.RvsChrgTax) FROM rpc4 WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND rpc4.staType in ('-100')),0) 
ELSE ISNULL((SELECT SUM(rpc4.RvsChrgFC) FROM rpc4 WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND rpc4.staType in ('-100')),0)  END) AS 'Reverse CGST Tax',

(CASE WHEN rpc1.CURRENCY = 'INR' THEN ISNULL((SELECT SUM(rpc4.RvsChrgTax) FROM rpc4 WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND rpc4.staType in ('-110','-150')),0) 
ELSE ISNULL((SELECT SUM(rpc4.RvsChrgFC) FROM rpc4 WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND rpc4.staType in ('-110','-150')),0)  END) AS 'Reverse SGST Tax',

(CASE WHEN rpc1.CURRENCY = 'INR' THEN ISNULL((SELECT SUM(rpc4.RvsChrgTax) FROM rpc4 WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND rpc4.staType in ('-120')),0) 
ELSE ISNULL((SELECT SUM(rpc4.RvsChrgFC) FROM rpc4 WHERE rpc4.DOCENTRY = rpc1.DOCENTRY AND rpc4.staType in ('-120')),0)  END) AS 'Reverse IGST Tax',

 ISNULL ((T12.[Chapter]+''+ T12.[Heading]+''+ T12.[SubHeading]),S1.ServCode) as 'TARIFF HEADING',
orpc.DOCDATE,orpc.DocCur ,
rpc1.UNITMSR,  
(ISNULL(OLCT.STREET,'') +' '+ ISNULL(OLCT.BLOCK,'') +' '+ Convert(Varchar(Max),ISNULL(OLCT.Building,'')) +' '+ ISNULL(OLCT.CITY ,'')   
+' '+ ISNULL(OLCT.ZIPCODE,'') +' '+  ISNULL(OLCT.State,'')  +' '+  case when ISNULL(OLCT.Country,'')='IN' THEN 'India' End ) AS ADDRESS,


orpc.DocCur ,

CASE WHEN ISNULL(rpc1.DiscPrcnt ,0)=0 THEN 0 ELSE 
((CASE WHEN  ISNULL(rpc1.Quantity ,0)=0 THEN 1 ELSE   ISNULL(rpc1.Quantity ,0) END) *
(Case When orpc.DocCur = 'INR' Then ISNULL(rpc1.PriceBefDi,0) Else ISNULL(rpc1.PriceBefDi,0) End * ISNULL(rpc1.DiscPrcnt,0)/100)) END 'Disc Amt',
orpc.DiscPrcnt 'Header Disc Percent' ,Case When orpc.DocCur = 'INR' Then  orpc.DiscSum Else orpc.DiscSumFC End 'Header Disc Amt',Case When orpc.DocCur = 'INR' Then orpc.RoundDif Else orpc.RoundDifFC End As RoundDif,
orpc.RevRefDate'Original Ref. Date' ,orpc.RevRefNo 'Original Ref. No.',ISNULL(orpc.Reserve ,'N') as Reserve
,orpc.Comments,
(Case When orpc.DocCur = 'INR' Then ISNULL(rpc1.LineTotal,0) Else ISNULL(rpc1.TotalFrgn,0) End) - ((Case When orpc.DocCur = 'INR' Then ISNULL(rpc1.LineTotal,0) Else ISNULL(rpc1.TotalFrgn,0) End)*(ISNULL(orpc.DiscPrcnt,0)/100))  AS 'Taxable Value',
Case When orpc.DocCur='INR' Then orpc.DpmAmnt Else orpc.DpmAmntFC End 'Total Down Payment',orpc.DocDueDate 'Due Date',(Select Top 1 OCTG.PymntGroup   from OCTG WHERE OCTG.GroupNum=OCRD.GroupNum) 'Payment Terms',
(Select Top 1 OCPR.Name   from OCPR WHERE OCPR.CardCode =CRD1.CardCode) 'Contact Name',
(Select Top 1 OCPR.Cellolar   from OCPR WHERE OCPR.CardCode =CRD1.CardCode) 'Contact Mobile',
(Select Top 1 OCPR.E_MailL   from OCPR WHERE OCPR.CardCode =CRD1.CardCode) 'Contact Email Id',
orpc.NumAtCard 'Ref No',
ISNULL((Select TOP 1 ISNULL(rpc4.StaCode,'') from rpc4 WHERE rpc4.DocEntry=orpc.DocEntry and rpc4.staType in ('-110') AND rpc4.RELATETYPE = 1),'') 'SGST',
ISNULL((Select TOP 1 ISNULL(rpc4.StaCode,'') from rpc4 WHERE rpc4.DocEntry=orpc.DocEntry and rpc4.staType in ('-150') AND rpc4.RELATETYPE = 1),'') 'UGST',
rpc1.DiscPrcnt,
 (SELECT (rpc3.GrsAmount) FROM rpc3 WHERE rpc3.DocEntry=orpc.DocEntry) As 'Freight'
 
FROM     
orpc INNER JOIN rpc1 ON orpc.DOCENTRY=rpc1.DOCENTRY 
 
LEFT OUTER JOIN OCRD   ON orpc.CARDCODE= OCRD.CARDCODE  
LEFT OUTER JOIN CRD1 ON orpc.CARDCODE= CRD1.CARDCODE AND orpc.SHIPTOCODE=CRD1.ADDRESS AND CRD1.ADRESTYPE='S'   
LEFT OUTER JOIN CRD7  ON OCRD.CARDCODE=CRD7.CARDCODE AND CRD7.ADDRTYPE = 'S' AND CRD7.ADDRESS <> '' AND CRD7.ADDRESS=orpc.SHIPTOCODE  
INNER JOIN OITM  ON OITM.ITEMCODE = rpc1.ITEMCODE 
LEFT OUTER JOIN OSHP  ON   OSHP.TRNSPCODE = orpc.TRNSPCODE 
LEFT OUTER JOIN OLCT ON OLCT.CODE  =rpc1.LOCCODE   
LEFT OUTER JOIN  OCST ON OCST.CODE  =CRD1.STATE  AND OCST.COUNTRY = 'IN'    
LEFT OUTER JOIN OCRY ON OCRY.CODE   =crd1.COUNTRY  
lEFT JOIN rpc12 ON orpc.DOCENTRY = rpc12.DOCENTRY  
left outer join  NNM1  on orpc.SERIES=NNM1.SERIES     
LEFT OUTER JOIN CRD1 as t3 ON orpc.CARDCODE= t3.CARDCODE AND orpc.paytocode=t3.ADDRESS AND t3.ADRESTYPE='B'  
LEFT JOIN OCHP T12 ON RPC1.[HsnEntry] = T12.[AbsEntry] 
LEFT JOIN OSAC S1 ON S1.AbsEntry=RPC1.SACEntry
WHERE  orpc.DOCENTRY =3529  