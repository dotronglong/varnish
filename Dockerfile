FROM centos:7
LABEL mainmaintainer="me@dotronglong.com"
RUN curl -s https://packagecloud.io/install/repositories/varnishcache/varnish60lts/script.rpm.sh | bash
RUN yum install -y epel-release
RUN yum install -y jemalloc varnish-6.0.2-1.el7.x86_64

COPY default.vcl /etc/varnish/default.vcl
EXPOSE 6060

ENV STORAGE_TYPE malloc
ENV STORAGE_SIZE 256m

CMD /usr/sbin/varnishd -F -f /etc/varnish/default.vcl -a :6060 -s $STORAGE_TYPE,$STORAGE_SIZE