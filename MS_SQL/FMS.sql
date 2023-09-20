Select t0.[AltItem] from OALI T0 Where T0.[OrigItem] = $[$37.4.1]
SELECT T0.[U_UTL_QCCHK] FROM OITM T0 WHERE T0.ItemCode = $[$38.1.1]
SELECT CRD1.U_Distance from CRD1 WHERE CRD1.CardCode=$[OPCH.Cardcode]
SELECT U_RATE FROM [@SACD] where [@SACD].U_SCID  =$[POR1.SacEntry]
select OITW.OnHand  from  oitw LEFT join wtr1	on oitw.itemcode=wtr1.ItemCode 
where OITW.WhsCode=WTR1.WhsCode and OITW.ItemCode=$[$23.1.1]
SELECT Distinct 'True'  FROM OPOR T0 WHERE $[OPOR.U_POTY]='CLOSE'
Select $[$38.11.number] - $[PDN1.U_UTL_RCQT.number]
SELECT T1.Dscription FROM OITM T0 INNER JOIN OCHP T1 ON T1.AbsEntry = T0.ChapterID WHERE T0.ItemCode = $[OAT1.ItemCode]
select TOP 1 Numatcard  from opdn where  OPDN.CardCode=$[$4.0.1] order by DocNum desc
SELECT U_OLDITEM FROM [OITM] where [OITM].ItemCode  =$[POR1.ItemCode]
SELECT OnHand FROM OITW where OITW.itemcode=$[WTR1.ItemCode] and OITW.WhsCode=$[WTR1.WhsCode]

SELECT [T0.BaseAtCard] FROM DLN1 T0 WHERE T0.[U_PONO] = $[T0.BaseAtCard]

SELECT T0.[NumAtCard] FROM DLN1 T0 WHERE T0.[U_PONO] = $[T0.BaseAtCard]
