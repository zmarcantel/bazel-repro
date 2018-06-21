# -*- mode: ruby -*-
# vi: set ft=ruby :
#

#===============================================================================
# VM settings
#===============================================================================

BOX_CPUS=1
BOX_RAM_MB=4096
BASE_BOX="ubuntu/bionic64"
BOX_NAME=File.basename(Dir.getwd)
BOX_CIDR_24="10.0.100"


#===============================================================================
# define install steps for various packages
#===============================================================================

$apt_base = <<-SCRIPT
    apt-get update
    apt-get upgrade -y
    apt-get install -y git
SCRIPT
def apt_install(vararg)
    return "apt-get install -y " + vararg
end


# c/c++

$install_cpp = apt_install("gcc clang")

# bazel

$install_bazel = <<-SCRIPT
    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
    curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
    sudo apt-get install -y bazel
SCRIPT

#===============================================================================
# specify __what__ is installed
#===============================================================================

$install_steps = {
    'base' => {:cmd => $apt_base, :priv => true},
    'cpp' => {:cmd => $install_cpp, :priv => true},
    'bazel' => {:cmd => $install_bazel, :priv => true},
}

$synced_folders = {
    "./bazel_clang" => "/#{BOX_NAME}/bazel_clang",
    "./proj" => "/#{BOX_NAME}/proj",
}


#===============================================================================
# run baby run
#===============================================================================

Vagrant.configure(2) do |config|
    config.vm.define BOX_NAME, autostart: true, primary: false do |node|
        node.vm.box = BASE_BOX
        node.vm.network :private_network, ip: "#{BOX_CIDR_24}.10"

        node.vm.provider "virtualbox" do |v|
            v.memory = BOX_RAM_MB
            v.cpus = BOX_CPUS
        end

        $synced_folders.each { |src, dest|
            node.vm.synced_folder src, dest
        }

        $install_steps.each { |name, desc|
            if ARGV[0] == "up" or ARGV[0] == "provision"
                puts "%s  ==>\n    %s" % [name, desc[:cmd].strip]
            end
            config.vm.provision "shell", inline: desc[:cmd], privileged: desc[:priv]
        }

    end # end node
end # end entry
