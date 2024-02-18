import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

conn = psycopg2.connect(
    host="localhost",
    database="flask_db",
    user=os.environ["DB_USERNAME"],
    password=os.environ["DB_PASSWORD"],
)

# Open a cursor to perform database operations
cur = conn.cursor()

# Execute a command: this creates a new table
cur.execute("DROP TABLE IF EXISTS products;")
cur.execute(
    "CREATE TABLE products (id serial PRIMARY KEY,"
    "title varchar (150) NOT NULL,"
    "seller varchar (50) NOT NULL,"
    "buyer varchar,"
    "price integer NOT NULL,"
    "description text,"
    "date_added date DEFAULT CURRENT_TIMESTAMP);"
)

cur.execute("DROP TABLE IF EXISTS services;")
cur.execute(
    "CREATE TABLE services (id serial PRIMARY KEY,"
    "title varchar (150) NOT NULL,"
    "seller varchar (50) NOT NULL,"
    "price integer NOT NULL,"
    "description text,"
    "buyer varchar(50)[],"
    "date_added date DEFAULT CURRENT_TIMESTAMP);"
)


conn.commit()

cur.close()
conn.close()
