FEDORA_RELEASE = 43
FEDORA_TARGET = fedora-$(FEDORA_RELEASE)-default_$(BUILD_DATE)_loong64

$(OUT_DIR)/$(FEDORA_TARGET).tar.xz: BUILD_DIR := $(BUILD_DIR)/fedora
$(OUT_DIR)/$(FEDORA_TARGET).tar.xz: | $(OUT_DIR)
	mkdir -pv $(BUILD_DIR)
	./build-loong64-lxc $(CURDIR)/images/fedora-loongarch64.yaml \
		$(BUILD_DIR) \
		-o image.release=$(FEDORA_RELEASE) \
		-o image.variant=default \
		-o image.architecture=loongarch64
	mv $(BUILD_DIR)/rootfs.tar.xz $@

$(OUT_DIR)/$(FEDORA_TARGET).aplinfo: $(OUT_DIR)/$(FEDORA_TARGET).tar.xz
	./gen-aplinfo fedora $(FEDORA_RELEASE) $(BUILD_DATE) $(OUT_DIR) $(FEDORA_TARGET).tar.xz $@

.PHONY: fedora
fedora: $(OUT_DIR)/$(FEDORA_TARGET).aplinfo
