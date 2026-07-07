OPENEULER_RELEASE = 24.03
OPENEULER_TARGET = openeuler-$(OPENEULER_RELEASE)-default_$(BUILD_DATE)_loong64

$(OUT_DIR)/$(OPENEULER_TARGET).tar.xz: | $(BUILD_DIR) $(OUT_DIR)
	./build-loong64-lxc $(CURDIR)/lxc-ci/images/openeuler.yaml \
		-o image.release=$(OPENEULER_RELEASE) \
		-o image.variant=default \
		-o image.architecture=loongarch64
	mv $(BUILD_DIR)/rootfs.tar.xz $@

$(OUT_DIR)/$(OPENEULER_TARGET).aplinfo: $(OUT_DIR)/$(OPENEULER_TARGET).tar.xz
	./gen-aplinfo openeuler $(OPENEULER_RELEASE) $(BUILD_DATE) $(OUT_DIR) $(OPENEULER_TARGET).tar.xz $@

.PHONY: openeuler
openeuler: $(OUT_DIR)/$(OPENEULER_TARGET).aplinfo
