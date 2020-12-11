FROM centos:centos7.4.1708
WORKDIR /work
ENV DOCKER_HOST="tcp://host.docker.internal:2375"

VOLUME [ "/work" ]

RUN yum check-update ; \
    yum install -y gcc libffi-devel python3 epel-release ; \
    yum install -y openssh-clients ; \
    pip3 install --upgrade pip ; \
    pip3 install docker-py ; \
    pip3 install ansible ; \
    yum clean all

CMD ["/bin/bash"]
