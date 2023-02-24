data "template_file" "jenkins_credentials_data" {
  template = file("./templates/jenkins/credentials.xml")

  vars = {
    dockerhub_username = var.dockerhub_credentials.username
    dockerhub_password = var.dockerhub_credentials.password

    db_password = var.db_password
  }
}
