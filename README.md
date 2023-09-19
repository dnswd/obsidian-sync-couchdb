# obsidian-sync-couchdb
A docker-compose to help deploy a couchdb in vps or docker-enabled platforms. Was built to host obsidian-sync.

1. Clone this repo
2. Run `DB_USERNAME=your_username DB_PASSWORD=your_password docker-compose up`
3. Navigate to `your_machine_ip:5984` to check if it's working
4. Navigate to Fauxton Dashboard at `your_machine_ip:5984/_utils/#/setup` and configure single-node setup
5. Navigate to `your_machine_ip:5984/_utils/#/verifyinstall` and verify install

### Obsidian Livesync
1. Install `self-hosted livesync` to your obsidian
2. Go to `Remote database configuration` and add your machine ip and port, as well ass your `DB_USERNAME` and `DB_PASSWORD`
3. Create a new db in Fauxton called `obsidian-livesync`
4. Put the db name in plugin setup and click `Test database connection`
