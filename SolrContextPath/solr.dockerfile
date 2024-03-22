FROM solr:9.5.0

USER root

RUN apt-get update -y && \
    apt-get install nano -y && \
    rm -f /opt/solr/server/solr/solr.xml && \
    rm -f /opt/solr/server/contexts/solr-jetty-context.xml && \
    rm -f /opt/solr/server/etc/jetty.xml