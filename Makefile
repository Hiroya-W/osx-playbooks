SHELL := /bin/bash

PLAYBOOK_DIR := playbooks
ANSIBLE_CMD := poetry run ansible
PLAYBOOK_CMD := poetry run ansible-playbook
GALAXY_CMD := poetry run ansible-galaxy

.PHONY: ping
ping:
	$(ANSIBLE_CMD) -m ping all

.PHONY: deps
deps:
	$(GALAXY_CMD) install -r roles/requirements.yml

.PHONY: check
check:
	$(PLAYBOOK_CMD) $(PLAYBOOK_DIR)/playbook.yml --syntax-check
	$(PLAYBOOK_CMD) $(PLAYBOOK_DIR)/playbook.yml --list-tasks
	$(PLAYBOOK_CMD) $(PLAYBOOK_DIR)/playbook.yml --ask-become-pass --check

.PHONY: playbook
apps:
	$(PLAYBOOK_CMD) --ask-become-pass $(PLAYBOOK_DIR)/playbook.yml $(args)
