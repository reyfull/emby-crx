#!/bin/bash

# 创建emby-crx目录并下载所需文件
# wget https://raw.githubusercontent.com/reyfull/emby-crx/master/emby_4.8.0.55/index.html -P /
rm -rf emby-crx
mkdir -p emby-crx
rm -rf /system/dashboard-ui/css/icons
mkdir -p /system/dashboard-ui/css/icons
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/embyLaunchPotplayer.js -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/style.css -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/common-utils.js -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/jquery-3.6.0.min.js -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/md5.min.js -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/config.js -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/main.js -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-Copy.webp -P css/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-DandanPlay.webp -P css/
# 读取index.html文件内容
content=$(cat index.html)

# 检查index.html是否包含emby-crx
if grep -q "emby-crx" index.html; then
    echo "Index.html already contains emby-crx, skipping insertion."
else
    # 定义要插入的代码
    code='<link rel="stylesheet" id="theme-css" href="emby-crx/style.css" type="text/css" media="all" />\n<script src="emby-crx/common-utils.js"></script>\n<script src="emby-crx/jquery-3.6.0.min.js"></script>\n<script src="emby-crx/md5.min.js"></script>\n<script src="emby-crx/config.js"></script>\n<script src="emby-crx/main.js"></script>\n<script src="emby-crx/embyLaunchPotplayer.js"></script>'

    # 在</head>之前插入代码
    new_content=$(echo -e "${content/<\/head>/$code<\/head>}")

    # 将新内容写入index.html文件
    echo -e "$new_content" > index.html
fi
