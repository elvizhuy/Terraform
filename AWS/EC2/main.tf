resource "aws_instance" "webserver" {
    ami = ""
    instance_type = "t2.micro"
    tags {
        name = "webserver"
        Description = "Web Server for Amazon Linux"
    }
    user_data = <<- EOF
                #! /bin/bash
                yum update
                yum install -y nginx
                systemctl start nginx.service
                systemctl enable nginx.service
                EOF
}