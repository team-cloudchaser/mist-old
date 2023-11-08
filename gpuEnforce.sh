#!/bin/bash
javaPath="$(which java)"
jarPath="./HMCL-3.5.2.jar"
denoRun="run --allow-read --allow-write --allow-net --unstable"
if [[ "$(which deno)" == "/"* ]] ; then
	echo "Using system Deno runtime."
	deno $denoRun assetUpdater.js
elif [[ -e "~/.deno/bin/deno" ]] ; then
	echo "Using userspace Deno runtime."
	~/.deno/bin/deno $denoRun assetUpdater.js
elif [[ -e "./deno" ]] ; then
	echo "Using custom Deno runtime."
	./deno $denoRun assetUpdater.js
else
	echo "Deno is not present."
fi
if [ "$DISPLAY" == "" ] ; then
	echo "No display detected. Assuming usage of the first display."
	export DISPLAY=:1
else
	echo "Using display $DISPLAY."
fi
if [ "$(ls -1 $PREFIX/bin | grep nvidia-settings)" != "" ] ; then
	echo "NVIDIA GPU detected. Using NVIDIA settings."
	export __NV_PRIME_RENDER_OFFLOAD=1
	export __GLX_VENDOR_LIBRARY_NAME=nvidia
	__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia "$javaPath" -jar "$jarPath"
elif [ "$(ls -1 $PREFIX/bin | grep -E (amd-|radeon))" != "" ] ; then
	echo "AMD GPU detected. Using AMD settings."
	export DRI_PRIME=1
	DRI_PRIME=1 "$javaPath" -jar "$jarPath"
else
	echo "Dedicated graphics not detected. Using system default graphics provider."
	"$javaPath" -jar "$jarPath"
fi
clear
exit
