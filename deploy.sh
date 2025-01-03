#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git age git-crypt

set -e

REPO_LOCATION=$HOME/repositories/tsIgov/hosts-config

BRANCH_NAME=$1
if [ -z $BRANCH_NAME ]; then
	BRANCH_NAME=$(hostname)
fi

SCRIPT_PATH=$(realpath $0)

clone_repo() {
	git clone --branch $BRANCH_NAME https://github.com/tsIgov/hosts-config.git $REPO_LOCATION
}

unlock_repo() {
	cd $REPO_LOCATION

	while ! age -d -o $BRANCH_NAME key.age
	do
		echo "Try again"
	done

	git-crypt unlock $BRANCH_NAME
	rm -f $BRANCH_NAME
}

link_configs() {
	sudo rm -rf /etc/nixos
	sudo ln -s $REPO_LOCATION/src /etc/nixos
}

install() {
	sudo nixos-generate-config
	sudo nixos-rebuild switch --flake $(realpath /etc/nixos)#$BRANCH_NAME
}

clone_repo
unlock_repo
link_configs
install

rm $SCRIPT_PATH