SELECT * FROM [SalesLT].[Product] WHERE COLOR IN ('Red','Blue','Grey')

--using string_split we can extract data avoid space between string comptible from 2016
declare @var varchar(250) = 'Red,Yellow,Grey';
select [value] from STRING_SPLIT(@var, ',');
--this will throw the error then check comability 

--check using db name
select compatibility_level from sys.databases
where name = 'AdventureWorksLT2017'  -- result 110 

---change the compability 110 to 130 
alter database AdventureWorksLT2017
set compatibility_level =130  --result 130


-- use variable in select stat

declare @var2 varchar(250) = 'Red,Yellow,Grey';
SELECT * FROM [SalesLT].[Product] 
WHERE COLOR IN (select [value] from STRING_SPLIT(@var2, ','));