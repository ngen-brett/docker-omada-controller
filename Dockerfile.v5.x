ARG BASE=ubuntu:22.04
FROM ${BASE}
LABEL maintainer="ngen-brett <25758102+ngen-brett@users.noreply.github.com>"
LABEL org.opencontainers.image.source=https://github.com/ngen-brett/docker-omada-controller
ENV DEBIAN_FRONTEND=non-interactive

COPY healthcheck.sh install.sh log4j_patch.sh install_mongodb.sh /

# valid values: amd64 (default) | arm64 | armv7l
ARG ARCH=amd64

# install version (major.minor only); OMADA_URL set in install.sh
ARG INSTALL_VER="5.13"
ARG NO_MONGODB=false

# install mongodb and dependencies
RUN bash /install_mongodb.sh

# install omada controller (instructions taken from install.sh) & patch log4j, if applicable
RUN /install.sh &&\
  /log4j_patch.sh &&\
  rm /install.sh /log4j_patch.sh

RUN apt-get -y clean

COPY entrypoint-5.x.sh /entrypoint.sh

WORKDIR /opt/tplink/EAPController/lib
EXPOSE 8088 8043 8843 29810/udp 29811 29812 29813 29814
HEALTHCHECK --start-period=5m CMD /healthcheck.sh
VOLUME ["/opt/tplink/EAPController/data","/opt/tplink/EAPController/logs"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/java","-server","-Xms128m","-Xmx1024m","-XX:MaxHeapFreeRatio=60","-XX:MinHeapFreeRatio=30","-XX:+HeapDumpOnOutOfMemoryError","-XX:HeapDumpPath=/opt/tplink/EAPController/logs/java_heapdump.hprof","-Djava.awt.headless=true","--add-opens","java.base/java.util=ALL-UNNAMED","-cp","/opt/tplink/EAPController/lib/*::/opt/tplink/EAPController/properties:","com.tplink.smb.omada.starter.OmadaLinuxMain"]

