module "payroll" {
    source = "../modules/payroll-app"
    app_region = "ap-southeast-1"
    ami = "ami-08e4b984abde34a4f"
}