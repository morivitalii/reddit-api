FROM ruby:2.6.3
WORKDIR /app
COPY . /app
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list \
    && apt-get update -qq \
    && apt-get install -y build-essential \
       libpq-dev \
       postgresql-client \
       nodejs \
       yarn \
       ffmpeg \
       # For libvips
       git \
       libxml2-dev \
       libfftw3-dev \
       libmagickwand-dev \
       libopenexr-dev \
       liborc-0.4-0 \
       gobject-introspection \
       libgsf-1-dev \
       libglib2.0-dev \
       liborc-0.4-dev \
       automake \
       libtool \
       swig \
       gtk-doc-tools \
    && git clone https://github.com/jcupitt/libvips.git \
    && cd libvips \
    && ./autogen.sh \
    && make \
    && make install \
    && cd ..

RUN bundle install