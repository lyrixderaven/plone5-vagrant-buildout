# -*- mode: ruby -*-
# vi: set ft=ruby :

UI_URL = "https://launchpad.net/plone/5.0/5.0/+download/Plone-5.0-UnifiedInstaller.tgz"
UI_OPTIONS = "standalone --password=admin"

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty32"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"

    config.vm.network :forwarded_port, guest: 8080, host: 8080

    config.vm.synced_folder ".", "/home/vagrant/plone5"

    # HOSTMANAGER PLUGIN CONFIG

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    config.vm.provider "virtualbox" do |vb|
        #vb.customize ["modifyvm", :id, "--memory", "1024"]
        vb.customize ["modifyvm", :id, "--name", "plonedev_manual" ]
    end

    # Run apt-get update as a separate step in order to avoid
    # package install errors
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "aptgetupdate.pp"
    end

    # ensure we have the packages we need
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "plone.pp"
    end

    # Shell provisioner to bootstrap the Plone environment, etc.
    config.vm.provision "bootstrap", type: "shell", path: "manifests/bootstrap.sh", privileged: false

    # NODE CONFIG for Hostmanager
    config.vm.define 'plone5.site' do |node|
        node.vm.hostname = 'plone5.site.vm'
        node.vm.network :private_network, ip: '192.168.42.2'
        node.hostmanager.aliases  = %w( plone5.alias.vm )
    end
end
