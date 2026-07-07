GENTOO_RELEASE = current
GENTOO_TARGET = gentoo-$(GENTOO_RELEASE)-openrc_$(BUILD_DATE)_loong64

$(OUT_DIR)/$(GENTOO_TARGET).tar.xz: | $(BUILD_DIR) $(OUT_DIR)
	./build-loong64-lxc $(CURDIR)/lxc-ci/images/gentoo.yaml \
		-o source.variant=openrc \
		-o image.variant=openrc \
		-o image.architecture=loongarch64
	mv $(BUILD_DIR)/rootfs.tar.xz $@

$(OUT_DIR)/$(GENTOO_TARGET).aplinfo: $(OUT_DIR)/$(GENTOO_TARGET).tar.xz
	./gen-aplinfo gentoo $(GENTOO_RELEASE) $(BUILD_DATE) $(OUT_DIR) $(GENTOO_TARGET).tar.xz $@

.PHONY: gentoo
gentoo: $(OUT_DIR)/$(GENTOO_TARGET).aplinfo
