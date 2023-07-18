resource "aws_instance" "web" {
    ami = data.aws_ami.amzlinux2.id
    instance_type = "t2.micro"
    security_groups = [module.sg.sg_name]
    user_data = file("./web/server-script.sh")
    key_name = var.my_key
    
    tags = {
        Name = "Web Server"
    }
}

output "pub_ip" {
    value = module.eip.PublicIP
}

module "eip" {
    source = "../eip"
    instance_id = aws_instance.web.id
}

module "sg" {
    source = "../sg"
}

variable "my_key"{
  type = string
  default = "class31key"
}
