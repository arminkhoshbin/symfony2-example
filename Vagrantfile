# -*- mode: ruby -*-
# vi: set ft=ruby :

# ----------------------------------------
# https://github.com/Divi/VagrantBootstrap
# ----------------------------------------

Vagrant.configure(2) do |config|
  # Core configurations
  # -------------------
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--name", "Symfony2-example"]
  end
  
  # Synced folders
  # --------------
  config.vm.synced_folder ".apache2_vhosts", "/etc/apache2/sites-available"
  

  # Forwarding ports
  # ----------------
  config.vm.network :forwarded_port, guest: 80, host: 8000

  # Running bootstrap
    # -----------------
    config.vm.provision :shell, :path => "init.sh"
    config.vm.provision "shell", inline: "php /vagrant/app/console server:start 0.0.0.0:8000", run: "always"
end