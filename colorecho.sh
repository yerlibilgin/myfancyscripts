#!/bin/bash

#  Copyright 2025 yerlibilgin
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.


# This script contains colorful variants of echo


redColor="\e[31m"
yellowColor="\e[93m"
greenColor="\e[32m"
blueColor="\e[34m"
cyanColor="\e[36m"
magentaColor="\e[35m"
resetCode="\e[0m"

function echoRed(){
  echo "${redColor}$@${resetCode}"
}


function echoYellow(){
  echo "${yellowColor}$@${resetCode}"
}

function echoGreen(){
  echo "${greenColor}$@${resetCode}"
}

function echoBlue(){
  echo "${blueColor}$@${resetCode}"
}

function echoCyan(){
  echo "${cyanColor}$@${resetCode}"
}

function echoMagenta(){
  echo "${magentaColor}$@${resetCode}"
}