FROM ruby:2.7.2

RUN apt-get update -yq \
  && apt-get upgrade -yq \
  #ESSENTIALS
  && apt-get install -y -qq --no-install-recommends build-essential curl git-core vim passwd unzip cron gcc wget netcat \
  # RAILS PACKAGES NEEDED
  && apt-get update 

RUN apt-get clean -qy \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app


# install specific version of bundler
RUN gem install bundler -v 2.1.4

ENV BUNDLE_GEMFILE=/app/Gemfile \
  BUNDLE_JOBS=20 \
  BUNDLE_PATH=/bundle \
  BUNDLE_BIN=/bundle/bin \
  GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

COPY Gemfile  ./
RUN rm -rf Gemfile.lock
COPY . .
RUN bundle install


CMD ["bash"]
