#!/bin/bash
#
# - This function can detect the operating system for a target Linux Machine. 
# - This function is aimed at server operating systems, Tested on: Centos 6 -5, Ubuntu 14-20, Debian 8-10
findOS () {
#Get OS distro
if [ -f "/etc/os-release" ]; then
    . "/etc/os-release"
    case "$NAME" in
        # Matches RHEL 7
        "Red Hat Enterprise Linux Server" ) OS_DISTRO="rhel" ;;
        # Matches CentOS 7 and 8
        "CentOS Linux" ) OS_DISTRO="centos" ;;
        # Matches Ubuntu 16.04 18.04 20.04
        "Ubuntu" ) OS_DISTRO="ubuntu" ;;
        # Matches Debian 8 9
        "Debian GNU/Linux" ) OS_DISTRO="debian" ;;
        * ) OS_DISTRO="invalid-or-unknown" ;;
    esac
    if [ "$OS_DISTRO" == "centos" ] || [ "$OS_DISTRO" == "rhel" ]; then
        case "$VERSION_ID" in
            7* ) OS_VERSION_ID="7";;
            8* ) OS_VERSION_ID="8";;
            * ) OS_VERSION_ID="invalid-or-too-old" ;;
        esac
    fi
    if [ "$OS_DISTRO" == "ubuntu" ]; then
        case "$VERSION_ID" in
            12* ) OS_VERSION_ID="12";;
            14* ) OS_VERSION_ID="14";;
            16* ) OS_VERSION_ID="16";;
            18* ) OS_VERSION_ID="18";;
            20* ) OS_VERSION_ID="20";;
            * ) OS_VERSION_ID="invalid-or-too-old" ;;
        esac
    fi
    if [ "$OS_DISTRO" == "debian" ]; then
        case "$VERSION_ID" in
            7* ) OS_VERSION_ID="7";;
            8* ) OS_VERSION_ID="8";;
            9* ) OS_VERSION_ID="9";;
            10* ) OS_VERSION_ID="10";;
            * ) OS_VERSION_ID="invalid-or-too-old" ;;
        esac
    fi
elif [ -f "/etc/centos-release" ]; then
#CentOS 6 doesnt have an os-release file, so doing this manually using the centos-release file
    if (grep "^CentOS release 6" /etc/centos-release >> /dev/null) then
        OS_DISTRO="centos"
        OS_VERSION_ID="6"
    fi
elif [ -f "/etc/redhat-release" ]; then
#RHEL 6 doesnt have an os-release file, so doing this manually using the redhat-release file
    if (grep "^Red Hat Enterprise Linux Server release 6" /etc/redhat-release >> /dev/null) then
        OS_DISTRO="rhel"
        OS_VERSION_ID="6"
    fi
else
    bool_success="False"
    echo "[Error] Could not determine how to detect OS version. os-release or centos/redhat-release files not present."
    exit 1
fi
if [ "$DEBUG" == "True" ]; then
    echo "[Info] Detected OS $OS_DISTRO $OS_VERSION_ID"
fi
}
