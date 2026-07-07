ALT_RELEASE = Sisyphus
ALT_TARGET = alt-$(ALT_RELEASE)-default_$(BUILD_DATE)_loong64

$(OUT_DIR)/$(ALT_TARGET).tar.xz: BUILD_DIR := $(BUILD_DIR)/alt
$(OUT_DIR)/$(ALT_TARGET).tar.xz: | $(OUT_DIR)
	mkdir -pv $(BUILD_DIR)
	./build-loong64-lxc $(CURDIR)/lxc-ci/images/alt.yaml \
		$(BUILD_DIR) \
		-o image.release=$(ALT_RELEASE) \
		-o image.variant=default \
		-o image.architecture=loongarch64
	mv $(BUILD_DIR)/rootfs.tar.xz $@

$(OUT_DIR)/$(ALT_TARGET).aplinfo: $(OUT_DIR)/$(ALT_TARGET).tar.xz
	./gen-aplinfo alt $(ALT_RELEASE) $(BUILD_DATE) $(OUT_DIR) $(ALT_TARGET).tar.xz $@

.PHONY: alt
alt: $(OUT_DIR)/$(ALT_TARGET).aplinfo
