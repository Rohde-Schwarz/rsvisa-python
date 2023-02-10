ARG PYTHON_INTERPRETER="python"
ARG PYTHON_VERSION="3.8-slim"
FROM ${PYTHON_INTERPRETER}:${PYTHON_VERSION}

ARG RS_VISA_VERSION="5.12.3"

USER root

COPY sudoers-env-keep   /etc/sudoers.d/
COPY sudoers-user       /etc/sudoers.d/sudoers-user

RUN chmod 0600 /etc/sudoers.d/* \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      curl \
      sudo \
      wget \
 && curl -o rsvisa_${RS_VISA_VERSION}_$(dpkg --print-architecture).deb   https://scdn.rohde-schwarz.com/ur/pws/dl_downloads/dl_application/application_notes/1dc02___rs_v/rsvisa_${RS_VISA_VERSION}_$(dpkg --print-architecture).deb \
 && dpkg -i rsvisa_${RS_VISA_VERSION}_$(dpkg --print-architecture).deb || apt-get -f install -y --no-install-recommends \
 && ln -s /usr/lib/librsvisa.so /usr/lib/libvisa.so \
 && adduser \
    --disabled-password \
    --home /home/user \
    --uid 1000 \
    --shell /bin/bash \
    --gecos "user" \
    user \
 && usermod -a -G sudo user \
 && rm -rf \
      /var/lib/apt/lists \
      rsvisa_${RS_VISA_VERSION}_$(dpkg --print-architecture).deb \
 && echo -e "[Paths]\n\nVISA library: /usr/lib/libvisa.so" > ~/.pyvisarc \
 && pip install pip -U \
 && pip install pyvisa

#Change to user for rootless container
#USER user
