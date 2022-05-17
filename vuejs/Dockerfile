FROM ubuntu:16.04

# apt install system dependencies
RUN apt-get update && \
    apt-get install -y curl git imagemagick libcurl4-openssl-dev libmagickwand-dev python-software-properties software-properties-common tzdata vim

# apt install SQL dependencies
RUN apt-get update && \
    apt-get install -y libmysqlclient-dev libpq-dev mysql-client

# apt install PDF dependencies
RUN apt-get update && \
    apt-get install -y libjpeg-turbo8 libjpeg8-dev libpng12-dev libxrender-dev libfontconfig1-dev

# apt install node 10
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs

# apt install yarn
ENV yarn_version=1.17.3
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn

WORKDIR /www/vuejs
