FROM ubuntu:wily

ENV DEBIAN_FRONTEND noninteractive

# Usual update / upgrade
#RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
RUN apt-get update && apt-get upgrade -y

# Install requirements
RUN apt-get install -y curl supervisor build-essential libicu-dev git

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install --fix-missing -y nodejs

# Get discord-irc
RUN npm install https://github.com/zeknurn/discord-irc

# Add configurations
ADD config.json config/config.json

# Add supervisor configs
ADD supervisord.conf supervisord.conf

CMD ["-n", "-c", "/supervisord.conf"]
ENTRYPOINT ["/usr/bin/supervisord"]
