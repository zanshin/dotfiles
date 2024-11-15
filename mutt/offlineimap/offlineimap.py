#!/usr/bin/python

import subprocess

def mailpassword(account):
    path = "/home/mark/.mutt/passwords/%s.gpg" % account
    try:
        return subprocess.check_output(["gpg", "--quiet", "--batch", "-d", path]).strip()
    except subprocess.CalledProcessError:
        return ""
