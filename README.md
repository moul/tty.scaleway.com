Console Proxy
=============

    socat stdio,raw,echo=0 tcp-connect:192.168.50.1:2018

Install
-------

- Artifacts are build by jenkins and pushed on mirror https://mirror.pv.ocshq.com/jenkins-builds/console-proxy-dev/
- Install `lib-nolp`
- Create a configuration file that can access a postgresql database
- Install node

Run
---

    $ workon lib-nolp  # enter in lib-nolp venv
    $ export OCS_SETTINGS=/path/to/settings.yaml
    $ node server.js

    or

    $ OCS_SETTINGS=/path/to/settings.yaml node server.js /path/to/venv/bin/nolp-cli
