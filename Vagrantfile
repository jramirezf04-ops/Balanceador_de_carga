Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  # Limito la RAM a 512MB por máquina para no saturar el ordenador
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
    vb.cpus = 1
  end

  # ==========================================
  # CAPA 1: BALANCEADOR DE CARGA (PÚBLICA)
  # ==========================================
  config.vm.define "balanceador" do |bal|
    bal.vm.hostname = "JavierRamirezBalanceador"
    bal.vm.network "private_network", ip: "192.168.10.10", virtualbox__intnet: "red_capa2"
    bal.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    bal.vm.network "forwarded_port", guest: 443, host: 8443, host_ip: "127.0.0.1"
    bal.vm.provision "shell", path: "instalar_balanceador.sh"
  end

  # ==========================================
  # CAPA 2: SERVIDORES WEB (PRIVADA)
  # ==========================================
  config.vm.define "web1" do |w1|
    w1.vm.hostname = "JavierRamirezWeb1"
    w1.vm.network "private_network", ip: "192.168.10.11", virtualbox__intnet: "red_capa2"
    w1.vm.network "private_network", ip: "192.168.20.11", virtualbox__intnet: "red_capa3"
    w1.vm.provision "shell", path: "instalar_web.sh"
  end

  config.vm.define "web2" do |w2|
    w2.vm.hostname = "JavierRamirezWeb2"
    w2.vm.network "private_network", ip: "192.168.10.12", virtualbox__intnet: "red_capa2"
    w2.vm.network "private_network", ip: "192.168.20.12", virtualbox__intnet: "red_capa3"
    w2.vm.provision "shell", path: "instalar_web.sh"
  end

  # ==========================================
  # CAPA 3: BASE DE DATOS (PRIVADA AISLADA)
  # ==========================================
  config.vm.define "bbdd" do |db|
    db.vm.hostname = "JavierRamirezBBDD"
    db.vm.network "private_network", ip: "192.168.20.20", virtualbox__intnet: "red_capa3"
    db.vm.provision "shell", path: "instalar_db.sh"
  end
end