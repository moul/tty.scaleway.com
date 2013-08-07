#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

from optparse import OptionParser
from subprocess import Popen, PIPE, STDOUT
import pty
import os

def socat(host, port):
    """Drop a socat shell from within Python"""
    cmd = 'socat stdio,raw,echo=0 tcp-connect:%s:%d' % (host, port)
    os.system(cmd)

def get_blade_ip(pimouss=1, blade=1, shelf=1, platform='dev'):
    """Retrieves a blade ip address based on its specifications"""
    if platform == 'dev' and shelf == 1:
        return '192.168.50.%d' % blade
    return False

def get_pimouss_port(pimouss=1, admin=False):
    """Calculates console-proxy TCP port based on Pimouss SLOT and admin mode"""
    return 1999 + pimouss + (19 if admin else 0)

if __name__ == "__main__":
    parser = OptionParser(usage='%prog [options]')
    parser.add_option("-p", "--pimouss",  dest="pimouss",  type='int', help="pimouss slot PIMOUSS", metavar="PIMOUSS", default=1)
    parser.add_option("-b", "--blade",    dest="blade",    type='int', help="blade slot",  default=1)
    parser.add_option("-s", "--shelf",    dest="shelf",    type='int', help="shelf slot",  default=1)
    parser.add_option("-P", "--platform", dest="platform", type='string', help="platform id", default="dev")
    parser.add_option("-a", "--admin",    dest="admin",    action="store_true", help="Admin mode", default=False)

    (options, args) = parser.parse_args()

    host = get_blade_ip(blade=options.blade)
    port = get_pimouss_port(pimouss=options.pimouss, admin=options.admin)
    print("Connecting to host=%s:%d, close the terminal to quit." % (host, port))
    socat(host, port)
