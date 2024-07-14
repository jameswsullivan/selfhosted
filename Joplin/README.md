#### Start/Stop Joplin

```
docker compose up -d
docker compose down -v
```

#### Customization
Modify the volume and volume mount as needed for postgres persistent data.

```
volumes:
  pgdata:
    driver: local

volumes:
    - pgdata:/var/lib/postgresql/data
```

#### Default Login
- username: `admin@localhost`
- password: `admin`