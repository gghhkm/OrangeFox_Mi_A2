#!/bin/bash

echo "
.█████╗.███████╗.█████╗.██╗..██╗.
██╔══██╗██╔════╝██╔══██╗╚██╗██╔╝....
██║..██║█████╗..██║..██║.╚███╔╝...
██║..██║██╔══╝..██║..██║.██╔██╗....
╚█████╔╝██║.....╚█████╔╝██╔╝╚██╗..
.╚════╝.╚═╝......╚════╝.╚═╝..╚═╝....
.█████╗..█████╗.███╗...███╗██████╗.██╗██╗.....███████╗....██╗.......██╗██╗████████╗██╗..██╗....
██╔══██╗██╔══██╗████╗.████║██╔══██╗██║██║.....██╔════╝....██║..██╗..██║██║╚══██╔══╝██║..██║..
██║..╚═╝██║..██║██╔████╔██║██████╔╝██║██║.....█████╗......╚██╗████╗██╔╝██║...██║...███████║....
██║..██╗██║..██║██║╚██╔╝██║██╔═══╝.██║██║.....██╔══╝.......████╔═████║.██║...██║...██╔══██║..
╚█████╔╝╚█████╔╝██║.╚═╝.██║██║.....██║███████╗███████╗.....╚██╔╝.╚██╔╝.██║...██║...██║..██║.....
.╚════╝..╚════╝.╚═╝.....╚═╝╚═╝.....╚═╝╚══════╝╚══════╝......╚═╝...╚═╝..╚═╝...╚═╝...╚═╝..╚═╝...
██████╗..█████╗..██╗.......██╗███████╗██████╗...██╗...
██╔══██╗██╔══██╗.██║..██╗..██║██╔════╝██╔══██╗..██║..
██████╔╝██║..██║.╚██╗████╗██╔╝█████╗..██████╔╝..██║.....
██╔═══╝.██║..██║..████╔═████║.██╔══╝..██╔══██╗..╚═╝...
██║.....╚█████╔╝..╚██╔╝.╚██╔╝.███████╗██║..██║..██╗....
╚═╝......╚════╝....╚═╝...╚═╝..╚══════╝╚═╝..╚═╝..╚═╝. "
echo " Hello, Thank you for using this script
You can easily build orange fox with this script for your Device "
sleep 5
echo " First lets setup the environment
Press Enter to Start "
read -r Ans
clear
#---------------

cd || return
git clone https://github.com/akhilnarang/scripts
bash scripts/setup/android_build_env.sh
clear
#---------------

echo " Now lets sync the Latest Orange Fox Sources [ Latest 9.0 ]
Press Enter to Start "
read -r Ans
cd || return
cd scripts || return
mkdir Orangefox
cd Orangefox || return
repo init --depth=1 -q -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
repo sync -c -f -q --force-sync --no-clone-bundle --no-tags -j"$(nproc --all)"

#---------------

clear
echo "_________________________________________________________________________________________"

echo " Now tell me your device codename "
read -r code

echo " Now tell me your device vendor "
read -r vendor

echo " Now Give me your trees github link "
read -r trees

echo " Now tell me the your name (Username) "
read -r main

clear

#-------------------------------------
git clone "${trees}" device/"${vendor}"/"${code}"
clear

echo " If you have to edit the cloned tree (e.g. BoardConfig.mk) do it now.
Press Enter to Continue "
read -r Ans

clear

#----------------------------

echo " Now lets start building the environment "
source build/envsetup.sh

#-------------------------

#Maintainer
export OF_MAINTAINER="${main}"
## Universal variables for building
export ALLOW_MISSING_DEPENDENCIES=true
export TW_DEFAULT_LANGUAGE="en"
export USE_CCACHE="1"
export FOX_R11="1"
export FOX_ADVANCED_SECURITY="1"
export FOX_RESET_SETTINGS="1"

echo " Now tell me the version "
read -r version
export FOX_VERSION="${version}"

clear
#-------------------------

echo " Options
 1 : You already have a config file created by this script
 2 : You don't have a config file and now we will create it for you and will use it later when rebuilding Ofox
 -------------------------------------------------------------------------------------------------------------- "

read -r Ans3

if [ "${Ans3}" = 1 ]
then
source ~/OrangeFox-Universal-Compile-Tool/configs/"${code}"_ofconfig
echo " Done importing your Device Specific settings "
clear
#-----
elif [ "${Ans3}" = 2 ]
then
echo " Lets create a config file using our good friend nano for your device var settings.
(https://gitlab.com/OrangeFox/vendor/recovery/-/blob/master/orangefox_build_vars.txt) "

touch ~/OrangeFox-Universal-Compile-Tool/configs/"${code}"_ofconfig | nano

echo " Now that You've saved you're config fle, lets build Ofox
Press enter when ready "
read -r enter

source ~/OrangeFox-Universal-Compile-Tool/configs/"${code}"_ofconfig
fi


clear
echo "_________________________________________________________________________________________"

echo " Lets Launch it together 😉😋 "
lunch omni_"${code}"

# If lunch command fail, there is no need to continue building
if [ "$?" != "0" ]; then
  echo "launch failed :/"
  exit
fi

clear

echo " ^-^
_________________________________________________________________________________________

Lets Start Building "
mka recoveryimage

#---------
clear

echo " credits :
Do follow my Github Account for more scripts : https://github.com/Sammy970
Do follow me too : https://github.com/gghhkm
Would love to help you - Sammy970
All the best - gghhkm "
sleep 5
echo "
██████╗..█████╗.███╗..██╗███████╗..██╗.██╗...
██╔══██╗██╔══██╗████╗.██║██╔════╝..██║.██║....
██║..██║██║..██║██╔██╗██║█████╗....██║.██║..
██║..██║██║..██║██║╚████║██╔══╝....╚═╝.╚═╝.....
██████╔╝╚█████╔╝██║.╚███║███████╗..██╗.██╗...
╚═════╝..╚════╝.╚═╝..╚══╝╚══════╝..╚═╝.╚═╝....."
