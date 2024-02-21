# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Install required packages
if (!requireNamespace("DBI", quietly = TRUE)) install.packages("DBI")
if (!requireNamespace("DatabaseConnector", quietly = TRUE)) install.packages("DatabaseConnector")
if (!requireNamespace("dotenv", quietly = TRUE)) install.packages("dotenv")
if (!requireNamespace("RPostgres", quietly = TRUE)) install.packages("RPostgres")

library(DBI)
library(DatabaseConnector)
library(dotenv)
library(RPostgres)

# Create database port forwarding in eduroam with ssh:
# ssh -L 65432:localhost:5432 username@rita-maitt.cloud.ut.ee

# Load environment variables
dotenv::load_dot_env(".env")

# Database connection parameters from environment variables
db_username <- Sys.getenv("DB_USERNAME")
db_password <- Sys.getenv("DB_PASSWORD")
db_port <- Sys.getenv("DB_PORT")
db_server <- Sys.getenv("DB_SERVER")
db_name <- Sys.getenv("DB_NAME")

# Function to test DBI connection with PostgreSQL
test_dbi_connection <- function() {
  conn <- DBI::dbConnect(RPostgres::Postgres(),
                         dbname = db_name,
                         host = db_server,
                         port = db_port,
                         user = db_username,
                         password = db_password)
  if (!is.null(conn)) {
    print("Connection successful with DBI")
    DBI::dbDisconnect(conn)
  } else {
    print("Failed to connect with DBI")
  }
}

# Function to test DatabaseConnector connection with PostgreSQL
test_database_connector_connection <- function() {
  connectionDetails <- DatabaseConnector::createConnectionDetails(
    dbms="postgresql",
    server=paste(db_server,"/",db_name, sep = ""),
    user=db_username,
    password=db_password,
    port=db_port,
    pathToDriver="./Drivers"
    )
  conn <- DatabaseConnector::connect(connectionDetails)
  if (!is.null(conn)) {
    print("Connection successful with DatabaseConnector")
    DatabaseConnector::disconnect(conn)
  } else {
    print("Failed to connect with DatabaseConnector")
  }
}

# Test connections
test_dbi_connection()
test_database_connector_connection()
