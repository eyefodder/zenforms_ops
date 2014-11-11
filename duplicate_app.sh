#!/usr/bin/env bash
# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)
function duplicate_repo(){


  gather_user_input
  tmp_folder="${appname}_tmp"
  old_repo=https://github.com/eyefodder/spex.git


  cd ../../
  clone_old_repo
  checkout_new_repo
  cd $appname
  if [ "$branch" != "master" ]
    then
    push_branch_and_switch_to_master
  fi

  remove_spex_app_readmes
  change_start_screen
  rename_spex_puppet_modules
  find_and_replace_spex
  rewrite_homepage
  commit_changes
  print_success_message

}
function commit_changes(){
  git add -A .
  git commit -m 'initial duplicate from spex repo'
  git push
}
function print_success_message(){
  echo "-----------------------------------------------------------"
  echo ""
  echo "Congrats, you're new app has been created at ../../$appname"
  echo ""
  if [ "$branch" != "master" ]
    then
    echo "You have one last step. Go into your repository settings and"
    echo "change your default branch from $branch to 'master'"
    echo "You can then delete the $branch branch if you want"
    echo ""
  fi
  echo ""
  echo "Now go 'vagrant up' some damage!"
}

function gather_user_input(){
  read -p 'enter app name (in snake_case) ' appname
  read -p 'enter app name (in CamelCase) ' appname_camel
  read -p 'enter new repo url ' new_repo
  echo "Available branches: "
  git branch -a
  read -p "enter branch you want to work on (enter 'master' if you're not sure) " branch

}
function rewrite_homepage(){
  homepage=app/views/static/home.html.erb
  echo "<h1>$appname_camel</h1>" > $homepage
  echo "<p>Duplicated from <a href='https://github.com/eyefodder/spex'>Eyefodder's Spex</a></p>" >> $homepage
  echo "<p>For more details, go <a href='http://eyefodder.com/2014/09/creating-duplicate-repository.html'>here</a></p>" >> $homepage
}
function push_branch_and_switch_to_master(){
  git push origin $branch:master
  git checkout master
}
function rename_spex_puppet_modules(){
  mv ops/puppet/modules/spex ops/puppet/modules/$appname
}
function find_and_replace_spex(){
  LC_ALL=C find . -path ./.git -prune -o -not -name 'duplicate_app.sh' -type f -exec sed -i '' -e "s/spex/$appname/g" {} \;
  LC_ALL=C find . -path ./.git -prune -o -not -name 'duplicate_app.sh' -type f -exec sed -i '' -e "s/spex/$appname_camel/g" {} \;
}
function change_start_screen(){
  # change vagrant up message
  sed -i '' -e  "s/spex app example(s)/$appname/g" ops/prep_rails_app.sh
  sed -i '' -e '/begin ascii header/,/end ascii header/d' ops/prep_rails_app.sh
}
function remove_spex_app_readmes(){
  rm -rf spex_branches
  # rewrite the README:
  readme=README.md
  echo $appname > $readme
  echo '============' >> $readme
}
function checkout_new_repo(){
  rm -rf $appname
  git clone $new_repo $appname

}

function clone_old_repo(){
  rm -rf $tmp_folder
  git clone --bare -b $branch --single-branch $old_repo $tmp_folder
  cd $tmp_folder
  git push --mirror $new_repo
  cd ..
  rm -rf $tmp_folder
}


duplicate_repo






