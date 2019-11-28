.PHONY: start clean onos frr
include .env

ALL: 	download env_check start

download:
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m Downloading pipework  \033[0m"
	@echo "\033[32m-----------------------\033[0m"
ifneq ("$(wildcard ./pipework)","")
	@echo "Pipework already exist!"
else
	@wget https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework
	@chmod +x pipework
endif

env_check:
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m Checking config file  \033[0m"
	@echo "\033[32m-----------------------\033[0m"
ifeq ("$(wildcard ./volume/frr/daemons)","")
$(error Config file daemons not found!)
endif
ifeq ("$(wildcard ./volume/frr/frr.conf)","")
$(error Config file frr.conf not found!)
endif

start:
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m     Starting ONOS     \033[0m"
	@echo "\033[32m-----------------------\033[0m"
	@docker-compose run --rm start_onos
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m     Starting Frr      \033[0m"
	@echo "\033[32m-----------------------\033[0m"
	@docker-compose up -d frr
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m Pipe interface to frr \033[0m"
	@echo "\033[32m-----------------------\033[0m"
ifndef PIPE_INTF
	@echo "Param PIPE_INTF is not set"
	@echo "Skipping pipework!"
else ifndef PIPE_IP
	@echo "Param PIPE_IP is not set"
	@echo "Skipping pipework!"
else
	@sudo ./pipework $(PIPE_INTF) -i eth1 frr $(PIPE_IP)
endif

clean:
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m    Cleaning up env    \033[0m"
	@echo "\033[32m-----------------------\033[0m"
	@docker-compose down --remove-orphan

onos:
	@ssh -o "StrictHostKeyChecking=no" \
             -o GlobalKnownHostsFile=/dev/null \
             -o UserKnownHostsFile=/dev/null onos@localhost -p 8101

frr:
	@docker exec -it frr vtysh
