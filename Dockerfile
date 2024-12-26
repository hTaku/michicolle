FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl openjdk-11-jre-headless vim 

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

RUN npm install -g firebase-tools

RUN mkdir /firebase
WORKDIR /firebase

CMD [ "firebase", "emulators:start" ]