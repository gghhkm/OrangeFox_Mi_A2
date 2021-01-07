#!/bin/bash
echo " Hello, Thank you for using this script "
echo " You can easily build orange fox with this script for your Xiaomi Device "
echo " First lets setup the environment "
echo " Press Enter to Start "
read -r Ans

echo "_________________________________________________________________________________________"

cd || return
git clone https://github.com/akhilnarang/scripts
bash scripts/setup/android_build_env.sh

echo "_________________________________________________________________________________________"

echo " Now lets sync the Latest Orange Fox Sources [ Latest 9.0 ] "
read -r ans
cd || return
cd scripts || return
mkdir Orangefox
cd Orangefox || return
repo init --depth=1 -q -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
repo sync -c -f -q --force-sync --no-clone-bundle --no-tags -j$(nproc --all)

echo "_________________________________________________________________________________________"

clear

echo "_________________________________________________________________________________________"

echo " Now tell me your device codename "
read -r code

echo " Now tell me your device vendor "
read -r vendor
echo " Now Give me your trees github link "
read -r trees


cd || return
cd scripts/Orangefox || return
git clone "$trees" device/"$vendor"/"$code"

echo "_________________________________________________________________________________________"

echo " Now lets start building the environment "
cd || return
cd scripts/Orangefox/ || return
source build/envsetup.sh

echo "_________________________________________________________________________________________"

echo " Now tell me the name of the maintainer "
read -r main

echo "_________________________________________________________________________________________"


# Common variables for OF building scripts
# For building with minimal TWRP
export ALLOW_MISSING_DEPENDENCIES=true
export TW_DEFAULT_LANGUAGE="en"
# To use ccache to speed up building
export USE_CCACHE="1"
# Enforced by R11 rules
export FOX_R11="1"
export FOX_ADVANCED_SECURITY="1"
export FOX_RESET_SETTINGS="1"
# Import OrangeFox build variables
source configs/"${code}"_ofconfig

clear
echo "_________________________________________________________________________________________"

echo " Lets Lunch it all together 😉😋 "
lunch omni_"${code}"

# If lunch command fail, there is no need to continue building
if [ "$?" != "0" ]; then
  exit
fi



echo "_________________________________________________________________________________________"

echo " Lets Start Building "
mka recoveryimage

echo "_________________________________________________________________________________________"

echo " Thank you for using my Script "
echo " Do follow my Github Account for more scripts : https://github.com/Sammy970 "
echo " Would love to help you "
