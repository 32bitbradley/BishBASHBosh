#!/bin/sh
#
# - A really simple functction to show the usage of a script when called. Works well when using shift to collect CLI arguments.
# - Uses EQF to spit out formatted text

show_usage () {
cat <<\EQF

 This is a help section...
 
 Usage ./my-script.sh [OPTIONS]
 --help - Show this help page
 --debug | Run script in debug mode

EQF
}
