#!/bin/bash

set -e

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

    echo "Waiting for Tomcat to stop..."

    while pgrep -f "org.apache.catalina.startup.Bootstrap" > /dev/null
    do
    sleep 1
    done

    echo "Tomcat stopped."

else

    echo "Tomcat is not running"

fi



echo "Removing old application..."

rm -rf $TOMCAT_HOME/webapps/SampleWebApp


echo "Removing old WAR..."

rm -f $TOMCAT_HOME/webapps/SampleWebApp.war



echo "Deploying new WAR..."

cp $WAR_FILE $TOMCAT_HOME/webapps/



echo "Starting Tomcat..."


export CATALINA_HOME=$TOMCAT_HOME
export CATALINA_BASE=$TOMCAT_HOME


nohup $TOMCAT_HOME/bin/startup.sh > /dev/null 2>&1 &



sleep 15



echo "Checking deployment..."


if pgrep -f "org.apache.catalina.startup.Bootstrap" > /dev/null
then

    echo "Tomcat is running"
    echo "Deployment Successful"

else

    echo "Deployment Failed"
    exit 1

fi
