FROM alpine:3.14
RUN  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-linux-x86_64.tar.gz
      tar -xzf elasticsearch-8.0.1-linux-x86_64.tar.gz
      cd elasticsearch-8.0.1/

RUN  mkdir /ansible && \
     mkdir -p /etc/ansible && \
     echo 'localhost' > /etc/ansible/hosts
WORKDIR /ansible
CMD  [ "ansible-playbook", "--version" ]
