#!/bin/sh
#
# - A set of code to parse command line arguments, using shift to work through and assign each one.
#
while [ "$1" != "" ]; do
    case $1 in
        --exmaple-flag )        #shift
                                exmaple-flag="True"
                                ;;
        --function-flag)        #shift
                                example-function "some data"
                                ;;
        --argument )            shift
                                ARGUMENT="$1"
                                ;;
        --help )                show_usage
                                exit 0
                                ;;
        * )                     show_usage
                                exit 1
    esac
    shift
done
