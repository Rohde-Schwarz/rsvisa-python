ARG PYTHON_INTERPRETER="python"
ARG PYTHON_VERSION="3.8"
FROM ${PYTHON_INTERPRETER}:${PYTHON_VERSION}-buster
ARG RS_VISA_VERSION="5.12.3"

# Install R&S VISA
ADD https://scdn.rohde-schwarz.com/ur/pws/dl_downloads/dl_application/application_notes/1dc02___rs_v/rsvisa_${RS_VISA_VERSION}_amd64.deb rsvisa.deb
RUN apt-get update && \
    apt-get install dpkg libavahi-client3 libavahi-common3 libqt5core5a libqt5gui5 libqt5widgets5 libusb-1.0-0 -y && \
    dpkg -i rsvisa.deb && \
    ln -s /usr/lib/librsvisa.so /usr/lib/libvisa.so && \
    rm rsvisa.deb && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/* && \
    \
    pip install pip -U && \
    pip install pyvisa