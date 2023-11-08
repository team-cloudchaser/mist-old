#!/bin/bash
cd ".minecraft/versions/1.18.1 Fabric/"
if [ "$SHELL" != "" ] ; then
	echo Using default shell...
	"$SHELL"
elif [[ "$(which fish)" == "/"* ]] ; then
	echo Using FISH...
	fish
elif [[ "$(which zsh)" == "/"* ]] ; then
	echo Using ZSH...
	zsh
elif [[ "$(which bash)" == "/"* ]] ; then
	echo Using Bash...
	bash
else
	echo Using basic shell or BusyBox...
	sh
fi
echo "Leaving..."
exit