FROM mcr.microsoft.com/devcontainers/java:11-bullseye

RUN export NVM_DIR=/usr/local/share/nvm && \
  . $NVM_DIR/nvm.sh && \
  nvm install 16 && \
  npm install -g @adobe/aio-cli && \
  mkdir /opt/maven && \
  chmod a+wrx /opt/maven

USER vscode

RUN cd /opt/maven && \
  curl https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip -o apache-maven.zip && \
  unzip apache-maven.zip && \
  rm apache-maven.zip && \
  echo y | aio help && \
  aio plugins:install @adobe/aio-cli-plugin-aem-rde && \
  aio plugins:install @adobe/aio-cli-plugin-cloudmanager && \
  aio plugins:update

# JAVA_HOME is incorrectly set, unset it
ENV JAVA_HOME=
ENV PATH=/opt/maven/apache-maven-3.8.6/bin:$PATH


