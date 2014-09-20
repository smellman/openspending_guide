#!/bin/bash

targets=('en')
output=output
if [ ! -d $output ]
then
  mkdir $output
fi

pandoc_opt='-s -t html5'
for target in $targets
do
  target_dir=$output/$target
  if [ ! -d $target_dir ]
  then
    mkdir $target_dir
  fi
  index=$target/index.md
  pandoc $pandoc_opt $index -o $target_dir/index.html
  markdowns=`find $target -name "*.md" ! -name "index.md"`
  for markdown in $markdowns
  do
    output_dir=$target_dir/`basename -s .md $markdown`
    if [ ! -d $output_dir ]
    then
      mkdir $output_dir
    fi
    pandoc $pandoc_opt $markdown -o $output_dir/index.html
  done
done
