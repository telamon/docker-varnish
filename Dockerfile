FROM centos:centos7
MAINTAINER Tony Ivanov telamohn@gmail.com, Przemyslaw Ozgo linux@ozgo.info, Marcin Ryzycki marcin@m12.io

RUN yum update -y && \
  yum install -y epel-release && \
  yum install -y gcc && \
  yum install -y libmhash-devel && \
  yum install -y logrotate initscripts libedit && \
  rpm -i https://repo.varnish-cache.org/redhat/varnish-3.0/el7/x86_64/varnish/varnish-libs-3.0.6-1.el7.centos.x86_64.rpm && \
  rpm -i https://repo.varnish-cache.org/redhat/varnish-3.0/el7/x86_64/varnish/varnish-libs-devel-3.0.6-1.el7.centos.x86_64.rpm && \
  rpm -i https://repo.varnish-cache.org/redhat/varnish-3.0/el7/x86_64/varnish/varnish-3.0.6-1.el7.centos.x86_64.rpm && \
  yum clean all

ADD start.sh /start.sh

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600

CMD /start.sh
EXPOSE 80 6082
