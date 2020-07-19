FROM ruby:2.7.1-buster
ENV DEBIAN_FRONTEND=noninteractive
ENV ONESIGNAL_CAPNPROTO_RELEASE_URL="https://github.com/OneSignal/capnproto-debian/releases/download/onesignal-0.6.1-1" \
    ONESIGNAL_CAPNPROTO_DEB="capnproto_0.6.1-1_amd64.deb" \
    ONESIGNAL_LIBCAPNP_DEB="libcapnp-0.6.1_0.6.1-1_amd64.deb" \
    ONESIGNAL_LIBCAPNP_DEV_DEB="libcapnp-dev_0.6.1-1_amd64.deb"
RUN set -ex \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' >> /etc/apt/sources.list.d/pgdg.list \
    && echo "deb http://ftp.debian.org/debian buster-backports main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
    git curl lftp zsh vim zip postgresql-10 postgresql-client-10 netcat libssl1.1 libssl-dev libsodium23 libsodium-dev \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && cd /tmp \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_CAPNPROTO_DEB}" \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_LIBCAPNP_DEB}" \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_LIBCAPNP_DEV_DEB}" \
    && dpkg -i "${ONESIGNAL_CAPNPROTO_DEB}" "${ONESIGNAL_LIBCAPNP_DEB}" "${ONESIGNAL_LIBCAPNP_DEV_DEB}" \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/${HOME:-root}/.cargo/bin:${PATH}"
