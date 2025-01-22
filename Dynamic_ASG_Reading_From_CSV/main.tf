# Read the csv file
locals {
  csv_file_path       = "${path.module}/autoscaling.csv"
  scaling_information = csvdecode(file(local.csv_file_path))
  min_size            = tonumber(local.scaling_information[0]["min_size"])
  max_size            = tonumber(local.scaling_information[0]["max_size"])
  desired_capacity    = tonumber(local.scaling_information[0]["desired_capacity"])
  scale_in_threshold  = tonumber(local.scaling_information[0]["scale_in_threshold"])
  scale_up_threshold  = tonumber(local.scaling_information[0]["scale_up_threshold"])
  scale_in_adjustment = tonumber(local.scaling_information[0]["scale_in_adjustment"])
  scale_up_adjustment = tonumber(local.scaling_information[0]["scale_up_adjustment"])
}