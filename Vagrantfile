# -*- mode: ruby -*-
# vi: set ft=ruby :
 
# Builds Puppet Master and Puppet Agent Node using own Private SSH keys and Configurations. 
# Author: Craig Lewis
# Version: 1.0

#Specifies the Vagrant API Version to use
VAGRANT_API_VERSION = "2"

# Specify minimum Vagrant API version
Vagrant.require_version ">= 1.6.0"

#Specify that you require YAML module
require 'yaml'

#Server YAML config file to load
servers = YAML.load_file("server_config.yml")
#ssh = YAML.load_file("ssh_config.yml")
 
Vagrant.configure(VAGRANT_API_VERSION) do |config|
 
  servers.each do |servers|
 
    config.vm.define servers["name"] do |machine|
 
    machine.vm.box = servers["box"]
    machine.vm.box_url = servers["url"]
    machine.vm.hostname = servers["hostname"]
    machine.vm.network "forwarded_port", guest: 22, host: servers["ssh"], id: 'ssh'
    machine.vm.network :private_network, ip: servers["ip"]

    machine.vm.provider :virtualbox do |vb|
      vb.name = servers["name"]
      vb.memory = servers["memory"]
      vb.cpus = servers["cpus"]
      end

    #SSH Forwarding Agent Setup
    config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
    config.ssh.forward_agent = true

    #Add github to the list of known_hosts
    config.vm.provision :shell do |shell|
    shell.inline = "mkdir $1 && touch $2 && ssh-keyscan -H $3 >> $2 && chmod 600 $2"
    shell.args = %q{/root/.ssh /root/.ssh/known_hosts "github.com"}
 
    # Prevent annoying "stdin: is not a tty" errors from displaying during 'vagrant up'
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

 	  #Shell script to create new SSH user
    config.vm.provision :shell, :path => "ssh.sh"
    
    #Fix for SSH_AUTH_SOCK error in /etc/sudoers.d/
    #config.vm.provision :shell do |shell|
    #shell.inline = "touch $1 && chmod 0440 $1 && echo $2 > $1"
    #shell.args = %q{/etc/sudoers.d/root_ssh_agent "Defaults env_keep += \"SSH_AUTH_SOCK\""}
    end
	end
 
  end
 
end