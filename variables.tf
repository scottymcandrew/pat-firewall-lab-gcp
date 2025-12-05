variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west2"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "europe-west2-a"
}

variable "blue_server_ip" {
  description = "Internal IP for blue web server"
  type        = string
  default     = "10.1.1.3"
}

variable "red_server_ip" {
  description = "Internal IP for red web server"
  type        = string
  default     = "10.1.2.3"
}

variable "pat_blue_nic_ip" {
  description = "PAT firewall IP on blue subnet"
  type        = string
  default     = "10.1.1.2"
}

variable "pat_red_nic_ip" {
  description = "PAT firewall IP on red subnet"
  type        = string
  default     = "10.1.2.2"
}

variable "blue_port" {
  description = "External port for blue server"
  type        = number
  default     = 8081
}

variable "red_port" {
  description = "External port for red server"
  type        = number
  default     = 8082
}
