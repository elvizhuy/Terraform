resource "aws_instance" "webserver" {
    ami = "ami-08e4b984abde34a4f"
    instance_type = "t2.micro"
    tags {
        name = "webserver"
        Description = "Web Server for Ubuntu"
    }
    user_data = <<- EOF
                #! /bin/bash
                apt update
                apt install -y nginx
                systemctl start nginx.service
                systemctl enable nginx.service
                EOF
}