# Trying to get shas for latest pip repo ... 
.PHONY: test my-cli

# Where the other repos are checked out. Override: make my-cli GIT_DIR=~/src
GIT_DIR ?= $(HOME)/Workspace/git

test:
	@ ( \
		cat $(GIT_DIR)/environment/requirements.txt \
		| xargs -n 1 bash -c 'export URL="https://pypi.org/pypi/$${0}/json" ; curl -Ls "$${URL}" | jq -r --arg resource "$${0}" -f lib.jq' \
		| tee /dev/tty \
		| pbcopy \
	)

my-cli: 
	@ ( \
		cat $(GIT_DIR)/my-cli/library/requirements.txt \
		| xargs -n 1 bash -c 'export URL="https://pypi.org/pypi/$${0}/json" ; curl -Ls "$${URL}" | jq -r --arg resource "$${0}" -f lib.jq' \
		| tee /dev/tty \
		| pbcopy \
	)
