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
            stage('Configuration') {
                // Credentials
                withCredentials([file(credentialsId: 'gcp_key', variable: 'sa')]) {
                    sh "cat $sa > TF_VAR_json_credential"
                }

                withCredentials([string(credentialsId: 'art_repo', variable: 'repo'), usernameColonPassword(credentialsId: 'art_creds', variable: 'creds')]) {
                    sh 'curl -u "$creds" -T build/hello-world-0.1.0.tgz "$repo"'
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
