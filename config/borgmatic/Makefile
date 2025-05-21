SCRIPT_DIR := /usr/local/bin
CREDENTIALS_DIR := /etc

all:
	@echo "Creating symlink for scripts: $(SCRIPT_DIR)"
	@sudo ln -sf $(PWD)/mount-borg-smb.sh $(SCRIPT_DIR)/mount-borg-smb.sh
	@sudo ln -sf $(PWD)/unmount-borg-smb.sh $(SCRIPT_DIR)/unmount-borg-smb.sh

	@echo "Creating symlink for credentials: $(CREDENTIALS_DIR)"
	@sudo ln -sf $(PWD)/smb-credentials $(CREDENTIALS_DIR)/smb-credentials

clean:
	@echo "Removing symlinks"
	@sudo rm $(SCRIPT_DIR)/mount-borg-smb.sh
	@sudo rm $(SCRIPT_DIR)/unmount-borg-smb.sh
	@sudo rm $(CREDENTIALS_DIR)/smb-credentials

.PHONY: all clean
