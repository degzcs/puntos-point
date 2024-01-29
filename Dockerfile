FROM ubuntu:16.04

# Update package lists
RUN apt-get update -y

# Install necessary packages
RUN apt-get install -y build-essential curl zlib1g-dev libssl-dev libreadline-dev\
   libyaml-dev libxml2-dev libxslt1-dev libpq-dev vim imagemagick zsh\
   postgresql postgresql-contrib xdg-utils w3m lynx elinks links2\
   && curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh\
   && bash nodesource_setup.sh\
   && apt-get install -y  libssl-dev libreadline-dev zlib1g-dev nodejs git-core\
   && npm install -g yarn


RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash\
  && echo 'eval "$(/root/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ENV  BUNDLE_PATH $APP_HOME/.gems
ENV  BUNDLE_PATH /box
ENV  PATH /shared/bin:root/.rbenv/bin:/root/.rbenv/shims:$PATH
ADD . $APP_HOME

RUN export CONFIGURE_OPTS="--build=aarch64-unknown-linux-gnu" \
  && /root/.rbenv/bin/rbenv install\
  && /root/.rbenv/shims/gem install rails -v 3.0.20 \
  && /root/.rbenv/shims/gem install bundler -v 1.0.20


RUN git config --global user.email "diego@example.com"\
  && git config --global user.name "Diego Gomez"\
  && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"\
  && chsh -s $(which zsh)

ENV GIT_SSH_COMMAND="ssh -i ~/.ssh/diego_example"

# Vim commnands in shell
RUN echo "set -o vi" >> ~/.zshrc \
   && echo "stty -ixon" >> ~/.zshrc \
   && echo "set editing-mode vi" >> ~/.inputrc \
   && echo "set keymap vi-command" >> ~/.inputrc


