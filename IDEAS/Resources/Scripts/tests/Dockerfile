# This Dockerfile creates a Docker image with Dymola installed for testing.
# The Docker context should be set to use the DOCKERPATH of the host where the installation and license
# files should be located.
# This Dockerfile assumes the host having the following envrionment variables:
# DYMOLAPATH - points to a directory that contains the Dymola zip installation file and the dymola.lic license file.
# It also assumes passing the following arguments upon build:
# DYMOLAFILE - name of the Dymola zip installation file within the DYMOLAPATH directory.
# DYMOLAVERSION - specifies the Dymola version.
# For example:
# DYMOLAPATH=/home/developer/dymola
# DYMOLAFILE=Dymola_2022x.AM_CAT_Dymola.Linux64.1-1.zip
# DYMOLAVERSION=dymola-2022x-x86_64

# Start with a base Ubuntu image
FROM ubuntu:20.04
# This is the Focal Fossa ubuntu version
MAINTAINER Javier Arroyo <javier.arroyo@kuleuven.be>

# Avoid warnings while installing ubuntu
# debconf: unable to initialize frontend: Dialog
# debconf: (TERM is not set, so the dialog frontend is not usable.)
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install packages
RUN apt update && \
    apt install -y \
    cpio \
    git \
    libasound2 \
    libice6 \
    libglu1 \
    libglib2.0-0 \
    libpci3 \
    libqt5webenginecore5 \
    libqt5webenginewidgets5 \
    libqt5x11extras5 \
    libxcomposite-dev \
    libxdamage-dev \
    libxcursor-dev \
    libxi6 \
    libxss1 \
    libxtst6 \
    libxrandr2 \
    libxkbcommon0 \
    python3.8 \
    python3-pip \
    python3-pandas \
    rpm2cpio \
    unzip  \
    xvfb && \
    rm -rf /var/lib/apt/lists/*

# Set DYMOLAFILE and DYMOLAVERSION to be build arguments
ARG DYMOLAFILE
ARG DYMOLAVERSION
# Install Dymola
# Copy content from $DYMOLAPATH to the tmp folder
COPY ${DYMOLAPATH} /tmp
# Unzip the file
RUN cd /tmp && unzip ${DYMOLAFILE}
# Change to the directory that contains the .rpm files and unpack them
RUN cd /tmp/AM_CAT_Dymola.Linux64/1/linux_x86_64 && \
    for ff in `ls *.rpm`; do (rpm2cpio $ff | cpio -i --make-directories); done && \
    chmod -R o-w opt/${DYMOLAVERSION} && \
    mv opt/${DYMOLAVERSION} /opt/${DYMOLAVERSION}
# Dymola is now installed in /opt/$DYMOLAVERSION
# We will now make it executable with a simple dymola command
RUN ln -s /opt/${DYMOLAVERSION}/bin64/dymola.sh /usr/local/bin/dymola

# Install Buildingspy
ENV BUILDINGSPY_VERSION BuildingsPy@50ac74d8e4fd067179bb38bc23140c2c9254c94c
RUN pip3 install git+https://github.com/lbl-srg/${BUILDINGSPY_VERSION}
# python is not installed in our image but python3
RUN sed -i 's/"python"/"python3"/' /usr/local/lib/python3.8/dist-packages/buildingspy/development/regressiontest.py

# Make directory for X display
RUN mkdir -m 1777 /tmp/.X11-unix

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    mkdir -p /etc/sudoers.d && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

# Activate developer
USER developer

# Set environment variables
ENV HOME /home/developer
ENV DYMOLAPATH /tmp

# COPY ${DYMOLAPATH}/dymola.lic ${HOME}/
ENV DISPLAY :99
ENV QT_QPA_PLATFORM xcb

# The following starts the X virtual framebuffer (Xvfb) server that enables running graphical applications
# like Dymola without a physical display in a headless environment like a Docker container
ENTRYPOINT ["sh", "-c", "Xvfb :99 -screen 0 1024x768x8 -nolisten tcp & /bin/bash"]