# HUYNH MINH TAN BLOG

Development theme Jekyll v1.

With main features:

- Hero feature image in posts.
- Table content.
- Show short description for posts.
- Count num of words, estimated time read post.
- Anchors heading.

Auto build and deploy to Github Pages:

```bash
./one-hit.bash
```

Setup custom domain via *CNAME*:

```text
minhtan.me
```

## Mini Cheat Sheet

Performs a one off build your site to *./_site* (by default).

```bash
jekyll build
```

Builds your site any time a source file changes and serves it locally.

```bash
jekyll serve
```

To specify a *production* environment in the build command, like this.

```bash
JEKYLL_ENV=production jekyll build
```

Show folder theme.

```bash
bundle show minima
```

Open the theme’s directory in Finder or Explorer.

```bash
xdg-open $(bundle show minima)
```

To update all gems in your project.

```bash
bundle update
```

## One Hit File

Content of *one-hit.bash*.

```bash
# folder temp for working, must not duplicate
DIR_GH_PAGE=gh-pages-mt-must-not-duplicate-12122312121232323

# push brach
GIT_BRANCH=mt-theme-v1

# build jekyll
JEKYLL_ENV=production jekyll build

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

cd ../master

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

cd ../master

# clean
rm -rf ../"$DIR_GH_PAGE"
echo "rm -rf ../$DIR_GH_PAGE"

# Happy !
```

## Notes

- Error: Github Page auto change custom domain after push code.
  - Add *CNAME* file fix problem.
  - https://github.com/travis-ci/travis-ci/issues/7538#issuecomment-290148354
  - https://help.github.com/en/articles/troubleshooting-custom-domains#github-repository-setup-errors
- Thời gian post của bài viết nếu lơn hơn thời điểm hiện tại, bài viết đó sẽ không hiển thị được ở trang chủ.
- Error: *Liquid Exception: Liquid syntax error (line 11): Tag '{%' was not properly terminated with regexp: /\%\}/ in /home/lap11410/Dropbox/workspace/college/mtsinichi/bloger/minhtanme/master/_posts/2019-08-18-log4j-with-java-example.markdown*
  - Bị lỗi khi trong nội dung markdown có các ký tự là `% }`.
  - https://stackoverflow.com/a/37602736/9488752
  - Giải quyết bằng cách thêm `{% raw %} trích đoạn code tại đây {% endraw %}`
