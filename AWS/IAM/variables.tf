variable "users" {
    type = list(string)
    default = [ "terraform" ]
}

variable "groups" {
    type = list(string)
    default = [ "terra-group" ]
}

variable "terra-group_policy" {
    name = "terra-group_policy"
}

variable "full-access-policy-attachment" {
    name = "full-access-policy-attachment"
}