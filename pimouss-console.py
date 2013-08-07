#!/usr/bin/env python2.7

from optparse import OptionParser
from subprocess import Popen, PIPE, STDOUT
import pty
import os

def socat(host, port):
    cmd = 'socat stdio,raw,echo=0 tcp-connect:%s:%d' % (host, port)
    os.system(cmd)

def get_blade_address(pimouss=1, blade=1, shelf=1, platform='dev'):
    if platform == 'dev' and shelf == 1:
        return '192.168.50.%d' % blade
    return False

def get_pimouss_port(pimouss=1, admin=False):
    return 2000 + pimouss + (19 if admin else 0)

if __name__ == "__main__":
    host = get_blade_address(blade=1)
    port = get_pimouss_port(pimouss=1, admin=False)
    print host, port
    #socat(host, port)
