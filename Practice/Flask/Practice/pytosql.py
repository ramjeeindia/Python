import pandas as pd
import pyodbc  #pip install pyodbc
cnxn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                      "Server=IT0001\IT0001;"
                      "Database=DB2021;"
                      "Trusted_Connection=yes;")


cursor = cnxn.cursor()
cursor.execute('SELECT ITMSGRPCOD,ITMSGRPNAM FROM OITB')

for row in cursor:
    print('row = %r' % (row,))
    
    # pip install sqlvis