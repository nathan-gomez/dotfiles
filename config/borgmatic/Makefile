SCRIPT_DIR := /usr/local/bin
CREDENTIALS_DIR := /etc
CONFIG_DIR := /etc/borgmatic

all:
	@echo "Creating symlink for configuration: $(CONFIG_DIR)"
	@sudo ln -sf $(PWD)/config.yaml $(CONFIG_DIR)/config.yaml

	@echo "Creating symlink for scripts: $(SCRIPT_DIR)"
	@sudo ln -sf $(PWD)/mount-borg-smb.sh $(SCRIPT_DIR)/mount-borg-smb.sh
	@sudo ln -sf $(PWD)/unmount-borg-smb.sh $(SCRIPT_DIR)/unmount-borg-smb.sh

	@echo "Creating symlink for credentials: $(CREDENTIALS_DIR)"
	@sudo ln -sf $(PWD)/smb-credentials $(CREDENTIALS_DIR)/smb-credentials

clean:
	@echo "Removing symlinks"
	@sudo rm $(SCRIPT_DIR)/mount-borg-smb.sh $(SCRIPT_DIR)/unmount-borg-smb.sh
	@sudo rm $(CREDENTIALS_DIR)/smb-credentials
	@sudo rm $(CONFIG_DIR)/config.yaml

.PHONY: all clean
