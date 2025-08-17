#!/usr/bin/env bash
set -e

# Very basic build shell script. Remove, change or discard if desired

# Change the project name here
NAME=ROBO2RG05AU
# Verbose output
VERBOSE=true

if [[ -z $VEX_V5_SDK_PATH  ]] ; then
    printf "VEX_V5_SDK_PATH Environment Variable is not set, please set it!\n" >&2
    exit 1
fi

build_binary()
{
    make $@ P=$NAME T=$VEX_V5_SDK_PATH V=$VERBOSE
}

upload_binary()
{
    pros upload --target v5 --after run build/${NAME}.bin
}

help_message()
{
    printf "Usage: $0 [OPTIONS]\n"
    printf "\n"
    printf "    [EMPTY]    Compile and upload the binary to a V5 device\n"
    printf "    help       Display this message\n"
    printf "    clean      Clean the build directory\n"
    printf "    upload     Upload the compiled binary to a V5 device\n"
}

if [[ $# -eq 0 ]] ; then # No arguments provided
    build_binary; upload_binary
    exit 0
fi

case "$1" in
    clean)
        build_binary clean # make clean
        exit 0;;
    upload)
        upload_binary
        exit 0;;
    *)
        printf "Unkown option: $1\n" >&2
        help_message
        exit 2;;
esac
