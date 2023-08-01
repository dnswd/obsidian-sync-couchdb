
#!/bin/bash

# CouchDB URL
COUCHDB_URL="http://$ADMIN_USER:$ADMIN_PASSWORD@localhost:$PORT"

# List of databases to create
DATABASES=("_users" "_replicator" "_global_changes") 

# Wait for CouchDB to be ready
until $(curl --output /dev/null --silent --head --fail "$COUCHDB_URL"); do
  echo "Waiting for CouchDB..."
  sleep 5
done

# Create the databases
for db in "${DATABASES[@]}"; do
  echo "Creating database: $db"
  curl -X PUT "$COUCHDB_URL/$db"
done

# Additional setup can be done here, such as creating views, etc.

echo "Databases created successfully."
