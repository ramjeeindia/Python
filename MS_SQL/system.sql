--====================  View Table List========================================

SELECT CODE, NAME ,'System Table' as 'Table Type' FROM RTYP
UNION ALL
SELECT TABLENAME, Descr, 'UDF Table' as 'Table Type' FROM OUTB


--================= Search DocNum in DocType Menu====================

SELECT T0.[DocDate], T0.[ItemCode], T0.[Dscription], 
CASE 
WHEN T0.TransType='1' THEN 'G/L Accounts'
WHEN T0.TransType='2' THEN 'Business Partner'
WHEN T0.TransType='3' THEN 'Bank Codes'
WHEN T0.TransType='4' THEN 'Items'
WHEN T0.TransType='5' THEN 'Tax Definition'
WHEN T0.TransType='6' THEN 'Price Lists'
WHEN T0.TransType='7' THEN 'Special Prices'
WHEN T0.TransType='8' THEN 'Item Properties'
WHEN T0.TransType='9' THEN 'Rate Differences'
WHEN T0.TransType='10' THEN 'Card Groups'
WHEN T0.TransType='11' THEN 'Contact Persons'
WHEN T0.TransType='12' THEN 'Users'
WHEN T0.TransType='13' THEN 'A/R Invoice'
WHEN T0.TransType='14' THEN 'A/R Credit Memo'
WHEN T0.TransType='15' THEN 'Delivery'
WHEN T0.TransType='16' THEN 'Returns'
WHEN T0.TransType='17' THEN 'Sales Order'
WHEN T0.TransType='18' THEN 'A/P Invoice'
WHEN T0.TransType='19' THEN 'A/P Credit Memo'
WHEN T0.TransType='20' THEN 'Goods Receipt PO'
WHEN T0.TransType='21' THEN 'Goods Return'
WHEN T0.TransType='22' THEN 'Purchase Order'
WHEN T0.TransType='23' THEN 'Sales Quotation'
WHEN T0.TransType='24' THEN 'Incoming Payment'
WHEN T0.TransType='25' THEN 'Deposit'
WHEN T0.TransType='26' THEN 'Reconciliation History'
WHEN T0.TransType='27' THEN 'Check Register'
WHEN T0.TransType='28' THEN 'Journal Voucher Entry'
WHEN T0.TransType='29' THEN 'Journal Vouchers List'
WHEN T0.TransType='30' THEN 'Journal Entry'
WHEN T0.TransType='31' THEN 'Items – Warehouse'
WHEN T0.TransType='32' THEN 'Print Preferences'
WHEN T0.TransType='33' THEN 'Activities'
WHEN T0.TransType='34' THEN 'Recurring Postings'
WHEN T0.TransType='35' THEN 'Document Numbering'
WHEN T0.TransType='36' THEN 'Credit Cards'
WHEN T0.TransType='37' THEN 'Currency Codes'
WHEN T0.TransType='38' THEN 'CPI Codes'
WHEN T0.TransType='39' THEN 'Administration'
WHEN T0.TransType='40' THEN 'Payment Terms'
WHEN T0.TransType='41' THEN 'Preferences'
WHEN T0.TransType='42' THEN 'External Bank Statement Received'
WHEN T0.TransType='43' THEN 'Manufacturers'
WHEN T0.TransType='44' THEN 'Card Properties'
WHEN T0.TransType='45' THEN 'Journal Entry Codes'
WHEN T0.TransType='46' THEN 'Outgoing Payments'
WHEN T0.TransType='47' THEN 'Serial Numbers'
WHEN T0.TransType='48' THEN 'Loading Expenses'
WHEN T0.TransType='49' THEN 'Delivery Types'
WHEN T0.TransType='50' THEN 'Length Units'
WHEN T0.TransType='51' THEN 'Weight Units'
WHEN T0.TransType='52' THEN 'Item Groups'
WHEN T0.TransType='53' THEN 'Sales Employee'
WHEN T0.TransType='54' THEN 'Report – Selection Criteria'
WHEN T0.TransType='55' THEN 'Posting Templates'
WHEN T0.TransType='56' THEN 'Customs Groups'
WHEN T0.TransType='57' THEN 'Checks for Payment'
WHEN T0.TransType='58' THEN 'Whse Journal'
WHEN T0.TransType='59' THEN 'Goods Receipt'
WHEN T0.TransType='60' THEN 'Goods Issue'
WHEN T0.TransType='61' THEN 'Cost Center'
WHEN T0.TransType='62' THEN 'Cost Rate'
WHEN T0.TransType='63' THEN 'Project Codes'
WHEN T0.TransType='64' THEN 'Warehouses'
WHEN T0.TransType='65' THEN 'Commission Groups'
WHEN T0.TransType='66' THEN 'Product Tree'
WHEN T0.TransType='67' THEN 'Inventory Transfer'
WHEN T0.TransType='68' THEN 'Production Instructions'
WHEN T0.TransType='69' THEN 'Landed Costs'
WHEN T0.TransType='70' THEN 'Payment Methods'
WHEN T0.TransType='71' THEN 'Credit Card Payment'
WHEN T0.TransType='72' THEN 'Credit Card Management'
WHEN T0.TransType='73' THEN 'Customer/Vendor Cat. No.'
WHEN T0.TransType='74' THEN 'Credit Payments'
WHEN T0.TransType='75' THEN 'CPI and FC Rates'
WHEN T0.TransType='76' THEN 'Postdated Deposit'
WHEN T0.TransType='77' THEN 'Budget'
WHEN T0.TransType='78' THEN 'Budget Cost Assess. Mthd'
WHEN T0.TransType='79' THEN 'Retail Chains'
WHEN T0.TransType='80' THEN 'Alerts Template'
WHEN T0.TransType='81' THEN 'Alerts'
WHEN T0.TransType='82' THEN 'Received Alerts'
WHEN T0.TransType='83' THEN 'Message Sent'
WHEN T0.TransType='84' THEN 'Activity Subjects'
WHEN T0.TransType='85' THEN 'Special Prices for Groups'
WHEN T0.TransType='86' THEN 'Application Start'
WHEN T0.TransType='87' THEN 'Distribution List'
WHEN T0.TransType='88' THEN 'Shipping Types'
WHEN T0.TransType='89' THEN 'Outgoing'
WHEN T0.TransType='90' THEN 'Transition'
WHEN T0.TransType='91' THEN 'Budget Scenario'
WHEN T0.TransType='92' THEN 'Interest Prices'
WHEN T0.TransType='93' THEN 'User Defaults'
WHEN T0.TransType='94' THEN 'Serial Numbers for Items'
WHEN T0.TransType='95' THEN 'Financial Report Templates'
WHEN T0.TransType='96' THEN 'Financial Report Categories'
WHEN T0.TransType='97' THEN 'Opportunity'
WHEN T0.TransType='98' THEN 'Interest'
WHEN T0.TransType='99' THEN 'Interest Level'
WHEN T0.TransType='100' THEN 'Information Source'
WHEN T0.TransType='101' THEN 'Opportunity Stage'
WHEN T0.TransType='102' THEN 'Defect Cause'
WHEN T0.TransType='103' THEN 'Activity Types'
WHEN T0.TransType='104' THEN 'Meetings Location'
WHEN T0.TransType='105' THEN 'Service Calls'
WHEN T0.TransType='106' THEN 'Batch No. for Item'
WHEN T0.TransType='107' THEN 'Alternative Items 2'
WHEN T0.TransType='108' THEN 'Partners'
WHEN T0.TransType='109' THEN 'Competitors'
WHEN T0.TransType='110' THEN 'User Validations'
WHEN T0.TransType='111' THEN 'Posting Period'
WHEN T0.TransType='112' THEN 'Drafts'
WHEN T0.TransType='113' THEN 'Batches and Serial Numbers'
WHEN T0.TransType='114' THEN 'User Display Cat.'
WHEN T0.TransType='115' THEN 'Lender – Pelecard'
WHEN T0.TransType='116' THEN 'Withholding Tax Deduction Hierarchy'
WHEN T0.TransType='117' THEN 'Withholding Tax Deduction Groups'
WHEN T0.TransType='118' THEN 'Branches'
WHEN T0.TransType='119' THEN 'Departments'
WHEN T0.TransType='120' THEN 'Confirmation Level'
WHEN T0.TransType='121' THEN 'Approval Templates'
WHEN T0.TransType='122' THEN 'Docs. for Confirmation'
WHEN T0.TransType='123' THEN 'Checks for Payment Drafts'
WHEN T0.TransType='124' THEN 'Company Info'
WHEN T0.TransType='125' THEN 'Freight Setup'
WHEN T0.TransType='126' THEN 'Sales Tax Authorities'
WHEN T0.TransType='127' THEN 'Sales Tax Authorities Type'
WHEN T0.TransType='128' THEN 'Sales Tax Codes'
WHEN T0.TransType='129' THEN 'Countries'
WHEN T0.TransType='130' THEN 'States'
WHEN T0.TransType='131' THEN 'Address Formats'
WHEN T0.TransType='132' THEN 'A/R Correction Invoice'
WHEN T0.TransType='133' THEN 'Cash Discount'
WHEN T0.TransType='134' THEN 'Query Catagories'
WHEN T0.TransType='135' THEN 'Triangular Deal'
WHEN T0.TransType='136' THEN 'Data Migration'
WHEN T0.TransType='137' THEN 'Workstation ID'
WHEN T0.TransType='138' THEN 'Indicator'
WHEN T0.TransType='139' THEN 'Goods Shipment'
WHEN T0.TransType='140' THEN 'Payment Draft'
WHEN T0.TransType='141' THEN 'Query Wizard'
WHEN T0.TransType='142' THEN 'Account Segmentation'
WHEN T0.TransType='143' THEN 'Account Segmentation Categories'
WHEN T0.TransType='144' THEN 'Location'
WHEN T0.TransType='145' THEN '1099 Forms'
WHEN T0.TransType='146' THEN 'Cycle'
WHEN T0.TransType='147' THEN 'Payment Methods for Payment Wizard'
WHEN T0.TransType='148' THEN '1099 Opening Balance'
WHEN T0.TransType='149' THEN 'Dunning Interest Rate'
WHEN T0.TransType='150' THEN 'BP Priorities'
WHEN T0.TransType='151' THEN 'Dunning Letters'
WHEN T0.TransType='152' THEN 'User Fields – Description'
WHEN T0.TransType='153' THEN 'User Tables'
WHEN T0.TransType='154' THEN 'My Menu Items'
WHEN T0.TransType='155' THEN 'Payment Run'
WHEN T0.TransType='156' THEN 'Pick List'
WHEN T0.TransType='157' THEN 'Payment Wizard'
WHEN T0.TransType='158' THEN 'Payment Results Table'
WHEN T0.TransType='159' THEN 'Payment Block'
WHEN T0.TransType='160' THEN 'Queries'
WHEN T0.TransType='161' THEN 'Central Bank Ind.'
WHEN T0.TransType='162' THEN 'Inventory Revaluation'
WHEN T0.TransType='163' THEN 'A/P Correction Invoice'
WHEN T0.TransType='164' THEN 'A/P Correction Invoice Reversal'
WHEN T0.TransType='165' THEN 'A/R Correction Invoice'
WHEN T0.TransType='166' THEN 'A/R Correction Invoice Reversal'
WHEN T0.TransType='167' THEN 'Service Call Statuses'
WHEN T0.TransType='168' THEN 'Service Call Types'
WHEN T0.TransType='169' THEN 'Service Call Problem Types'
WHEN T0.TransType='170' THEN 'Contract Template'
WHEN T0.TransType='171' THEN 'Employees'
WHEN T0.TransType='172' THEN 'Employee Types'
WHEN T0.TransType='173' THEN 'Employee Status'
WHEN T0.TransType='174' THEN 'Termination Reason'
WHEN T0.TransType='175' THEN 'Education Types'
WHEN T0.TransType='176' THEN 'Customer Equipment Card'
WHEN T0.TransType='177' THEN 'Agent Name'
WHEN T0.TransType='178' THEN 'Withholding Tax'
WHEN T0.TransType='179' THEN 'Already Displayed 347, 349 and WTax Reports'
WHEN T0.TransType='180' THEN 'Tax Report'
WHEN T0.TransType='181' THEN 'Bill of Exchange for Payment'
WHEN T0.TransType='182' THEN 'Bill Of Exchang Transaction'
WHEN T0.TransType='183' THEN 'File Format'
WHEN T0.TransType='184' THEN 'Period Indicator'
WHEN T0.TransType='185' THEN 'Doubtful Debts'
WHEN T0.TransType='186' THEN 'Holiday Table'
WHEN T0.TransType='187' THEN 'BP – Bank Account'
WHEN T0.TransType='188' THEN 'Service Call Solution Statuses'
WHEN T0.TransType='189' THEN 'Service Call Solutions'
WHEN T0.TransType='190' THEN 'Service Contracts'
WHEN T0.TransType='191' THEN 'Service Calls'
WHEN T0.TransType='192' THEN 'Service Call Origins'
WHEN T0.TransType='193' THEN 'User Key Description'
WHEN T0.TransType='194' THEN 'Queue'
WHEN T0.TransType='195' THEN 'Inflation Wizard'
WHEN T0.TransType='196' THEN 'Dunning Terms'
WHEN T0.TransType='197' THEN 'Dunning Wizard'
WHEN T0.TransType='198' THEN 'Sales Forecast'
WHEN T0.TransType='199' THEN 'MRP Scenarios'
WHEN T0.TransType='200' THEN 'Territories'
WHEN T0.TransType='201' THEN 'Industries'
WHEN T0.TransType='202' THEN 'Production Order'
WHEN T0.TransType='203' THEN 'A/R Down Payment'
WHEN T0.TransType='204' THEN 'A/P Down Payment'
WHEN T0.TransType='205' THEN 'Package Types'
WHEN T0.TransType='206' THEN 'User-Defined Object'
WHEN T0.TransType='207' THEN 'Data Ownership – Objects'
WHEN T0.TransType='208' THEN 'Data Ownership – Exceptions'
WHEN T0.TransType='209' THEN ''
WHEN T0.TransType='210' THEN 'Employee Position'
WHEN T0.TransType='211' THEN 'Employee Teams'
WHEN T0.TransType='212' THEN 'Relationships'
WHEN T0.TransType='213' THEN 'Recommendation Data'
WHEN T0.TransType='214' THEN 'User Autorization Tree'
WHEN T0.TransType='215' THEN 'Predefined Text'
WHEN T0.TransType='216' THEN 'Box Definition'
WHEN T0.TransType='217' THEN 'Activity Status'
WHEN T0.TransType='218' THEN '312'
WHEN T0.TransType='219' THEN 'User-Defined Values'
WHEN T0.TransType='220' THEN 'Periods Category'
WHEN T0.TransType='221' THEN 'Attachments'
WHEN T0.TransType='222' THEN 'Grid Filter'
WHEN T0.TransType='223' THEN 'User Language Table'
WHEN T0.TransType='224' THEN 'Multi-Language Translation'
WHEN T0.TransType='225' THEN ''
WHEN T0.TransType='226' THEN ''
WHEN T0.TransType='227' THEN ''
WHEN T0.TransType='229' THEN 'Dynamic Interface (Strings)'
WHEN T0.TransType='230' THEN 'Saved Reconciliations'
WHEN T0.TransType='231' THEN 'House Bank Accounts'
WHEN T0.TransType='232' THEN 'Document'
WHEN T0.TransType='233' THEN 'Document Generation Parameter Sets'
WHEN T0.TransType='234' THEN '#740'
WHEN T0.TransType='238' THEN 'Account Category'
WHEN T0.TransType='239' THEN 'Bank Charges Allocation Codes'
WHEN T0.TransType='241' THEN 'Cash Flow Transactions – Rows'
WHEN T0.TransType='242' THEN 'Cash Flow Line Item'
WHEN T0.TransType='247' THEN 'Business Place'
WHEN T0.TransType='250' THEN 'Local Era Calendar'
WHEN T0.TransType='251' THEN 'Cost Accounting Dimension'
WHEN T0.TransType='254' THEN 'Service Code Table'
WHEN T0.TransType='255' THEN 'Service Group for Brazil'
WHEN T0.TransType='256' THEN 'Material Group'
WHEN T0.TransType='257' THEN 'NCM Code'
WHEN T0.TransType='258' THEN 'CFOP for Nota Fiscal'
WHEN T0.TransType='259' THEN 'CST Code for Nota Fiscal'
WHEN T0.TransType='260' THEN 'Usage of Nota Fiscal'
WHEN T0.TransType='261' THEN 'Closing Date Procedure'
WHEN T0.TransType='263' THEN 'Nota Fiscal Numbering'
WHEN T0.TransType='264' THEN 'Nota Fiscal Tax Category (Brazil)'
WHEN T0.TransType='265' THEN 'Counties'
WHEN T0.TransType='266' THEN 'Tax Code Determination'
WHEN T0.TransType='267' THEN 'BoE Document Type'
WHEN T0.TransType='268' THEN 'BoE Portfolio'
WHEN T0.TransType='269' THEN 'BoE Instruction'
WHEN T0.TransType='271' THEN 'Tax Parameter'
WHEN T0.TransType='275' THEN 'Tax Type Combination'
WHEN T0.TransType='276' THEN 'Tax Formula Master Table'
WHEN T0.TransType='278' THEN 'CNAE Code'
WHEN T0.TransType='280' THEN 'Sales Tax Invoice'
WHEN T0.TransType='281' THEN 'Purchase Tax Invoice'
WHEN T0.TransType='283' THEN 'Cargo Customs Declaration Numbers'
WHEN T0.TransType='290' THEN 'Resources'
WHEN T0.TransType='291' THEN 'Resource Properties'
WHEN T0.TransType='292' THEN 'ResGrpCod'
WHEN T0.TransType='300' THEN 'RecordSet'
WHEN T0.TransType='305' THEN 'Bridge'
WHEN T0.TransType='321' THEN 'Internal Reconciliation'
WHEN T0.TransType='541' THEN 'POS Master Data'
WHEN T0.TransType='1179' THEN 'Stock Transfer Draft'
WHEN T0.TransType='10000105' THEN 'Messaging Service Settings'
WHEN T0.TransType='10000044' THEN 'Batch Numbers Master Data'
WHEN T0.TransType='10000045' THEN 'Serial Numbers Master Data'
WHEN T0.TransType='10000062' THEN 'IVL Vs OINM Keys'
WHEN T0.TransType='10000071' THEN 'Inventory Posting'
WHEN T0.TransType='10000073' THEN 'Financial Year Master'
WHEN T0.TransType='10000074' THEN 'Sections'
WHEN T0.TransType='10000075' THEN 'Certificate Series'
WHEN T0.TransType='10000077' THEN 'Nature of Assessee'
WHEN T0.TransType='10000196' THEN 'Document Type List'
WHEN T0.TransType='10000197' THEN 'UoM Group'
WHEN T0.TransType='10000199' THEN 'UoM Master Data'
WHEN T0.TransType='10000203' THEN 'Bin Field Configuration'
WHEN T0.TransType='10000204' THEN 'Bin Location Attribute'
WHEN T0.TransType='10000205' THEN 'Warehouse Sublevel'
WHEN T0.TransType='10000206' THEN 'Bin Location'
WHEN T0.TransType='140000041' THEN 'DNF Code'
WHEN T0.TransType='231000000' THEN 'Authorization Group'
WHEN T0.TransType='234000004' THEN 'E-Mail Group'
WHEN T0.TransType='243000001' THEN 'Government Payment Code'
WHEN T0.TransType='310000001' THEN 'Inventory Opening Balance'
WHEN T0.TransType='310000008' THEN 'Batch Attributes in Location'
WHEN T0.TransType='410000005' THEN 'Legal List Format'
WHEN T0.TransType='480000001' THEN 'Object: HR Employee Transfer'
WHEN T0.TransType='540000005' THEN 'Tax Code Determination'
WHEN T0.TransType='540000006' THEN 'Purchase Quotation'
WHEN T0.TransType='540000040' THEN 'Recurring Transaction Template'
WHEN T0.TransType='540000042' THEN 'Cost Center Type'
WHEN T0.TransType='540000048' THEN 'Accrual Type'
WHEN T0.TransType='540000056' THEN 'Nota Fiscal Model'
WHEN T0.TransType='540000067' THEN 'Brazil Fuel Indexer'
WHEN T0.TransType='540000068' THEN 'Brazil Beverage Indexer'
WHEN T0.TransType='1210000000' THEN 'Cockpit Main Table'
WHEN T0.TransType='1250000001' THEN 'Inventory Transfer Request'
WHEN T0.TransType='1250000025' THEN 'Blanket Agreement'
WHEN T0.TransType='1320000000' THEN 'Key Performance Indicator Package'
WHEN T0.TransType='1320000002' THEN 'Target Group'
WHEN T0.TransType='1320000012' THEN 'Campaign'
WHEN T0.TransType='1320000028' THEN 'Retorno Operation Codes'
WHEN T0.TransType='1320000039' THEN 'Product Source Code'
WHEN T0.TransType='1470000000' THEN 'Fixed Assets Depreciation Types'
WHEN T0.TransType='1470000002' THEN 'Fixed Assets Account Determination'
WHEN T0.TransType='1470000003' THEN 'Fixed Asset Depreciation Areas'
WHEN T0.TransType='1470000004' THEN 'Depreciation Type Pools'
WHEN T0.TransType='1470000032' THEN 'Asset Classes'
WHEN T0.TransType='1470000046' THEN 'Asset Groups'
WHEN T0.TransType='1470000048' THEN 'G/L Account Determination Criteria – Inventory'
WHEN T0.TransType='1470000049' THEN 'Capitalization'
WHEN T0.TransType='1470000057' THEN 'G/L Account Advanced Rules'
WHEN T0.TransType='1470000060' THEN 'Credit Memo'
WHEN T0.TransType='1470000062' THEN 'Bar Code Master Data'
WHEN T0.TransType='1470000065' THEN 'Inventory Counting'
WHEN T0.TransType='1470000077' THEN 'Discount Groups'
WHEN T0.TransType='1470000092' THEN 'Cycle Count Determination'
WHEN T0.TransType='1470000113' THEN 'Purchase Request'
WHEN T0.TransType='1620000000' THEN 'Workflow – Task Details'
 ELSE 'Addons'
 END AS 'Document Type',T0.[BASE_REF],
CONVERT (varchar,T0.DocDate+365,112) as [ExpDate], CONVERT (varchar,T0.DocDate,112) as [MnfDate] ,CONVERT (varchar,T0.DocDate,112) as [InDate] ,

T0.[InQty], 
SUM (T0.InQty) OVER (partition BY T0.ItemCode order by t0.transnum desc) AS RunningTotal,
T0.[OutQty], T0.[Price], T0.[Currency], T0.[CardCode], T0.[CardName], T0.[Warehouse], T0.[TransNum], T0.[TransType], 
 T0.[CreatedBy], T0.[DocLineNum] FROM OINM T0 
WHERE T0.[ItemCode] =[%0] AND T0.TransType NOT IN ('67','10000071', '13','14','15','202','60','18','19') order by T0.[DocDate] desc



-- =============sap table and size =========================================

SELECT
s.Name AS SchemaName,
t.Name AS TableName,T5.NAME,
p.rows AS RowCounts,
CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB,
CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB,
CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
FROM sys.tables t
INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
LEFT JOIN RTYP T5 ON T5.CODE=t.Name

GROUP BY t.Name, s.Name, p.Rows,T5.NAME
ORDER BY s.Name, t.Name


--=========================ALL ALERT LIST==============================

SELECT T0.[Name] AS 'Alert Name',T0.[Type],T0.[Priority],T0.[Active],T0.[FrqncyType],
T0.[FrqncyIntr],T0.[ExecDaY],T2.U_NAME,T1.[SendIntrnl],T1.[SendEMail],T1.[SendSMS],T1.[SendFax],
T3.QName, T3.QString
FROM [dbo].[OALT] T0
INNER JOIN ALT1 T1 ON T1.CODE= T0.Code
LEFT JOIN OUSR T2 ON T2.USERID = T1.UserSign
LEFT JOIN OUQR T3 ON T3.IntrnalKey = T0.QueryId


---------======= ALL REPORT LIST-------------

SELECT T0.QCategory,T1.CatName, T0.QName, T0.QString
FROM 
   OUQR T0 
   INNER JOIN OQCN t1 ON t0.QCategory = t1.CategoryID 
WHERE 
   (T1.CatName NOT LIKE 'KPI_%' ) AND 
   (T1.CatName NOT LIKE 'SAP_%') AND 
   T0.QString LIKE '%[%0]%' 
ORDER BY T1.CatName