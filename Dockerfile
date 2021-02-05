FROM adoptopenjdk/openjdk11:jdk-11.0.9.1_1-alpine-slim

RUN apk add curl jq

#Workspace
WORKDIR /usr/share/udemy

# Add .jar under target from host
# into this image

ADD target/selenium-docker.jar			selenium-docker.jar
ADD target/selenium-docker-tests.jar	selenium-docker-tests.jar
ADD target/libs							libs

# Incase of any other dependency like .csv | .json | .xls
# please ASS that as well

# ADD suite files
ADD book-flight-module.xml				book-flight-module.xml
ADD search-module.xml					search-module.xml

# Add a health check script:
ADD healthcheck.sh						healthcheck.sh

#BROWSER
#HUB_HOST
#MODULE
#ENTRYPOINT java -cp selenium-docker.jar:selenium-docker-tests.jar:libs/* -DBROWSER=$BROWSER -DHUB_HOST=$HUB_HOST org.testng.TestNG $MODULE

ENTRYPOINT sh healthcheck.sh