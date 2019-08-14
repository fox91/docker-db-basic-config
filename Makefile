.PHONY: all
all: mariadb mysql percona

.PHONY: clean
clean: mariadb-clean mysql-clean percona-clean

# mariadb

.PHONY: mariadb
mariadb: mariadb-build mariadb-test-version mariadb-clean

.PHONY: mariadb-build
mariadb-build:
	for file in $(shell find $(CURDIR)/mariadb -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker build -t my/db:mariadb-$$d mariadb/$$d; \
	done

.PHONY: mariadb-clean
mariadb-clean:
	for file in $(shell find $(CURDIR)/mariadb -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker rmi -f my/db:mariadb-$$d; \
	done

.PHONY: mariadb-test-version
mariadb-test-version:
	for file in $(shell find $(CURDIR)/mariadb -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker run -it --rm my/db:mariadb-$$d mysqld --version; \
	done

# mysql

.PHONY: mysql
mysql: mysql-build mysql-test-version mysql-clean

.PHONY: mysql-build
mysql-build:
	for file in $(shell find $(CURDIR)/mysql -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker build -t my/db:mysql-$$d mysql/$$d; \
	done

.PHONY: mysql-clean
mysql-clean:
	for file in $(shell find $(CURDIR)/mysql -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker rmi -f my/db:mysql-$$d; \
	done

.PHONY: mysql-test-version
mysql-test-version:
	for file in $(shell find $(CURDIR)/mysql -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker run -it --rm my/db:mysql-$$d mysqld --version; \
	done

# percona

.PHONY: percona
percona: percona-build percona-test-version percona-clean

.PHONY: percona-build
percona-build:
	for file in $(shell find $(CURDIR)/percona -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker build -t my/db:percona-$$d percona/$$d; \
	done

.PHONY: percona-clean
percona-clean:
	for file in $(shell find $(CURDIR)/percona -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker rmi -f my/db:percona-$$d; \
	done

.PHONY: percona-test-version
percona-test-version:
	for file in $(shell find $(CURDIR)/percona -type f -maxdepth 2 -mindepth 2); do \
		d=$$(basename $$(dirname $$file)); \
		echo "-=-=- $$d"; \
		docker run -it --rm my/db:percona-$$d mysqld --version; \
	done
