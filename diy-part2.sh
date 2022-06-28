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
sed -i 's/192.168.1.1/192.168.50.3/g' package/base-files/files/bin/config_generate #修改默认ip
# sed -i 's#root::0:0:99999:7:::#root:$1$7JPuibGo$SXT/JvF/gcnPhx6TwvDbm.:19171:0:99999:7:::#g' package/base-files/files/etc/shadow #修改默认密码
sed -i "/uci commit system/i\uci set system.@system[0].hostname='VPN'" package/lean/default-settings/files/zzz-default-settings #修改主机名称
sed -i "s/hostname='OpenWrt'/hostname='VPN'/g" ./package/base-files/files/bin/config_generate #修改主机名称
sed -i '12d' package/base-files/files/etc/board.d/99-default_network #去掉WAN接口
sed -i '30,32d' package/network/services/dnsmasq/files/dhcp.conf #删除默认DHCP规则
sed -i '29a\	option ignore	1' package/network/services/dnsmasq/files/dhcp.conf #设置默认忽略LAN口DHCP
sed -i '16,23d' package/network/config/firewall/files/firewall.config #删除防火墙WAN口规则
sed -i '18,$d' package/network/config/firewall/files/firewall.config #删除防火墙默认规则
sed -i '/<tr><td width="33%"><%:CPU usage/a <tr><td width="33%"><%:Compiler author%></td><td>Tommy.Goo</td></tr>' package/lean/autocore/files/x86/index.htm #添加编译作者
sed -i '159a\				set network.$1.gateway='"'192.168.50.1'" package/base-files/files/bin/config_generate #修改默认网关
sed -i '160a\				set network.$1.broadcast='"'192.168.50.255'" package/base-files/files/bin/config_generate #修改广播域
sed -i '161a\				set network.$1.dns='"'8.8.8.8 223.5.5.5'" package/base-files/files/bin/config_generate #修改默认DNS
sed -i '162a\				set network.$1.delegate='"'0'" package/base-files/files/bin/config_generate #禁用IPV6分配长度
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
