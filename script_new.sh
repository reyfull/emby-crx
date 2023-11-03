#!/bin/bash

# 创建emby-crx目录并下载所需文件
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
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-Copy.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-DandanPlay.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-IINA.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-infuse.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-MPV.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-MXPlayer.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-NPlayer.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-PotPlayer.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-StellarPlayer.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/icon-VLC.webp -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/PeoplePlus.js -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/ede.user.js -P emby-crx/
wget https://raw.githubusercontent.com/reyfull/emby-crx/master/danmaku.min.js -P emby-crx/

# 读取index.html文件内容
content=$(cat index.html)

# 检查index.html是否包含emby-crx
if grep -q "emby-crx" index.html; then
    echo "Index.html already contains emby-crx, skipping insertion."
else
    # 定义要插入的代码
    code='<link rel="stylesheet" id="theme-css" href="emby-crx/style.css" type="text/css" media="all" />\n<script src="emby-crx/common-utils.js"></script>\n<script src="emby-crx/jquery-3.6.0.min.js"></script>\n<script src="emby-crx/md5.min.js"></script>\n<script src="emby-crx/config.js"></script>\n<script src="emby-crx/main.js"></script>\n<script src="emby-crx/embyLaunchPotplayer.js">\n<script src="emby-crx/ede.user.js">\n<script src="emby-crx/danmaku.min.js">\n<script src="emby-crx/PeoplePlus.js"></script>'

    # 在</head>之前插入代码
    new_content=$(echo -e "${content/<\/head>/$code<\/head>}")

    # 将新内容写入index.html文件
    echo -e "$new_content" > index.html
fi
