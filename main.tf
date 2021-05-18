terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.16.0"
    }
  }
}

provider "linode" {
    token = var.token 
}

resource "linode_instance" "nrg_node" {
    label = "nrg-staking-node" 
    image = "linode/ubuntu20.04"
    region = var.region 
    type = "g6-standard-2"
    authorized_keys = [var.ssh_key]
    root_pass = var.root_pass
    
    provisioner "file" {
      source      = "./setup.sh"
      destination = "/tmp/setup.sh"

      connection {
	host = self.ip_address
        type = "ssh"
      	user = "root"
	private_key = file(var.private_key_path)
      }
    }

    provisioner "file" {
      source      = "./bootstrap_chain.sh"
      destination = "/tmp/bootstrap_chain.sh"

      connection {
        host = self.ip_address
        type = "ssh"
        user = "root"
        private_key = file(var.private_key_path)
      }
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/setup.sh",
	"chmod +x /tmp/bootstrap_chain.sh",
	"mkdir -p /home/nrgstaker/.energicore3/keystore",
	"/tmp/setup.sh"
      ]

      connection {
	host = self.ip_address
	type = "ssh"
 	user = "root"
	private_key = file(var.private_key_path)
      }
    }

    provisioner "file" {
      source="./keystore"
      destination="/home/nrgstaker/.energicore3/keystore/UTC--2021-05-02T12-51-02.131Z--94995fe33c263b71d21c03455457c3086cd83297"
	
      connection {
	host = self.ip_address
	type = "ssh"
	user = "root"
	private_key = file(var.private_key_path)
      }	
    }
}   


output "instance_ip" {
  value = linode_instance.nrg_node.ip_address
}
