### Harbor

**Prerequisites**

- A VM or a server. (I used a Hyper-V VM running Ubuntu Server 22.04 LTS).

<br>

**Installation**

- [Harbor official installation guide](https://goharbor.io/docs/1.10/install-config/)
- See [harbor.sh](https://github.com/jameswsullivan/selfhosted/blob/main/harbor.sh) for my installation script.

<br>

**Post-installation customization**

If you are only running Harbor in your isolated dev/lab environment like I do, you need to configure Docker to use insecure registries, and this has to be done on any/all clients that will connect/login to your Harbor instance. And when building/tagging your image, you will also need to explicitly specify port 80 to avoid issues.

```
echo "Use Harbor with HTTP..."
systemctl stop docker

json_content="{
\"insecure-registries\" : [\"$HARBOR_APP_URL:$HARBOR_APP_PORT\", \"0.0.0.0\"]
}"

echo "$json_content" | tee /etc/docker/daemon.json > /dev/null

systemctl start docker
```

```
docker image build --tag yourharborregistry.com:80/repo/image:version ........
```