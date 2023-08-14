#!/bin/bash

# Fetch and list the existing git tags
tags=$(git tag -l)

major=1
minor=0
version="v$major.$minor"
for tag in $tags; do
   if [[ $tag =~ ^v([0-9]+)\.([0-9]+)$ ]]; then
   	 major_tmp=${BASH_REMATCH[1]}
    	 minor_tmp=${BASH_REMATCH[2]}
	 if [[ $major_tmp -gt $major  ||  ( $major_tmp -eq $major  && $minor_tmp -gt $minor ) ||  ( $major_tmp -eq 1 && $minor_tmp -eq 0 ) ]] ; then
			((minor_tmp++))
     		 version="v$major_tmp.$minor_tmp"
      fi
   fi
done
echo $version
