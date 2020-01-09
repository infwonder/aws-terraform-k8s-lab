output "terra01-ip" {
    value = aws_instance.terra01.public_ip
}

output "terra02-ip" {
    value = aws_instance.terra02.public_ip
}

output "terra03-ip" {
    value = aws_instance.terra03.public_ip
}
