### bitwarden

**Prerequisites**

- A VM or a server. (I used a Hyper-V VM running Ubuntu Server 22.04 LTS).

<br>

**Installation**

- [bitwarden official installation guide](https://bitwarden.com/help/install-on-premise-linux/)
- See [bitwarden.sh](https://github.com/jameswsullivan/selfhosted/blob/main/bitwarden.sh) for my installation script.

<br>

**Post-installation customization**

I am running bitwarden in my isolated home lab environment without an SMTP server, so in order to unlock Premium features (which requires a verified email address), a little "hacking" into the database is required.

```
# On the bitwarden host machine: (assuming that you're using the bitwarden user and in the /opt/bitwarden directory)


# Retrieve the database password:

cat bwdata/env/mssql.override.env


# You'll get:

SA_PASSWORD=YOUR_DB_PASS


# Connect to the bitwarden-mssql container:

docker exec -it bitwarden-mssql bash


# While in the bitwarden-mssql container, do the following:


# Connect to the DB instance:
cd /opt/mssql-tools/bin
./sqlcmd -S 127.0.0.1 -U sa -P YOUR_DB_PASS


# List all databases:
SELECT name, database_id, create_date  
FROM sys.databases;  
GO 


# Find the database name (your database name was specified during this installation step: Enter the database name for your Bitwarden instance (ex. vault): YOUR_DB_NAME):

USE YOUR_DB_NAME
GO
SELECT Name, Email, EmailVerified FROM [User]
GO


UPDATE [User] SET EmailVerified = 1 WHERE [User].Name="admin";
GO

# The EmailVerified field (0 = not verified, 1 = verified) is what you need to change.
```

<br>

**Conclusion**

I chose bitwarden over Passbolt because bitwarden stores a cached copy of your vault and allows offline use (read-only) while I'm away from my home lab or don't have internet connection. This is sufficient for me.

Of course, if you're using a self-signed certificate, you will have to manually install the cert. See the *Install the certificates:* section [in this article](https://jameswsullivan.github.io/self-host-passbolt/).