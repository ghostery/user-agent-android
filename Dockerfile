# Docker image with fastlane and android SDK
# Based on https://github.com/cliqz-oss/browser-android/blob/master/Dockerfile
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive

#Install the required packages. 1st Set is for Browser Project and the 2nd for Ruby and NodeJS.
RUN apt-get update && \
    apt-get install -y \
        curl \
        git \
        gnupg2 \
        language-pack-en \
        openjdk-17-jdk \
        python3-dev \
        python3-pip \
        ruby-dev \
        unzip \
        wget \
        xz-utils \
        autoconf \
        automake \
        bison \
        build-essential \
        ca-certificates \
        gawk \
        libffi-dev \
        libgdbm-dev \
        libgmp-dev \
        libgmp-dev \
        libncurses5-dev \
        libreadline6-dev \
        libsqlite3-dev \
        libssl-dev \
        libtool \
        libyaml-dev \
        pkg-config \
        sqlite3 \
        zlib1g-dev && \
    apt-get clean -y

RUN gem install fastlane --version 2.210.1

# Set the locale
RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ENV ANDROID_HOME /home/jenkins/android_home
ENV GRADLE_USER_HOME /home/jenkins/gradle_home
ENV NVM_DIR /home/jenkins/nvm
ENV JAVA17PATH="/usr/lib/jvm/java-17-openjdk-amd64/bin:$PATH"

#Install Android SDK and the Required SDKs
RUN mkdir -p $ANDROID_HOME; \
    mkdir -p $GRADLE_USER_HOME;

RUN cd $ANDROID_HOME; \
    wget -O sdktools.zip --quiet 'https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip'; \
    unzip sdktools.zip; \
    rm -r sdktools.zip;
ENV ANDROID_SDK_HOME=$ANDROID_HOME
ENV PATH="$JAVA17PATH:$PATH"

RUN yes | "${ANDROID_SDK_HOME}/cmdline-tools/bin/sdkmanager" --sdk_root="${ANDROID_SDK_HOME}" --licenses

# Add jenkins to the user group
ARG UID
ARG GID
RUN getent group $GID || groupadd jenkins --gid $GID && \
    useradd --create-home --shell /bin/bash jenkins --uid $UID --gid $GID

RUN chmod a+rw -R /home/jenkins

USER jenkins