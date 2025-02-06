#### Start MinIO
```
docker compose up -d
```

#### `mc` Commands
```
# list aliases
mc alias list

# set configs and credentials
mc alias set local http://127.0.0.1:9000 admin password

# create buckets
mc mb local/mybucket1
mc mb local/mybucket2

# list buckets
mc ls local

# delete buckets
mc rb local/mybucket1
mc rb --force local/mybucket2

```
