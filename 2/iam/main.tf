module "Iam_dev_user" {
    source = "./modules/Iamuser"
    devuser ="1"
    name = "devuser"
}