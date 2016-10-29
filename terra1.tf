provider "digitalocean" {
	token = "${var.do_token}"
}

resource "digitalocean_droplet" "web" {
	image = "ubuntu-14-04-x64"
	name = "web-1"
	region = "nyc2"
	size = "512mb"
	ssh_keys = [
		"${var.ssh_key_id}"
	]
	connection {
		user = "root"
		type = "ssh"
		key_file = "${var.pvt_key}"
		timeout = "2m"
	}
	provisioner "remote-exec" {
		inline = [
			"apt-get --assume-yes install git",
			"mkdir service",
			"cd service",
			"git clone http://github.com/chazgorman/geocode-service.git"
		]
	}
}
