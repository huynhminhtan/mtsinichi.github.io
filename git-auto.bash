DIR_GH_PAGE=gh-pages-mt-must-not-duplicate-12122312121232323

JEKYLL_ENV=production jekyll build

if [ ! -d "_site" ]; then
    echo "folder _site not exist"
    return
fi

# git add .
# git add *
# git commit -m "Update blog"
# git push origin mt-theme-v1

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
" >>../"$DIR_GH_PAGE"/git-step-1.sh
chmod a+x ../"$DIR_GH_PAGE"/git-step-1.sh
sh ../"$DIR_GH_PAGE"/git-step-1.sh

# # copy _site to $DIR_GH_PAGE
# cp -R ./_site/* ../"$DIR_GH_PAGE"
# echo "cp -R ./_site/* ../$DIR_GH_PAGE"

# # git 2 push to gh-pages branch
# touch ../"$DIR_GH_PAGE"/git-step-2.sh
# echo "
#     #!/bin/sh
#     git add .
#     git commit -m 'update content'
#     git checkout gh-pages
#     git push -u origin gh-pages 

# " >>../"$DIR_GH_PAGE"/git-step-2.sh
# chmod a+x ../"$DIR_GH_PAGE"/git-step-2.sh
# ../"$DIR_GH_PAGE"/git-step-2.sh



# cd ../"$DIR_GH_PAGE"
# git add .
# git commit -m "tmp"
# git checkout gh-pages
# echo "cp -R ./.git ../$DIR_GH_PAGE"

# # clean

# touch ../"$DIR_GH_PAGE"/git-upate.sh
# echo "
#     git checkout gh-pages
#     git pull
#     git add .
#     git commit -m 'update content'
#     git push -u origin gh-pages 
# " >>../"$DIR_GH_PAGE"/git-upate.sh

# # run
# chmod a+x ../"$DIR_GH_PAGE"/git-upate.sh
# source ../"$DIR_GH_PAGE"/git-upate.sh

# if [! -d "gh-page"]
# then
#     mkdir DIR_GH_PAGE
# else
#     rm -rf gh-page
# fi

# if [ -d ".git" ];
# then
#     git checkout gh-pages
#     git rm -rf .
#     git clean -fxd
# else
#     git init
#     git remote add origin https://github.com/huynhminhtan/mtsinichi.github.io.git
#     git config user.name "Huynh Minh Tan"
#     git config user.email "minhtan.itdev@gmail.com"
#     git pull
#     git rm -rf .
#     git clean -fxd
# fi

# # copy to gh-pages
# # cd ../master/
# if [ -d "_site" ]; then
#     cp -R ./_site/* ../gh-pages
#     cp -R ./.git ../gh-pages
# fi

# # # push to gh-pages branch
# cd ../gh-pages/
# git checkout gh-pages
# git add .
# git add *
# git commit -m "update blog"
# git push -u origin gh-pages

# cd ../master/
