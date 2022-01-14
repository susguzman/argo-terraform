podTemplate(containers: [
    containerTemplate(
        name: 'terraform', 
        image: 'hashicorp/terraform:1.1.3', 
        command: 'sleep', 
        args: '30d'
        )
  ]) {
    node(POD_LABEL) {
        container('terraform') {
            stage('Git Clone') {
                git 'https://github.com/susguzman/argo-terraform.git'
            }
            stage('Init') {
                // Credentials
                withCredentials([file(credentialsId: 'gcp_key', variable: 'sa')]) {
                    sh 'cat "$sa" > TF_VAR_json_credential'
                    env.TF_VAR_json_credential = 'TF_VAR_json_credential'
                    env.GOOGLE_BACKEND_CREDENTIALS = 'TF_VAR_json_credential'
                }

                sh 'terraform init'
            }
            stage('Validate') {
                sh 'terraform validate'
            }
            stage('Plan') {
                sh 'terraform plan'
            }
            stage('Apply') {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
