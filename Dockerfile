FROM ruby:2.4-stretch

ENV ONESIGNAL_CAPNPROTO_RELEASE_URL="https://github.com/OneSignal/capnproto-debian/releases/download/onesignal-0.6.1-1" \
    ONESIGNAL_CAPNPROTO_DEB="capnproto_0.6.1-1_amd64.deb" \
    ONESIGNAL_LIBCAPNP_DEB="libcapnp-0.6.1_0.6.1-1_amd64.deb" \
    ONESIGNAL_LIBCAPNP_DEV_DEB="libcapnp-dev_0.6.1-1_amd64.deb"

RUN set -ex \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' >> /etc/apt/sources.list.d/pgdg.list \
    && echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y libssl1.0.2=1.0.2r-1~deb9u1 libssl1.0-dev=1.0.2r-1~deb9u1 \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    git curl lftp zsh vim zip postgresql-10 postgresql-client-10 netcat \
    && cd /tmp \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_CAPNPROTO_DEB}" \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_LIBCAPNP_DEB}" \
    && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_LIBCAPNP_DEV_DEB}" \
    && dpkg -i "${ONESIGNAL_CAPNPROTO_DEB}" "${ONESIGNAL_LIBCAPNP_DEB}" "${ONESIGNAL_LIBCAPNP_DEV_DEB}"
