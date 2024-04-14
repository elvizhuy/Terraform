variable "users" {
    type = list(string)
    default = [ "terraform" ]
}

variable "groups" {
    type = list(string)
    default = [ "terra-group" ]
}

variable "terra-group_policy" {
    default = "terra-group_policy"
}

variable "full-access-policy-attachment" {
    default = "full-access-policy-attachment"
}