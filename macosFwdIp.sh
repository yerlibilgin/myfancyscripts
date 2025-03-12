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

# Only MacOS

# Forward IP to localhost
# @param1: IP to be forwardedSample usage:
#  ipFwdLocalhost 12.0.1.2
#  this will forward 12.0.1.2 to localhost
alias ipFwdLocalhost='sudo ifconfig lo0 alias '

# Disable ip forwarding
# @param1: IP to be disabled for forwarding
# Sample:
#  disableFwdLocalhost 12.0.1.2
#  this will forward 12.0.1.2 to localhost
alias disableFwdLocalhost='sudo ifconfig lo0 -alias '

# the minus prepended to alias works as a minus
