DIRNAME=$(basename "$(pwd)");
SHORTREPOKEY=$(echo "$DIRNAME" | tr '[:upper:]' '[:lower:]');
access_token='${{ secrets.SYNCTOKEN }}';
wiki_folder='${{ github.event.repository.name }}';

if [[ ! $(grep -R "idea" .gitignore ) ]] then;
cat << EOL > .gitignore
# Covers JetBrains IDEs: IntelliJ, RubyMine, PhpStorm, AppCode, PyCharm, CLion, Android Studio, WebStorm and Rider
# Reference: https://intellij-support.jetbrains.com/hc/en-us/articles/206544839
.MS_Dos
# User-specific stuff
.idea/**/workspace.xml
.idea/**/tasks.xml
.idea/**/usage.statistics.xml
.idea/**/dictionaries
.idea/**/shelf

# AWS User-specific
.idea/**/aws.xml

# Generated files
.idea/**/contentModel.xml

# Sensitive or high-churn files
.idea/**/dataSources/
.idea/**/dataSources.ids
.idea/**/dataSources.local.xml
.idea/**/sqlDataSources.xml
.idea/**/dynamic.xml
.idea/**/uiDesigner.xml
.idea/**/dbnavigator.xml

# Gradle
.idea/**/gradle.xml
.idea/**/libraries

# Gradle and Maven with auto-import
# When using Gradle or Maven with auto-import, you should exclude module files,
# since they will be recreated, and may cause churn.  Uncomment if using
# auto-import.
# .idea/artifacts
# .idea/compiler.xml
# .idea/jarRepositories.xml
# .idea/modules.xml
# .idea/*.iml
# .idea/modules
# *.iml
# *.ipr

# CMake
cmake-build-*/

# Mongo Explorer plugin
.idea/**/mongoSettings.xml

# File-based project format
*.iws

# IntelliJ
out/

# mpeltonen/sbt-idea plugin
.idea_modules/

# JIRA plugin
atlassian-ide-plugin.xml

# Cursive Clojure plugin
.idea/replstate.xml

# SonarLint plugin
.idea/sonarlint/

# Crashlytics plugin (for Android Studio and IntelliJ)
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties

# Editor-based Rest Client
.idea/httpRequests

# Android studio 3.1+ serialized cache file
.idea/caches/build_file_checksums.ser
EOL
fi


# make folder and file so wiki is autoupdated
[[ ! -d "./.github/workflows/ " ]] && mkdir -p ./.github/workflows/

cat << EOL >  ./.github/workflows/updatewiki.yml
---
on:
  push:
    branches:
      - "master"
  pull_request:
    branches:
      - "master"
name: Update Wiki
jobs:
  udpate-wiki:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: Wiki Sync
        uses: LillyWho/ghaction-wiki-sync-custom@v1.0
        with:
          username: 14paxton
          access_token: $access_token
          wiki_folder: $wiki_folder
          commit_message: "wikisync"
          commit_username: "14paxton"
          commit_email:    "26972590+14paxton@users.noreply.github.com "
EOL

# make folder for wiki to update from and move markdown files to new folder
[[ -d ./wiki/ ]] && mv wiki "$DIRNAME"
[[ ! -d ./"$DIRNAME" ]] && mkdir -p "$DIRNAME"

if [[ -n *.md(#qN) ]]; then
  mv *.md ./"$DIRNAME"/
fi

cd "$DIRNAME"

# create frontmatter index file for side nav to key on
[[ -d ./$DIRNAME/ ]] && cd "$DIRNAME"
#[[ ! -f ./$DIRNAME ]] &&  touch "$DIRNAME".md
cat << EOL >  "$DIRNAME".md
---
title: $DIRNAME
layout: default
permalink: $DIRNAME/
category: $DIRNAME
has_children: true
share: true
shortRepo:

  - $SHORTREPOKEY
  - default
---

# [REPO](https://github.com/14paxton/$DIRNAME)
EOL

# get files and add frontmatter for side nav tree
for st in $(find "$(PWD)" -type f); do
FILENAME=${$(basename "$st")%.*}
PERMALINK=$DIRNAME/$FILENAME

if [[ "$FILENAME" != "$DIRNAME" && ! $(grep -R "has_children" "$FILENAME".md) ]] then;
ex "$st" << eof
1 insert
---
title: $FILENAME
permalink: $PERMALINK
category:  $DIRNAME
parent:   $DIRNAME
layout: default
has_children: false
share: true
shortRepo:
  - $SHORTREPOKEY
  - default
---


<br/>

<details markdown="block">
<summary>
Table of contents
</summary>
{: .text-delta }
1. TOC
{:toc}
</details>

<br/>

***

<br/>

.
xit
eof
fi
done;