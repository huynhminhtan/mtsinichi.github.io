# folder temp for working, must not duplicate
DIR_GH_PAGE=gh-pages-mt-must-not-duplicate-12122312121232323

# folder working
DIR_MASTER=mtsinichi

# push brach
GIT_BRANCH=mt-theme-v1

# build jekyll
# JEKYLL_ENV=production jekyll build
bundle exec jekyll build JEKYLL_ENV=production

if [ ! -d "_site" ]; then
    echo "folder _site not exist"
    return
fi

# push current project to git
git add .
git add *
git commit -m "update source"
git push origin "$GIT_BRANCH"

# clear gh-pages
rm -rf ../"$DIR_GH_PAGE"
echo "rm -rf ../$DIR_GH_PAGE"

# create gh-pages
mkdir -p ../"$DIR_GH_PAGE"
echo "mkdir -p ../$DIR_GH_PAGE"

# copy .git and switch to branch gh-pages
cp -R ./.git ../"$DIR_GH_PAGE"
echo "cp -R ./.git ../$DIR_GH_PAGE"

# git 1 create new data
touch ../"$DIR_GH_PAGE"/git-step-1.sh
echo "#!/bin/sh
git add .
git commit -m 'tmp'
git checkout gh-pages
git pull
git rm -rf .
git clean -fxd
" >>../"$DIR_GH_PAGE"/git-step-1.sh
chmod a+x ../"$DIR_GH_PAGE"/git-step-1.sh
cd ../"$DIR_GH_PAGE"
./git-step-1.sh

cd ../"$DIR_MASTER"

# copy _site to $DIR_GH_PAGE
cp -R ./_site/* ../"$DIR_GH_PAGE"
echo "cp -R ./_site/* ../$DIR_GH_PAGE"

# git 2 push to gh-pages branch
touch ../"$DIR_GH_PAGE"/git-step-2.sh
echo "#!/bin/sh
git add .
git commit -m 'update content'
git checkout gh-pages
git push -u origin gh-pages 
" >>../"$DIR_GH_PAGE"/git-step-2.sh
chmod a+x ../"$DIR_GH_PAGE"/git-step-2.sh
cd ../"$DIR_GH_PAGE" 
./git-step-2.sh

cd ../"$DIR_MASTER"

# clean
rm -rf ../"$DIR_GH_PAGE"
echo "rm -rf ../$DIR_GH_PAGE"

# Happy !