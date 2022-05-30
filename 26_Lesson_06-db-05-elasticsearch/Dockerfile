FROM centos:7
RUN yum -y install wget perl-Digest-SHA java-17-openjdk && yum clean all
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-8.0.1-linux-x86_64.tar.gz && \
    rm -f elasticsearch-8.0.1-linux-x86_64.tar.gz
ADD elasticsearch.yml /elasticsearch-8.0.1/config/
ADD memory.options /elasticsearch-8.0.1/config/jvm.options.d/memory.options
ENV ES_HOME=/elasticsearch-8.0.1
RUN groupadd elasticsearch && useradd -g elasticsearch elasticsearch
RUN mkdir /var/lib/logs && chown elasticsearch:elasticsearch /var/lib/logs && mkdir /var/lib/data \
    && chown elasticsearch:elasticsearch /var/lib/data && chown -R elasticsearch:elasticsearch /elasticsearch-8.0.1/
RUN mkdir /elasticsearch-8.0.1/snapshots && chown elasticsearch:elasticsearch /elasticsearch-8.0.1/snapshots
USER elasticsearch
EXPOSE 9200
CMD ["/elasticsearch-8.0.1/bin/elasticsearch"]
