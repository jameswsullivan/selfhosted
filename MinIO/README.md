#### Start MinIO
```
docker compose up -d
```

#### Visit the MinIO WebUI
```
http://localhost:9001
```

#### MinIO Client `mc` Quick Reference
```
alias       set, remove and list aliases in configuration file
ls          list buckets and objects
mb          make a bucket
rb          remove a bucket
cp          copy objects
mirror      synchronize object(s) to a remote site
cat         display object contents
head        display first 'n' lines of an object
pipe        stream STDIN to an object
share       generate URL for temporary access to an object
find        search for objects
sql         run sql queries on objects
stat        show object metadata
mv          move objects
tree        list buckets and objects in a tree format
du          summarize disk usage recursively
retention   set retention for object(s)
legalhold   set legal hold for object(s)
diff        list differences in object name, size, and date between two buckets
rm          remove objects
encrypt    manage bucket encryption config
event       manage object notifications
watch       listen for object notification events
undo        undo PUT/DELETE operations
policy      manage anonymous access to buckets and objects
tag         manage tags for bucket(s) and object(s)
ilm         manage bucket lifecycle
version     manage bucket versioning
replicate   configure server side bucket replication
admin       manage MinIO servers
update      update mc to latest release

```
**Reference**: [https://hub.docker.com/r/minio/mc](https://hub.docker.com/r/minio/mc)

#### Basic Tests
```
## Using the minio-mc container:
docker exec -it minio-mc bash

# set configs and credentials
mc alias set local http://minio:9000 admin password

# list aliases
mc alias list

# create buckets
mc mb local/mybucket1
mc mb local/mybucket2

# list buckets
mc ls local

# delete buckets
mc rb local/mybucket1
mc rb --force local/mybucket2

# deposit a file into mybucket1
echo "Hello, World!" > hello.txt
mc cp hello.txt local/mybucket1/hello.txt
mc cat local/mybucket1/hello.txt
```
