
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

# Setup obsidian livesync
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/chttpd/require_valid_user" -H "Content-Type: application/json" -d '"true"' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/chttpd_auth/require_valid_user" -H "Content-Type: application/json" -d '"true"' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/httpd/WWW-Authenticate" -H "Content-Type: application/json" -d '"Basic realm=\"couchdb\""' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/httpd/enable_cors" -H "Content-Type: application/json" -d '"true"' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/chttpd/enable_cors" -H "Content-Type: application/json" -d '"true"' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/chttpd/max_http_request_size" -H "Content-Type: application/json" -d '"4294967296"' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/couchdb/max_document_size" -H "Content-Type: application/json" -d '"50000000"' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/cors/credentials" -H "Content-Type: application/json" -d '"true"' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/cors/origins" -H "Content-Type: application/json" -d '"app://obsidian.md,capacitor://localhost,http://localhost"' --user "${ADMIN_USER}:${ADMIN_PASSWORD}"

echo "Databases created successfully."
