# Trying to get shas for latest pip repo ... 
.PHONY: test my-cli

test:
	@ ( \
		cat ~/Workspace/git/environment/requirements.txt \
		| xargs -n 1 bash -c 'export URL="https://pypi.org/pypi/$${0}/json" ; curl -Ls "$${URL}" | jq -r --arg resource "$${0}" -f lib.jq' \
		| tee /dev/tty \
		| pbcopy \
	)

my-cli: 
	@ ( \
		cat /Users/omareid/Workspace/git/my-cli/library/requirements.txt \
		| xargs -n 1 bash -c 'export URL="https://pypi.org/pypi/$${0}/json" ; curl -Ls "$${URL}" | jq -r --arg resource "$${0}" -f lib.jq' \
		| tee /dev/tty \
		| pbcopy \
	)
