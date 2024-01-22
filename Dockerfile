FROM ubuntu:16.04

# Update package lists
RUN apt-get update -y

# Install necessary packages
RUN apt-get install -y build-essential curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev
RUN apt-get install -y build-essential libpq-dev vim imagemagick
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y  libssl-dev libreadline-dev zlib1g-dev nodejs git-core
RUN npm install -g yarn


RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash\
  && export PATH=$PATH:/root/.rbenv/bin:/root/.rbenv/shims\
  && echo 'eval "$(/root/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ENV  BUNDLE_PATH $APP_HOME/.gems
ENV  BUNDLE_PATH /box
ENV  PATH /shared/bin:$PATH
ADD . $APP_HOME

RUN mkdir -p tmp/puma
RUN export CONFIGURE_OPTS="--build=aarch64-unknown-linux-gnu" \
  && /root/.rbenv/bin/rbenv install

# Vim commnands in shell
RUN echo "set -o vi" >> ~/.bashrc \
   && echo "stty -ixon" >> ~/.bashrc \
   && echo "set editing-mode vi" >> ~/.inputrc \
   && echo "set keymap vi-command" >> ~/.inputrc


