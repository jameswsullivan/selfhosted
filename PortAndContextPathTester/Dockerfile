FROM ubuntu

ENV CUSTOM_LISTENING_PORT=
ENV PATH_TO_TEST=

RUN apt-get update -y &&\
    apt-get install nano apache2 apache2-utils -y

RUN rm /etc/apache2/ports.conf && \
    rm /etc/apache2/sites-available/000-default.conf    

COPY ports.conf /etc/apache2/ports.conf
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY index.html /opt/index.html
COPY entrypoint.sh /opt/entrypoint.sh

RUN chmod ugo+rx /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]