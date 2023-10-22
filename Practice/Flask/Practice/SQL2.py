import pandas as pd
import pyodbc  #pip install pyodbc
from sqlvis import vis
import sqlite3

conn = sqlite3.connect('DB2021')
# Retrieve the shema from the db connection
schema = vis.schema_from_conn(conn)
query = '''
SELECT ITMSGRPCOD,ITMSGRPNAM FROM OITB;
'''

# Generate the visualization.
vis.visualize(query, schema)

# cnxn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
#                       "Server=IT0001\IT0001;"
#                       "Database=DB2021;"
#                       "Trusted_Connection=yes;")


# cursor = cnxn.cursor()
# cursor.execute('SELECT ITMSGRPCOD,ITMSGRPNAM FROM OITB')

# for row in cursor:
#     print('row = %r' % (row,))
    
    # pip install sqlvis