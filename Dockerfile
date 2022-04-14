# Docker image with fastlane and android SDK
# Based on https://github.com/cliqz-oss/browser-android/blob/master/Dockerfile
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

#Install the required packages. 1st Set is for Browser Project and the 2nd for Ruby and NodeJS.
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        curl \
        git \
        gnupg2 \
        language-pack-en \
        lib32z1 \
        libc6:i386 \
        libncurses5:i386 \
        libstdc++6:i386 \
        openjdk-8-jdk \
        openjdk-11-jdk \
        python3-dev \
        python3-pip \
        ruby-dev \
        unzip \
        wget \
        xz-utils && \
    apt-get install -y \
        apt-transport-https \
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
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install fastlane --version 2.154.0

# Set the locale
RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ENV ANDROID_HOME /home/jenkins/android_home
ENV GRADLE_USER_HOME /home/jenkins/gradle_home
ENV NVM_DIR /home/jenkins/nvm
ENV JAVA8PATH /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/

# Add jenkins to the user group
ARG UID
ARG GID
RUN getent group $GID || groupadd jenkins --gid $GID && \
    useradd --create-home --shell /bin/bash jenkins --uid $UID --gid $GID

USER jenkins

#Install Android SDK and the Required SDKs
RUN mkdir -p $ANDROID_HOME; \
    mkdir -p $GRADLE_USER_HOME;

RUN cd $ANDROID_HOME; \
    wget -O sdktools.zip --quiet 'https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip'; \
    unzip sdktools.zip; \
    rm -r sdktools.zip;

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

RUN cd $ANDROID_HOME; \
    while (true); do echo y; done | PATH=$JAVA8PATH:$PATH tools/bin/sdkmanager --licenses

RUN cd $ANDROID_HOME; \
    PATH=$JAVA8PATH:$PATH tools/bin/sdkmanager \
        "build-tools;28.0.3" \
        "platforms;android-28" \
        "platforms;android-29" \
        "platform-tools" \
        "tools" \
        "extras;google;m2repository" \
        "extras;android;m2repository" \
        "extras;google;google_play_services";

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
