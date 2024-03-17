# Alpine SSH Setup

Generates an overlay file that can be included with a new Alpine install to allow setting it up over SSH.

## Scope

Designed for use with the Raspberry Pi variant of Alpine Linux fround at https://www.alpinelinux.org/downloads/ . Assumes a wired network connection.

## Usage

Running the makefile generates a temporary SSH key pair and sets up the overlay file to recognize it:

```
git clone git@github.com:Densaugeo/alpine-ssh-setup.git
cd alpine-ssh-setup
make build
```

After this, the `ssh-setup.apkovl.tar.gz` can be copied to the root of an Alpine Linux SD card. When booted, the Raspberry Pi will run an SSH server that allows root login using the key. Note that password-based SSH login is disabled, because the default root password is blank. The private key can be passed to SSH like this:

```
ssh -i temporary-root-key root@IP_ADDRESS
```

You may be able to find the IP address by checking your router's DHCP client lease page (if you have access), or by using network mapping tools like nmap. If this is difficult on your netowrk, you could set a static IP in `overlay-content/etc/network/interfaces`.

You may wish to remove root access after setting another user up. If so, a script is provided at `/root/remove-root-login.sh`.

## Contents of Image

The `overlay-content` folder is used to build the overlay image. A brief explanation of the files within:

- `etc/apk/world` lists built-in Alpine packages that must be loaded to run OpenSSH.
- `etc/network/interfaces` contains a very basic wired network setup.
- `etc/runlevels` contains a selection of runlevels required by Alpine's init system to start OpenSSH. They are structured in the same way they are when created using `setup-alpine`. 
- `etc/ssh/ssh_config.d/allow_root.conf` applies SSH settings to allow root login.
- `root/.ssh/authorized_keys` is populated by the build process. A placeholder file is kept to retain correct permissions.
- `root/remove-root-login.sh` is a helper for removing root access after another user is set up.

## License

MIT
