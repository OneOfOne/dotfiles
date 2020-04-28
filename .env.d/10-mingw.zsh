function setmingw {
	local MINGWPATH="/usr/src/tkg-pkgbuilds/mostlyportable-gcc/mingw-mostlyportable-9.3.1-releases-gcc.9.3.0.r131.gd2fee90546d"
	path=($path $MINGWPATH/bin $MINGWPATH/lib $MINGWPATH/include)
}
