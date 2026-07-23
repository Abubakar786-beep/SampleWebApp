#!/bin/bash

echo "=============================="
echo "Starting Deployment"
echo "=============================="


TOMCAT_HOME=/home/ubuntu/tomcat
WAR_FILE=dest/SampleWebApp.war


echo "Checking Tomcat status..."


if pgrep -f "org.apache.catalina.startup.Bootstrap" > /dev/null
then

    echo "Tomcat is running. Stopping..."

    $TOMCAT_HOME/bin/shutdown.sh

    sleep 5

else

    echo "Tomcat is not running. Skipping stop."

fi



echo "Removing old application..."

rm -rf $TOMCAT_HOME/webapps/SampleWebApp


echo "Removing old WAR..."

rm -f $TOMCAT_HOME/webapps/SampleWebApp.war



echo "Deploying new WAR..."

cp $WAR_FILE $TOMCAT_HOME/webapps/



echo "Starting Tomcat..."

$TOMCAT_HOME/bin/startup.sh



sleep 10


echo "Checking deployment..."


if pgrep -f "org.apache.catalina.startup.Bootstrap" > /dev/null
then

    echo "Tomcat is running"

    echo "Deployment Successful"

else

    echo "Deployment Failed"

    exit 1

fi
