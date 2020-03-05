FROM ruby:2.4.1-stretch

ENV DEBIAN_FRONTEND=noninteractive
ENV ONESIGNAL_CAPNPROTO_RELEASE_URL="https://github.com/OneSignal/capnproto-debian/releases/download/onesignal-0.6.1-1" \
    ONESIGNAL_CAPNPROTO_DEB="capnproto_0.6.1-1_amd64.deb" \
    ONESIGNAL_LIBCAPNP_DEB="libcapnp-0.6.1_0.6.1-1_amd64.deb" \
    ONESIGNAL_LIBCAPNP_DEV_DEB="libcapnp-dev_0.6.1-1_amd64.deb"
ENV LIBSSL_RELEASE_URL="http://archive.debian.org/debian/pool/main/o/openssl" \
    LIBSSL_DEB="libssl1.0.0_1.0.2l-1~bpo8+1_amd64.deb" \
    LIBSSL_DEV_DEB="libssl-dev_1.0.2l-1~bpo8+1_amd64.deb"

RUN set -ex \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' >> /etc/apt/sources.list.d/pgdg.list \
    && echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        git curl lftp zsh vim zip postgresql-10 postgresql-client-10 netcat \
    && cd /tmp \
    && curl -sSLO "${LIBSSL_RELEASE_URL}/${LIBSSL_DEB}" \
    && curl -sSLO "${LIBSSL_RELEASE_URL}/${LIBSSL_DEV_DEB}" \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_CAPNPROTO_DEB}" \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_LIBCAPNP_DEB}" \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_LIBCAPNP_DEV_DEB}" \
    && dpkg -i "${ONESIGNAL_CAPNPROTO_DEB}" "${ONESIGNAL_LIBCAPNP_DEB}" "${ONESIGNAL_LIBCAPNP_DEV_DEB}" "${LIBSSL_DEB}" "${LIBSSL_DEV_DEB}" \
    && gem install bundler -v 1.16.6 \
    && wget -qO- https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install yarn \
    && rm -rf /var/lib/apt/lists/*
