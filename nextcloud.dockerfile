FROM nextcloud

# Configure PHP parameters via environment variables.
ENV PHP_MEMORY_LIMIT="4096M"
ENV PHP_UPLOAD_LIMIT="4096M"

# Install packages and configure timezone.
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install nano tzdata -y && \
    ln -fs /usr/share/zoneinfo/US/Central /etc/localtime

EXPOSE 80 443
