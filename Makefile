.PHONY: all
all: mariadb

.PHONY: clean
clean: mariadb-clean

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
