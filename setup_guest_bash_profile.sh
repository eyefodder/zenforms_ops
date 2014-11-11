#!/usr/bin/env bash
# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)



add_comment_once(){
  comment=$1
  grep -q "$comment" $bash_file
  if [ $? -ne 0 ]
    then
    echo "# $comment" >> $bash_file
  fi
}

add_bash_entry(){
  token=$1
  default=$2
  change_message="You need to enter your $1 in $bash_file"
  entry_comment=$3
  suppress_warning=$4


  grep -q $token= $bash_file
  if [ $? -eq 0  ]
    then
    if [ "$suppress_warning" != "true" ]
      then
      grep -q $default $bash_file
      if [ $? -eq 0 ]
        then
        # entry exists, but it's set to default value from this script
        echo $change_message
      fi
    fi
  else
    # variable entry doesn't exist
    if [ "$suppress_warning" != "true" ]
      then
      echo $change_message
    fi
    echo "" >> $bash_file
    echo "# $entry_comment" >> $bash_file
    echo "export $token=$default" >> $bash_file
    echo " " >> $bash_file
  fi
}

#make a profile file if it doesnt exist
mkdir -p dotfiles
bash_file=dotfiles/guest_bash_profile
touch $bash_file

add_comment_once "(c) 2014 Eyefodder, author: Paul Barnes-Hoggett"
add_comment_once "This code is licensed under MIT license (see LICENSE.txt for details)"
# entries to edit
echo "" >> $bash_file
echo "" >> $bash_file
add_comment_once "Edit the following values with your own values"

# ask for the growl password here
add_bash_entry GROWL_PASSWORD enter_growl_password "Growl password set in Growl > Preferences > Network"

echo "" >> $bash_file
add_comment_once "The following are variables set with sensible defaults"
add_comment_once "You can change them if you like, but make sure you know what they do..."
echo "" >> $bash_file
add_bash_entry CI_REPORTS ../reports/spec 'Location for generated ci reporter style test reports\n# this location is set to match the shared folder in the Vagrantfile' 'true'
add_bash_entry CI_COVERAGE_REPORTS ../reports/coverage 'Location for generated simplecov test reports' 'true'
add_bash_entry GENERATE_REPORTS true "set to 'true' to output ci reporter style test reports" 'true'
add_bash_entry GENERATE_COVERAGE_REPORTS true "set to 'true' to output simplecov reports." 'true'
add_bash_entry PORT 3000 "server port" 'true'


# Deal with entries overwritten each time
# ip address is re-written every time this script runs
# delete existing host IP entry

add_comment_once "The following entries are automatically generated"
add_comment_once "Do not edit unless you know what you are doing!"
add_comment_once "They are regenerated each time the virtual machine is rebooted"


sed -i '' '/HOST_IP/d' $bash_file
# this script enters some dumb spacing every time, so this deletes all blank space from teh end of the file
sed -i '' -e :a -e '/^\n*$/{$d;N;ba' -e '}' $bash_file
# grab current host IP
ipaddr=`ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d ' ' -f2`
# and write to file
echo "export HOST_IP=$ipaddr" >> $bash_file


