#!/bin/bash
#
# Copyright 2017 fgalindo@talend.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
#
################################################################################
#
# Install GUI on CentOS and RHEL 7
#
################################################################################

# User Password file
user_pass_file=".password"

# Installing GUI Components
sudo yum group list
sudo yum groupinstall -y 'Server with GUI'
sudo yum groupinstall -y 'X Window System' 'GNOME'
sudo systemctl set-default graphical.target

# Setting up XRDP
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
sudo yum install -y xrdp tigervnc-server

sudo chcon --type=bin_t /usr/sbin/xrdp
sudo chcon --type=bin_t /usr/sbin/xrdp-sesman

sudo systemctl start xrdp
sudo systemctl enable xrdp

# enable RDP port
sudo firewall-cmd --permanent --add-port=3389/tcp
sudo firewall-cmd --reload

# password for RDP user
awk '{print $2}' "$user_pass_file" | sudo passwd $(awk '{print $1}' "$user_pass_file") --stdin
################################################################################
