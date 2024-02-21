### Test for successful connection to server's database

  1. Clone the repository

  ```
  git clone https://github.com/haugmarkus/HealthInformaticsDatabaseConnectionTest.git
  ```

  2. Populate .env file with your credentials
  ```
  DB_USERNAME=username
  DB_PASSWORD=pw
  DB_PORT=65432
  DB_SERVER=localhost
  DB_NAME=maitt
  ```

  3. Initiate ssh connection

  ```
  ssh -L 65432:localhost:5432 username@server_name
  ```

  4. Run the code in test.R

  ```
  Rscript test.R
  ```

  5. If succesful you should see:

  ```
  > test_dbi_connection()
  [1] "Connection successful with DBI"
  > test_database_connector_connection()
  Connecting using PostgreSQL driver
  [1] "Connection successful with DatabaseConnector"
  ```
