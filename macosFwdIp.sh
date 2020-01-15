#!/bin/bash

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
