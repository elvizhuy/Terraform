resource "aws_instance" "webserver" {
    ami = "ami-08e4b984abde34a4f"
    instance_type = "t2.micro"
    tags {
        name = "webserver"
        Description = "Web Server for Ubuntu"
    }

    provisioner "remote-exec" {
        inline = [ "sudo apt update",
                   "sudo apt install -y nginx",
                   "sudo systemctl enable nginx.service",
                   "sudo systemctl start nginx.service"
                 ]
    }

    key_name = aws_key_pair.web.id
    vpc_security_groups_ids = [ aws_security_group.ssh-access.id ]
}

resource "aws_security_group" "ssh-access" {
    name = "ssh-access"
    Description = "Allow SSH access from the internet"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "web" {
    public_key = file("/home/huynn/.ssh/web.pub)
}

output publicip {
    value = aws_instance.webserver.public_ip
}