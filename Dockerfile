FROM debian:11-slim

MAINTAINER IceSoulHanxi icesoulhanxi@outlook.com

# Volumes
VOLUME /config
VOLUME /guide2go
VOLUME /root/.xteve
VOLUME /tmp/xteve

RUN apt update && apt install libnuma1 -y

# Add ffmpeg and vlc
COPY ffmpeg /usr/bin/ffmpeg
RUN apt install vlc -y

# Add xTeve and guide2go
COPY xteve /usr/bin/xteve
ADD guide2go /usr/bin/guide2go
ADD cronjob.sh /
ADD entrypoint.sh /
ADD sample_cron.txt /
ADD sample_xteve.txt /

# Set executable permissions
RUN chmod +x /entrypoint.sh
RUN chmod +x /cronjob.sh
RUN chmod +x /usr/bin/xteve
RUN chmod +x /usr/bin/guide2go
RUN chmod +x /usr/bin/ffmpeg

# Expose Port
EXPOSE 34400

# Entrypoint
ENTRYPOINT ["./entrypoint.sh"]
