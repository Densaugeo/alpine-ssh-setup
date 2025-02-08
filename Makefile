build: overlay-content temporary-root-key
	mkdir -p overlay-content/root/.ssh
	cat temporary-root-key.pub > overlay-content/root/.ssh/authorized_keys
	chmod 600 overlay-content/root/.ssh/authorized_keys
	
	cd overlay-content && tar -cvzf ../ssh-setup.apkovl.tar.gz .
	
	@echo
	@echo "After applying this overlay to an Alpine device, you can log into it using the following command"
	@echo "ssh -i $$(pwd)/temporary-root-key root@IP_ADDRESS"

temporary-root-key:
	ssh-keygen -t rsa -f temporary-root-key -C 'alpine-ssh-setup' -N ''
