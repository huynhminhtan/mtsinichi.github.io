git add .
git add *
git commit -m "Update blog"
git push origin master

# cd gh-pages
cd ../gh-pages/
git checkout gh-pages
if [ -d ".git" ]; then
    git rm -rf .
    git clean -fxd
fi

# copy to gh-pages
cd ../master/
if [ -d "_site" ]; then
    cp -R ./_site/* ../gh-pages
fi

# push to gh-pages branch
cd ../gh-pages/
git checkout gh-pages
git add .
git commit -m "Update blog"
git push -u origin gh-pages

cd ../master/