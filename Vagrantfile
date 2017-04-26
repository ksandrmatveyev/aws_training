Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	
	config.vm.define "gateway" do |gateway|
		gateway.vm.hostname="gateway"
		gateway.vm.network "forwarded_port", guest: 22, host: 2221, id: "ssh", host_ip: "127.0.0.1"
		gateway.vm.network "private_network", ip:"192.168.10.50", mask:"255.255.255.0",
    virtualbox__intnet: "intnet1", auto_config: false
	gateway.vm.network "private_network", ip:"10.0.0.45", mask:"255.255.255.0",
    virtualbox__intnet: "intnet2", auto_config: false
	end

	config.vm.define "app1" do |app1|
		app1.vm.hostname="app1"
		app1.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", host_ip: "127.0.0.1"
		app1.vm.network "private_network", ip:"192.168.10.51", mask:"255.255.255.0",
    virtualbox__intnet: "intnet1", auto_config: false
	end
	config.vm.define "app2" do |app2|
		app2.vm.hostname="app2"
		app2.vm.network "forwarded_port", guest: 22, host: 2223, id: "ssh", host_ip: "127.0.0.1"
		app2.vm.network "private_network", ip:"10.0.0.46", mask:"255.255.255.0",
    virtualbox__intnet: "intnet2", auto_config: false
	end
end
