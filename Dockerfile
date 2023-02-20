FROM mcr.microsoft.com/devcontainers/java:11-bullseye

RUN export NVM_DIR=/usr/local/share/nvm && \
  . $NVM_DIR/nvm.sh && \
  nvm install 16 && \
  npm install -g @adobe/aio-cli && \
  mkdir /opt/maven && \
  chmod a+wrx /opt/maven

USER vscode

RUN cd /opt/maven && \
  curl https://archive.apache.org/dist/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.zip -o apache-maven.zip && \
  unzip apache-maven.zip && \
  rm apache-maven.zip && \
  echo y | aio help && \
  aio plugins:install @adobe/aio-cli-plugin-aem-rde && \
  aio plugins:install @adobe/aio-cli-plugin-cloudmanager && \
  aio plugins:update && \
  aio plugins

# JAVA_HOME is incorrectly set, unset it
ENV JAVA_HOME=
ENV PATH=/opt/maven/apache-maven-3.8.7/bin:$PATH

#RUN cd && mkdir temp && cd temp && mvn -B org.apache.maven.plugins:maven-archetype-plugin:3.2.1:generate \
#  -D archetypeGroupId=com.adobe.aem \
#  -D archetypeArtifactId=aem-project-archetype \
#  -D archetypeVersion=40 \
#  -D appTitle="Cache Prime" \
#  -D appId="cacheprime" \
#  -D groupId="com.adobe.cacheprime" && \
#  cd ~/temp/cacheprime && \
#  mvn install -Dmaven.test.skip=true && rm -rf ~/temp && rm -rf ~/.m2/repository/com/adobe/cacheprime
