**DEMO: SET UP A JENKINS CI/CD PIPELINE FOR A JAVA-BASED APPLICATION USING MAVEN, SONARQUBE, ARGOCD, AND KUBERNETES**

![Jenkins_endtoend_CICD](https://github.com/user-attachments/assets/bf3c75c4-81fc-4b6b-b0cd-0bd01654a3d7)

The aim of this project is to demonstrate the creation and deployment of a robust CI/CD pipeline for a Java-based application - a Spring-Boot Application. Utilizing Jenkins, the pipeline integrates key DevOps tools such as Maven for build automation, SonarQube for static code analysis, Docker for containerization, ArgoCD for continuous delivery, and Kubernetes for orchestration. 

Use of Spring-Boot Application: _A Spring Boot app is a Java-based application framework designed for rapid development, offering pre-configured settings and dependencies to simplify building and deploying standalone, production-grade applications._

This project showcases the seamless automation of code build, test, and deployment processes, ensuring efficient and consistent delivery of high-quality software.

**MAJOR PREREQUISITES**

1. Ensure Java application code & associated files are prepared & ready for deployment on the K8S cluster.

2. Ensure AWS CLI and kubectl are configured on your terminal.

**CONTINUOUS INTEGRATION (CI) STAGE**

The purpose of CI is to automate the process of integrating code changes from multiple contributors into a shared repository, ensuring that the codebase is consistently tested and verified.

**STEPS**

(A) INSTALL JENKINS PLUGINS

1. Create an EC2 Instance on your AWS console - Ensure the instance type selected is large enough to handle the robust resources.

2. Authenticate and connect your EC2 instance on your terminal, and log in as root user.

3. Jenkins' default inbound traffic port is '8080', so in the security group configuration of the EC2 instance, an inbound rule must be created to allow traffic on port 8080.

4. Run the following address on your browser: _http://EC2PublicIpAddress:8080_

5. Retrieve Jenkins' password details from your terminal and install the necessary plugins on the Jenkins UI.

(B) CREATE A JENKINS PIPELINE

1. Create your Docker file and store in your preferred directory in your remote repository (e.g. GitHub)

2. On Jenkins' UI, select 'new item', then 'pipeline option'

3. At this point, you can either create a Jenkins file from scratch on the Groovy pipeline script window OR import your pipeline script from an SCM. In this case, the latter was done, as the Jenkinsfile was created and stored at the root of my app folder, within my GitHub repository.

4. Create pipeline - Jenkins begins to trigger build.

(C) INSTALL PLUGINS - DOCKER, MAVEN, SONARQUBE

1. Jenkins Dashboard ➔ Manage Jenkins ➔ Manage Plugins ➔ Available ➔ Search for Plugin ➔ Docker Pipeline Plugin ➔ Install without restart

2. Jenkins Dashboard ➔ Manage Jenkins ➔ Manage Plugins ➔ Available ➔ Search for Plugin ➔ Maven Integration Plugin ➔ Install without restart

_Maven is used in this project because it is a build automation tool primarily used for Java-based applications._

3. Jenkins Dashboard ➔ Manage Jenkins ➔ Manage Plugins ➔ Available ➔ Search for Plugin ➔ SonarQube Scanner Plugin ➔ Install without restart

_SonarQube is used in this project because it is used for analysing and maintaining code quality of the application._

4. Configure a Sonar Server locally. Locate commands on official documentations - add user, switch to user, download the sonar binary, unzip file, and set permissions, locate files downloaded and start sonar server.

5. Access your SonarQube page. SonarQube's default inbound traffic port is '9000', so in the security group configuration of the EC2 instance, an inbound rule must be created to allow traffic on port 9000. Run the following address on your browser: _http://EC2PublicIpAddress:9000_

6. Sign in - Username - 'admin', Password - 'admin'. Update password and store somewhere.


(D) SET UP CREDENTIALS TO AUTHENTICATE WITH JENKINS

1. Authenticate Sonar with Jenkins.

On Sonar's UI, Administrator ➔ My Account ➔ Security ➔ Generate new token ➔ Copy token.

On Jenkins: Dashboard ➔ Manage Jenkins ➔ Security ➔ Manage Credentials ➔ System ➔ Global Credentials ➔ Add Credentials ➔ Select Secret Text option ➔ Paste the copied SonarQube token as password ➔ Save with a token name that aligns as in your Jenkins File.

2. Authenticate GitHub with Jenkins.

On GitHub's UI: Profile Picture ➔ Settings ➔ Developer settings ➔ Personal access tokens ➔ Generate new token ➔ Copy token.

On Jenkins: Dashboard ➔ Manage Jenkins ➔ Security ➔ Manage Credentials ➔ System ➔ Global Credentials ➔ Add Credentials ➔ Select Secret Text option ➔ Paste the copied GitHub token as password ➔ Save with a token name that aligns as in your Jenkins File.

3. Authenticate Docker with Jenkins.

On Jenkins: Dashboard ➔ Manage Jenkins ➔ Security ➔ Manage Credentials ➔ System ➔ Global Credentials ➔ Add Credentials ➔ Select Secret Text option ➔ Paste your DockerHub password as password ➔ Save with a token name that aligns as in your Jenkins File.


(E) DOCKER AGENT CONFIGURATION

1. Ensure your Docker Desktop is running fine in the background. Install Docker on your EC2 instance in your terminal.

2. Grant permissions for Jenkins user and Ubuntu user to Docker Daemon.

3. Restart Jenkins
   
_http://EC2PublicIpAddress:8080/restart_

4. Login to Jenkins again.


**CONTINUOUS DELIVERY/DEPLOYMENT (CD) STAGE**

The purpose of CD is to automate the delivery of validated code changes to a staging or production environment, ensuring that the software can be released reliably and frequently.

**STEPS**

(F) CONFIGURE A KUBERNETES CLUSTER & ARGOCD USING OPERATORS

1. Install a Minikube K8S cluster on your terminal.

_A local K8S cluster is used in this demo because it's a non-production envvironment, but only for testing and demo purposes. Minikube is used to this purpose. It is a lightweight tool for non-production purposes, such as development, testing, demos, all involved in the creation of a local K8S cluster._

2. Install ArgoCD Operator from the official operators hub - 'https://www.operatorhub.io'

_ArgoCD is primarily used to provide continuous delivery and deployment (CD) for apps on K8S. It automates the deployment of an application from a VCS (e.g. Git), to a K8S cluster._

_K8S Operators are custom controllers that manage the lifecycle of complex apps on K8S. They provide automated tasks such as self-healing, auto-scaling capabilities, and aid in the seamless integration and increased reliability of apps._

3. Follow the commands given on the hub and configure on your terminal.

4. Configure an ArgoCD Controller on your terminal.

_ArgoCD controllers manage the deployment and synchronization of application configurations to Kubernetes clusters, ensuring the desired state is maintained._

From the ArgoCD official documentation, copy the ArgoCD operator usage basics (manifest); create a new file in the directory of your cluster, for instance, (vim argo-cdcontroller.yml)

Paste the manifest copied and save file. Finally, execute using the 'kubectl apply -f' command.


(G) ACCESS ARGOCD PAGE FOR FINAL DELIVERY

1. Show the services running on your K8S cluster - 'kubectl get svc'

Services running will include ArgoCD's. The service with the name - 'argocd-server' should be updated to NodePort configuration to allow access to UI within the environment, other than ClusterIP - 'kubectl edit svc arogcd-server' ; '/type' ; edit type to 'NodePort' and save.

2. To access URL, it can be accessed by showing the minikube services running - 'minikube service list'

Locate the URL for argocd-server service, and copy URL and launch on browser.

3. Username - admin; to retrieve password, launch the commands on CLI on the K8S cluster:

- _kubectl get secret_ (there's a default secret stored by ArgoCD on your cluster)

- _kubectl edit secret 'secretname'_

- copy the admin password shown, although it is encryped in Base64 by default;

- to convert to plaintext, on CLI: _echo 'admin password' | base64 -d_

- plaintext password will be shown, and paste password on ArgoCD's UI to login.


(H) FINAL DEPLOYMENT

1. Create a deployment file in your repository within the app folder.

_This deployment file defines the configuration for deploying a Spring Boot application on Kubernetes, specifying details such as the number of replicas, container image, and exposed port._

2. Launch CI Pipeline on your Jenkins UI page. Select the 'Build Now' option to begin the process.

3. If the CI Pipeline launch is successful,

On ArgoCD's UI: Create Application ➔ Input App Name, Project Name ➔ Set Sync Policy to Auto ➔ Specify your Repository URL, Deployment file path, Cluster URL (K8S), Namespace ➔ Create.

4. After some time, the Spring-boot Java application should be successfully deployed on the K8S cluster with ArgoCD and should be available to access on browser.
