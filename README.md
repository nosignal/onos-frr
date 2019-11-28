# FRR route push ONOS FPM Testing Environment

This is an onos fpm with frr test environment. 

In this environment, the script will automatically start a single instance ONOS, and a single frr instance connect to onos via fpm.

## Prerequisite
We assume you have Docker and docker-compose installed in your system. The recommended version is Docker >= 18.06.

Please make sure your user be able to run the docker command or use `sudo` for the following commands.

**Note: the script is only tested in Ubuntu Linux.**

## Quick Start

- Download from source
    ```
    git clone https://github.com/nosignal/onos-frr
    cd onos-frr
    ```

- Start the enviroment
    ```
    make
    ```

- Attach to ONOS CLI
    ```
    make onos
    ```
    **Note: default ONOS username/password is `onos/rocks`**

- Attach to FRR CLI
    ```
    make frr
    ```

- Pushing sample static route to ONOS
    ```
    make route
    ```

- Tear down the enviroment
    ```
    make clean
    ```

## Reference
- [1] [vRouter configuration of ONOS](https://wiki.opencord.org/pages/viewpage.action?pageId=3014982)
- [2] [Dockerfile of ONOS](https://github.com/opennetworkinglab/onos/blob/master/Dockerfile)
- [3] [Dockerfile of FRR](https://github.com/FRRouting/frr/blob/master/docker/debian/Dockerfile)
