#!/bin/bash

echo "Starting Deployment..."

TOMCAT_HOME=/home/ubuntu/tomcat
WAR_FILE=dest/SampleWebApp.war


echo "Stopping Tomcat..."

$TOMCAT_HOME/bin/shutdown.sh

sleep 5


echo "Removing old application..."

rm -rf $TOMCAT_HOME/webapps/SampleWebApp


echo "Deploying new WAR..."

cp $WAR_FILE $TOMCAT_HOME/webapps/


echo "Starting Tomcat..."

$TOMCAT_HOME/bin/startup.sh


echo "Deployment Completed Successfully"
