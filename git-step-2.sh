#!/bin/sh
git add .
git commit -m 'update content'
git checkout gh-pages
git push -u origin gh-pages 

