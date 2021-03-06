ARG PYTHON_INTERPRETER="python"
ARG PYTHON_VERSION="3.8-slim"
FROM ${PYTHON_INTERPRETER}:${PYTHON_VERSION}
ARG RS_VISA_VERSION="5.12.3"
ARG BUILDPLATFORM
ARG TARGETPLATFORM

SHELL ["/bin/bash", "-c"]

# Install R&S VISA
RUN echo "Target platform: $TARGETPLATFORM" && \
    apt-get update && \
    apt-get install dpkg libavahi-client3 libavahi-common3 libusb-1.0-0 curl libqt5widgets5 -y --no-install-recommends && \
    curl -o "rsvisa.deb" "https://scdn.rohde-schwarz.com/ur/pws/dl_downloads/dl_application/application_notes/1dc02___rs_v/rsvisa_${RS_VISA_VERSION}_$(if [[ "$TARGETPLATFORM" =~ "arm" ]]; then echo "armhf"; else echo "amd64"; fi).deb" && \
    dpkg -i "rsvisa.deb" && \
    ln -s /usr/lib/librsvisa.so /usr/lib/libvisa.so && \
    rm "rsvisa.deb" && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/* && \
    \
    echo -e "[Paths]\n\nVISA library: /usr/lib/libvisa.so" > ~/.pyvisarc && \
    pip install pip -U && \
    pip install pyvisa