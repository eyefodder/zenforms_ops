#!/usr/bin/env bash
# init

# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)
cd /app
echo 'installing app dependencies'
bundle install
echo 'creating databases (if needed)'
rake db:create
echo 'performing migrations'
rake db:migrate
echo 'seeding the db'
rake db:seed
# begin ascii header
echo '
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$                                                                            $$
$$                                                                            $$
$$               /$$$$$$$  /$$$$$$   /$$$$$$  /$$   /$$                       $$
$$              /$$_____/ /$$__  $$ /$$__  $$|  $$ /$$/                       $$
$$              |  $$$$$$ | $$  \ $$| $$$$$$$$ \  $$$$/                       $$
$$               \____  $$| $$  | $$| $$_____/  >$$  $$                       $$
$$               /$$$$$$$/| $$$$$$$/|  $$$$$$$ /$$/\  $$                      $$
$$              |_______/ | $$____/  \_______/|__/  \__/                      $$
$$                        | $$                                                $$
$$                        | $$                                                $$
$$                        |__/                                                $$
$$                                                                            $$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'
# end ascii header
echo '


$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$                                                                            $$
$$                                                                            $$
$$    This virtual machine is setup to run the zenforms app in its own        $$
$$    environment.                                                            $$
$$                                                                            $$
$$    If you are developing and trying out changes, you will need to run the  $$
$$    following command to keep things in synch:                              $$
$$                                                                            $$
$$                            "vagrant rsync-auto"                            $$
$$                                                                            $$
$$    The provisioning script has setup some environment variables on the     $$
$$    gueast machine that are in `ops/dotfiles/.bash_profile` You should      $$
$$    go ahead and take a look in there. Some values you will need to enter   $$
$$    yourself. You can do this now before you ssh into the machine.          $$
$$    If you want to make changes and ensure they are picked up in your       $$
$$    environment, simply type the following from within the ssh shell:       $$
$$                                                                            $$
$$                      source ~/.bash_profile                                $$
$$                                                                            $$
$$    You are now ready to start the app. In order to do this, you need to    $$
$$    jump into the virtual machine and start the app:                        $$
$$                                                                            $$
$$                            vagrant ssh                                     $$
$$                            cd /app                                         $$
$$                            rails s                                         $$
$$                                                                            $$
$$    When you have done that, the app will be accessible at                  $$
$$                                                                            $$
$$                            http://localhost:3001                           $$
$$                                                                            $$
$$      See! that was easy wasnt it?!!                                        $$
$$                                                                            $$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'

