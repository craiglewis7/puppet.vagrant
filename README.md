# puppet.vagrant
Automatic build and SSH configuration for Puppet

To ensure that things run smoothly please ensure that you have done the following: 

1. Created a new working private/public ssh key pair on your host machine
2. Added your public key to Github Private Repo
3. Tested that you have a valid SSH connection between host and Github (ssh -T git@github.com)
4. Enabled SSH agent forwarding

	touch ~/.ssh/config
	echo "Host 192.168.100.10" >> ~/.ssh/config
	echo "   ForwardAgent yes" >> ~/.ssh/config

5. Test SSH connection between Host and Github again
6. Verify that ssh-agent is running (echo "$SSH_AUTH_SOCK")
7. Key is visble to ssh-agent (ssh-add -L)