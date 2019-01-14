FROM debian:stretch

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget unzip curl

ENV LANG=C

# Use modified install script
COPY scripts/build.sh /tmp/build.sh

ENV INSTALL_DIR /tmp
RUN cd $INSTALL_DIR \
   && wget -q https://github.com/EO-College/sarbian/archive/master.zip \
   && unzip master.zip && cd sarbian-master \
   && cp /tmp/build.sh scripts/build.sh \
   && find scripts/ -type f -exec sed -i 's/sudo //g' {} \; \
   && scripts/build.sh
