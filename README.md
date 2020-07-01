
## USAGE

### 1. EPIPHANY'S "PREPARE SCRIPTS"

#### 1.1 UBUNTU-18.04 / CENTOS-7

__To run this set of scripts you'll need working Docker, GNU make and BASH installed.__

Go to `./prepare_scripts/ubuntu-18.04/` or `./prepare_scripts/centos-7/`.

To create an Epiphany offline package from the `develop` branch, just run:
```bash
$ make
```

If you want to make an offline package from a different fork (https is recommended) and branch, just run:
```bash
$ make EPIPHANY_REMOTE=https://your-remote EPIPHANY_BRANCH=your-branch
```

Grab the `./output/` directory and use it! :+1:

#### 1.2 REDHAT-7

__To run this set of scripts you'll need working Docker, GNU make and BASH installed.__

Register and login to the [developer.redhat.com](https://developers.redhat.com/) website.

Go to `./prepare_scripts/redhat-7/`.

Create the `Makefile.SUBSCRIPTION` file (see the `Makefile.SUBSCRIPTION.sample` file):
```bash
$ cat >Makefile.SUBSCRIPTION <<EOF
SUBSCRIPTION_USERNAME := <account-username-from-developers.redhat.com>
SUBSCRIPTION_PASSWORD := <account-password-from-developers.redhat.com>
EOF
```

To manage your subscriptions visit the [access.redhat.com/management/systems](https://access.redhat.com/management/systems) website.

If your subscriptions suddenly start failing, just remove old/stale subscriptions on the website above.

To create an Epiphany offline package from the `develop` branch, just run:
```bash
$ make
```

If you want to make an offline package from a different fork (https is recommended) and a branch, just run:
```
$ make EPIPHANY_REMOTE=https://your-remote EPIPHANY_BRANCH=your-branch
```

Grab the `./output/` directory and use it! :+1:

### 2. EPIPHANY'S "IMAGE REGISTRY"

#### 2.1 UBUNTU-18.04 / CENTOS-7 / REDHAT-7

__To run this set of scripts you'll need working Docker, docker-compose, GNU make and BASH installed.__

Create one of the offline packages as displayed in 1.

Go to `./image_registry/ubuntu-18.04/` or `./image_registry/centos-7/` or `./image_registry/redhat-7/` (corresponding to your offline package you just created).

Each of the above locations contains the standard `.env` file that is used by the docker-compose, please take a look at your `.env` file at hand and customize it (or just use defaults).

To start and build repository and image registry, just run:
```bash
$ make
```

The docker-compose yaml config has been interfaced with the following Makefile recipes:
```make
.PHONY: all

all: up

.PHONY: up_no_logs logs up down purge ps

up_no_logs: $(COMPOSE_FILE)
	@docker-compose --file $< up --detach

logs: $(COMPOSE_FILE)
	@docker-compose --file $< logs --follow

up: up_no_logs logs

down: $(COMPOSE_FILE)
	@docker-compose --file $< down

purge: $(COMPOSE_FILE)
	@docker-compose --file $< down --volumes

ps: $(COMPOSE_FILE)
	@docker-compose --file $< ps

.PHONY: exec_repository exec_image_registry

exec_repository: $(COMPOSE_FILE)
	@docker-compose --file $< exec repository /bin/sh

exec_image_registry: $(COMPOSE_FILE)
	@docker-compose --file $< exec image_registry /bin/sh
```

For example to destroy existing cluster and to drop all volume data, just run:
```bash
$ make purge
```

If you desire to run multiple repos at once, it's perfectly possible. Default configs have been already customized:

__UBUNTU-18.04__:
```dosini
# Dots in the project name are skipped anyways.
COMPOSE_PROJECT_NAME=ubuntu_1804

NAME=ubuntu-18.04

OFFLINE_DIR=./../../prepare_scripts/ubuntu-18.04/output

# The three first octets only (assuming 24-bit network mask).
SUBNET_PREFIX=192.168.200

REPOSITORY_PORT=8080

IMAGE_REGISTRY_PORT=5000
```

__CENTOS-7__:
```dosini
# Dots in the project name are skipped anyways.
COMPOSE_PROJECT_NAME=centos_7

NAME=centos-7

OFFLINE_DIR=./../../prepare_scripts/centos-7/output

# The three first octets only (assuming 24-bit network mask).
SUBNET_PREFIX=192.168.201

REPOSITORY_PORT=8081

IMAGE_REGISTRY_PORT=5001
```

__REDHAT-7__:
```dosini
# Dots in the project name are skipped anyways.
COMPOSE_PROJECT_NAME=redhat_7

NAME=redhat-7

OFFLINE_DIR=./../../prepare_scripts/redhat-7/output

# The three first octets only (assuming 24-bit network mask).
SUBNET_PREFIX=192.168.202

REPOSITORY_PORT=8082

IMAGE_REGISTRY_PORT=5002
```

[//]: # ( vim:set ts=2 sw=2 et syn=markdown: )
