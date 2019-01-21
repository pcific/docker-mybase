FROM ubuntu:16.04

MAINTAINER pcific@gtplus.co.kr

ENV DEBIAN_FRONTEND noninteractive

# install common dependencies
RUN apt-get update && apt-get install -y \
    lsb-release openssh-server sudo \
    curl wget \
    figlet vim git net-tools netcat iputils-ping

# build-essential openjdk

# ensure we have the en_US.UTF-8 locale available
# RUN locale-gen en_US.UTF-8
RUN echo root:. | chpasswd

# daum apt repository
RUN cp /etc/apt/sources.list /etc/apt/sources.list.BEFORE && sed -i s/kr.archive.ubuntu.com/ftp.daumkakao.com/ /etc/apt/sources.list && sed -i s/archive.ubuntu.com/ftp.daumkakao.com/ /etc/apt/sources.list && apt-get update

# setup the vagrant user
RUN if ! getent passwd vagrant; then useradd -d /home/vagrant -m -s /bin/bash vagrant; fi \
    && echo vagrant:vagrant | chpasswd \
    && echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /etc/sudoers.d \
    && echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vagrant \
    && chmod 0440 /etc/sudoers.d/vagrant

# add the vagrant insecure public key
RUN mkdir -p /home/vagrant/.ssh \
    && chmod 0700 /home/vagrant/.ssh \
    && wget --no-check-certificate \
      https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub \
      -O /home/vagrant/.ssh/authorized_keys \
    && chmod 0600 /home/vagrant/.ssh/authorized_keys \
    && chown -R vagrant /home/vagrant/.ssh

# don't clean packages, we might be using vagrant-cachier
RUN rm /etc/apt/apt.conf.d/docker-clean

# create the privilege separation directory for sshd
RUN mkdir -p /run/sshd

# run sshd in the foreground
CMD /usr/sbin/sshd -D \
    -o UseDNS=no\
    -o UsePAM=no\
    -o PasswordAuthentication=yes\
    -o PermitRootLogin=yes\
    -o PidFile=/tmp/sshd.pid


