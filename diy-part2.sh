#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.50.2/g' package/base-files/files/bin/config_generate #修改默认ip
sed -i 's/OpenWrt/VPN/g' package/base-files/files/bin/config_generate #修改主机名
sed -i '12d' package/base-files/files/etc/board.d/99-default_network
sed -i '159a\				set network.$1.gateway='"'192.168.50.1'" package/base-files/files/bin/config_generate #修改默认网关
sed -i '160a\				set network.$1.dns='"'8.8.8.8 223.5.5.5'" package/base-files/files/bin/config_generate #修改默认DNS
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile   # 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile   # 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-ssl-nginx/Makefile   # 选择argon为默认主题
rm -rf  feeds/luci/themes/luci-theme-argon   # 删除自带argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon   # 替换新版argon
sed -i '5a\msgid "Compiler author"' feeds/luci/modules/luci-base/po/zh-cn/base.po #添加汉化
sed -i '6a\msgstr "编译作者"' feeds/luci/modules/luci-base/po/zh-cn/base.po #添加汉化
sed -i '7a \\' feeds/luci/modules/luci-base/po/zh-cn/base.po #添加汉化
sed -i '8a\msgid "Firmware Update"' feeds/luci/modules/luci-base/po/zh-cn/base.po #添加汉化
sed -i '9a\msgstr "固件更新"' feeds/luci/modules/luci-base/po/zh-cn/base.po #添加汉化
sed -i '10a \\' feeds/luci/modules/luci-base/po/zh-cn/base.po #添加汉化
sed -i 's/PKG_HASH.*/PKG_HASH:=skip/' feeds/packages/utils/containerd/Makefile #修复依赖
