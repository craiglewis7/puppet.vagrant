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
 
    # Prevent annoying "stdin: is not a tty" errors from displaying during 'vagrant up'
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

 	  #Shell script to create new SSH user
    #config.vm.provision :shell, :path => "ssh.sh"

    end
	end
end