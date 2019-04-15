include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for pymultimonaprs
LUCI_DEPENDS:=+pymultimonaprs

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
