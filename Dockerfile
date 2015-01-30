FROM progrium/cedarish:cedar14
MAINTAINER Jeff Lindsay <progrium@gmail.com>

ADD ./stack/configs/etc-profile /etc/profile

ADD ./builder/ /build
RUN xargs -L 1 /build/install-buildpack /tmp/buildpacks < /build/config/buildpacks.txt

RUN gem install foreman

RUN \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y python-software-properties && \
	apt-get install -y perl && \
	apt-get install -y flex && \
	apt-get install -y make && \
	apt-get install -y g++ && \
	apt-get install -y tcsh

RUN apt-get install openjdk-7-jre

# ADD
COPY TextPro1.5.2_Linux64bit.tar.gz /data/
COPY example_ita.txt /data/

# Define working directory.
WORKDIR /data

ENV TEXT_PRO TextPro1.5.2_Linux64bit

RUN tar -xvf ${TEXT_PRO}.tar.gz

ENV TEXTPRO /data/TextPro1.5.2_Linux64bit

# Define working directory.
WORKDIR /data/TextPro1.5.2_Linux64bit

RUN chmod +x INSTALL.sh
RUN ./INSTALL.sh

ENV PORT 5000
EXPOSE 5000
