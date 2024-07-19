# Import necessary libraries
import kaggle
import pandas as pd
import sqlalchemy as sal
import zipfile

# Download the dataset from Kaggle
!kaggle datasets download ankitbansal06/retail-orders -f orders.csv

# Extract the file from the zip file
with zipfile.ZipFile('orders.csv.zip', 'r') as zip_ref:
    zip_ref.extractall()

# Read data from the file and handle null values
df = pd.read_csv('orders.csv', na_values=['Not Available', 'unknown'])

# Display unique values in the 'Ship Mode' column (to check for consistency and data quality)
print(df['Ship Mode'].unique())

# Clean column names: make them lowercase and replace spaces with underscores
df.columns = df.columns.str.lower().str.replace(' ', '_')
df.head(5)

# Derive new columns: discount, sale price, and profit
df['discount'] = df['list_price'] * df['discount_percent'] * 0.01
df['sale_price'] = df['list_price'] - df['discount']
df['profit'] = df['sale_price'] - df['cost_price']

# Convert 'order_date' from object data type to datetime
df['order_date'] = pd.to_datetime(df['order_date'], format="%Y-%m-%d")

# Drop unnecessary columns
df.drop(columns=['list_price', 'cost_price', 'discount_percent'], inplace=True)

# Load the data into SQL Server using the 'replace' option
engine = sal.create_engine('mssql://ASHISH\SQLEXPRESS/master?driver=ODBC+DRIVER+17+FOR+SQL+SERVER')
conn = engine.connect()

# Load the data into SQL Server using the 'append' option
df.to_sql('df_orders', con=conn, index=False, if_exists='append')

# Export cleaned data to a new CSV file
df.to_csv('cleaned_orders.csv', index=False)
print("Data cleaning and analysis complete. Cleaned data exported to 'cleaned_orders.csv'.")
