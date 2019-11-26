.PHONY: start clean onos frr
include .env

ALL: 	download start

download:
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m Downloading pipework  \033[0m"
	@echo "\033[32m-----------------------\033[0m"
ifneq ("$(wildcard ./pipework)","")
	@echo "\033[32m Pipework already exist! \033[0m"
else
	wget https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework
	chmod +x pipework
endif

start:
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m     Starting ONOS     \033[0m"
	@echo "\033[32m-----------------------\033[0m"
	docker-compose run --rm start_onos
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m     Starting Frr      \033[0m"
	@echo "\033[32m-----------------------\033[0m"
	docker-compose up -d frr
	@echo "\033[32m-----------------------\033[0m"
	@echo "\033[32m Pipe interface to frr \033[0m"
	@echo "\033[32m-----------------------\033[0m"
	sudo ./pipework $(PIPE_INTF) -i eth1 frr $(PIPE_IP)

clean:
	docker-compose down --remove-orphan

onos:
	ssh -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null onos@localhost -p 8101

frr:
	docker exec -it frr vtysh
