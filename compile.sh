#!/bin/bash
echo " Hello, Thankyou for using this script "
echo " You can easily build orange fox with this script for your Xiaomi Device "
echo " First lets setup the environment "
echo " Press Enter to Start "
read Ans

echo "_________________________________________________________________________________________"

cd
git clone https://github.com/akhilnarang/scripts
bash scripts/setup/android_build_env.sh

echo "_________________________________________________________________________________________"

echo " Now lets sync the Latest Orange Fox Sources [ Latest 9.0 ] "
read ans 
cd
cd scripts
mkdir Orangefox
cd Orangefox
repo init --depth=1 -q -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
repo sync -c -f -q --force-sync --no-clone-bundle --no-tags -j$(nproc --all)

echo "_________________________________________________________________________________________"

clear

echo "_________________________________________________________________________________________"

echo " Now tell me your Xiaomi device codename "
read code 

echo " Now Give me your trees github link "
read trees

cd
cd scripts/Orangefox
git clone $trees device/xiaomi/$code

echo "_________________________________________________________________________________________"

echo " Now lets start building the environment "
cd
cd scripts/Orangefox/
source build/envsetup.sh

echo "_________________________________________________________________________________________"

echo " Now tell me the name of the maintainer "
read main

echo "_________________________________________________________________________________________"

echo " Now tell me the codename for your device "
read code

# Import OrangeFox build variables
source configs/"${code}"_ofconfig

clear
echo "_________________________________________________________________________________________"

echo " Lets Lunch it all together 😉😋 "
lunch omni_$code

# If lunch command fail, there is no need to continue building
if [ "$?" != "0" ]; then
	exit
fi


echo "_________________________________________________________________________________________"

echo " Lets Start Building "
mka recoveryimage

echo "_________________________________________________________________________________________"

echo " Thankyou for using my Script " 
echo " Do follow my Github Account for more scripts : https://github.com/Sammy970 "
echo " Would love to help you "
