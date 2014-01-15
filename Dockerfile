FROM		ubuntu:latest
MAINTAINER	Ben Tomasik < btomasik [at] telkonet {dot} com>

RUN		echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN		apt-get update
RUN		apt-get upgrade -y

# Install apt-utils so everything else doesn't gripe.
RUN		apt-get install -y apt-utils

# Fool Ubuntu's craptastic upstart
RUN		dpkg-divert --local --rename --add /sbin/initctl
RUN		ln -s /bin/true /sbin/initctl

# Put some basic files in place
ADD		./files/	/
RUN		chown root:root /etc/amavis/conf.d/05-node_id

# Install basic packages
RUN		apt-get install -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew amavisd-new

# Install more basic packages
RUN		apt-get install -y spamassassin clamav-daemon

# Install the optional packages for better spam detection (who does not want better spam detection?):
RUN		apt-get install -y libnet-dns-perl libmail-spf-perl pyzor razor

# Install these optional packages to enable better scanning of attached archive files:
RUN		apt-get install -y arj bzip2 cabextract cpio file gzip nomarch pax unp unrar-free unzip zip zoo

