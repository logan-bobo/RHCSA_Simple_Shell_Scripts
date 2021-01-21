#!/bin/bash
# must be run as root or with elevated privileges
# Script to Allow SysAdmins to prefrom some YUM checks

#imputs
ARG1=$1
ARG2=$2
YUM=/usr/bin/yum

#check if updates are avalilbe for a package
if [ "$ARG1" = "check-updates" ] ; then
  $YUM check-update >> web_log.log
  YUM_RESULT=$?
    case $YUM_RESULT in
      100)
        echo "Updates avalible... "
        exit 111
        ;;
      0)
        echo "No Updates avalble... "
        exit 222
        ;;
      1)
        echo "Error"
        exit 333
        ;;
    esac

#check if the package is installed
elif [ "$ARG1" = "check-installed" ] ; then
  $YUM list --installed $ARG2 >> web_log.log 2>&1
  YUM_RESULT=$?
    case $YUM_RESULT in
      0)
        echo "Package is installed..."
        exit 114
        ;;
      1)
        echo "Package is not installed or not avalible"
        exit 115
        ;;
    esac

#checking if package is avalilbe
elif [ "$ARG1" = "check-avalible" ] ; then
  $YUM list --avalible $ARG2 >> web_log.log 2>&1
  YUM_RESULT=$?
    case $YUM_RESULT in
      0)
        echo "Package is avalible..."
        exit 116
        ;;
      1)
        echo "Package is not avalilbe or does not exist"
        exit 117
        ;;
    esac

#catch all
else
  echo "Invalid Input - Please select one of the following"
  echo "check-updates"
  echo "check-avalible"
  echo "check-installed"
  exit 118
fi
