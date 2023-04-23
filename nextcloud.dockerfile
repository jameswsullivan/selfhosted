FROM nextcloud

# Configure PHP parameters via environment variables.
ENV PHP_MEMORY_LIMIT=4096M
ENV PHP_UPLOAD_LIMIT=4096M

# Install packages and configure timezone.
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install nano -y && \
    apt-get install tzdata -y && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

EXPOSE 80 443