#!/bin/bash

# Colors
# ----------------------------------------
BL='\e[01;90m' > /dev/null 2>&1; # Black
R='\e[01;91m' > /dev/null 2>&1; # Red
G='\e[01;92m' > /dev/null 2>&1; # Green
Y='\e[01;93m' > /dev/null 2>&1; # Yellow
B='\e[01;94m' > /dev/null 2>&1; # Blue
P='\e[01;95m' > /dev/null 2>&1; # Purple
C='\e[01;96m' > /dev/null 2>&1; # Cyan
LG='\e[01;37m' > /dev/null 2>&1; # Light Gray
N='\e[0m' > /dev/null 2>&1; # Null

# Divider
# ----------------------------------------
divider="-------------------------------------------------" 

# OFox Compiler Header
# ----------------------------------------                                                                           
echo -e $Y "  @@@@@@  @@@@@@@@  @@@@@@  @@@  @@@     @@@@@@@  @@@@@@  @@@@@@@@@@  @@@@@@@  @@@ @@@     @@@@@@@@ @@@@@@@   " $N;sleep 0.2;
echo -e $Y " @@@@@@@@ @@@@@@@@ @@@@@@@@ @@@  @@@    @@@@@@@@ @@@@@@@@ @@@@@@@@@@@ @@@@@@@@ @@@ @@@     @@@@@@@@ @@@@@@@@  " $N;sleep 0.2;
echo -e $Y " @@!  @@@ @@!      @@!  @@@ @@!  !@@    !@@      @@!  @@@ @@! @@! @@! @@!  @@@ @@! @@!     @@!      @@!  @@@  " $N;sleep 0.2;
echo -e $Y " !@!  @!@ !@!      !@!  @!@ !@!  @!!    !@!      !@!  @!@ !@! !@! !@! !@!  @!@ !@! !@!     !@!      !@!  @!@  " $N;sleep 0.2;
echo -e $Y " @!@  !@! @!!!:!   @!@  !@!  !@@!@!     !@!      @!@  !@! @!! !!@ @!! !!@@!@!  !!@ @!!     @!!!:!   @!@!!@!   " $N;sleep 0.2;
echo -e $Y " !@!  !!! !!!!!:   !@!  !!!   @!!!      !!!      !@!  !!! !@!   ! !@! !!@!!!   !!! !!!     !!!!!:   !!@!@!    " $N;sleep 0.2;
echo -e $Y " !!:  !!! !!:      !!:  !!!  !: :!!     :!!      !!:  !!! !!:     !!: !!:      !!: !!:     !!:      !!: :!!   " $N;sleep 0.2;
echo -e $Y " :!:  !:! :!:      :!:  !:! :!:  !:!    :!:      :!:  !:! :!:     :!: :!:      :!: :!:     :!:      :!:  !:!  " $N;sleep 0.2;
echo -e $Y " ::::: ::  ::      ::::: ::  ::  :::     ::: ::: ::::: :: :::     ::   ::       :: ::!::!  :: ::::  ::   :::  " $N;sleep 0.2;
echo -e $Y "  : :  :   :        : :  :   :   ::      :: :: :  : :  :   :      :    :        :   : :: :  : :: ::  :   : :  " $N;sleep 0.2;
echo ""

# Welcome
# ----------------------------------------
echo -e $B "Hello, Thank you for using this script" $N;sleep 0.1;
echo -e $Y "You can easily build orange fox with this script for your Device " $N;sleep 0.1;
sleep 5
clear
#Setup
# ----------------------------------------
echo -e $C "Setup the environment" $N;sleep 0.1;
{
sudo apt install git python aria2 nano -y
sudo pacman -S git aria2 python nano
}&> /dev/null
#Totally a Loading system and not just for looks.
echo -n -e $Y'              •'$N; sleep 0.3;
echo -n -e $Y'•'$N; sleep 0.4;
{
cd || return
git clone https://github.com/akhilnarang/scripts
bash scripts/setup/android_build_env.sh
}&> /dev/null 
echo -n -e $Y'•'$N
sleep 2
clear

#Sync
# ----------------------------------------
echo -e $C "synching the Latest Orange Fox Sources [ Latest 9.0 ]" $N; sleep 0.1;
echo -n -e $Y'              •'$N; sleep 0.3;
echo -n -e $Y'•'$N; sleep 0.4;
{
cd scripts || return
mkdir Orangefox
cd Orangefox || return
repo init --depth=1 -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
repo sync -j8 --force-sync
}&> /dev/null
echo -n -e $Y'•'$N
sleep 2
clear

#Questions
# ----------------------------------------
echo -e $P "Now tell me your device codename" $N; sleep 0.1;
read -r code
echo "$divider"
echo -e $P "Now tell me your device vendor" $N; sleep 0.1;
read -r vendor
echo "$divider"
echo -e $P "Now Give me your trees github link" $N; sleep 0.1;
read -r trees
echo "$divider"
echo -e $P "Now tell me the your name (Username)" $N; sleep 0.1;
read -r main
echo -e $P "Now tell me the version" $N; sleep 0.1;
read -r version
clear

#Clone 
# ----------------------------------------
echo -e $C "Cloning to scripts/Orangefox/device/$vendor/$code" $N; sleep 0.1;
echo -n -e $Y'              •'$N; sleep 0.3;
echo -n -e $Y'•'$N; sleep 0.4;
{
git clone "${trees}" device/"${vendor}"/"${code}"
clear
}&> /dev/null
echo -n -e $Y'•'$N
sleep 2
clear
#Edit Bconfig.mk
# ----------------------------------------
echo -e $LG "If you have to edit the cloned tree (e.g. BoardConfig.mk) do it now." $N; sleep 0.1;
echo -e $P "Press Enter to Continue" $N; sleep 0.1;
read -r Ans

clear

#----------------------------

echo -e $C "Now lets start building the environment" 
source build/envsetup.sh
sleep 5
clear
#-------------------------

echo -e $Y " Options
 1 : You already have a config file created by this script
 2 : You don't have a config file and now we will create it for you and will use it later when rebuilding Ofox
 -------------------------------------------------------------------------------------------------------------- " $N

read -r Ans3

if [ "${Ans3}" = 1 ]
then
clear
#-----
elif [ "${Ans3}" = 2 ]
then
echo -e $Y "Lets create a config file using our good friend nano for your device var settings.
(https://gitlab.com/OrangeFox/vendor/recovery/-/blob/master/orangefox_build_vars.txt) " $N$N; sleep 2;
nano ~/OrangeFox-Universal-Compile-Tool/configs/"${code}"_ofconfig
clear
fi
 



echo -e $LG "Lets Launch it together 😉😋" $N
echo -e $P "Press enter when ready" $N
read -r enter
echo "$divider"

source ~/OrangeFox-Universal-Compile-Tool/configs/"${code}"_ofconfig
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
export FOX_VERSION="${version}"
lunch omni_"${code}"-eng
# If lunch command fail, there is no need to continue building
if [ "$?" != "0" ]; then
  echo -e $R "launch failed :/" $N
  exit
fi
clear

echo -n -e $G "^-^ Building " $N; sleep 0.1;
echo -n -e $Y'              •'$N; sleep 0.2;
echo -n -e $Y'•'$N; sleep 0.2;
echo -n -e $Y'•'$N; sleep 0.2;
echo ""
sleep 2
mka recoveryimage
#---------

echo ""
echo -e $B " credits :
Do follow my Github Account for more scripts : https://github.com/Sammy970
Do follow me too : https://github.com/gghhkm
Would love to help you - Sammy970
All the best - gghhkm " $N
sleep 3
