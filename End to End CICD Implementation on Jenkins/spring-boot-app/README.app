BREAKDOWN OF JENKINSFILE

Agent Configuration

- Docker Agent:
  - Uses a specified Docker image for Maven and Docker tools.
  - Mounts the Docker socket to access the host's Docker daemon.
  - This agent runs all pipeline stages within the specified Docker container.

Stages Breakdown

1. Checkout:
   - Performs initial setup.
   - Contains a placeholder command (`sh 'echo passed'`).
   - Typically used to clone the repository (commented out in this case).

2. Build and Test:
   - Lists files in the directory (`sh 'ls -ltr'`).
   - Navigates to the project directory and runs Maven to build the project and create a JAR file (`mvn clean package`).

3. Static Code Analysis:
   - Sets the SonarQube server URL.
   - Uses SonarQube credentials to run a static code analysis via Maven (`mvn sonar:sonar`).

4. Build and Push Docker Image:
   - Sets Docker image name using the build number.
   - Builds the Docker image from the specified Dockerfile located in the project directory.
   - Pushes the built image to Docker Hub using stored credentials.

5. Update Deployment File:
   - Sets repository and user information.
   - Uses GitHub credentials to update the deployment file with the new Docker image tag.
   - Commits and pushes the changes to the main branch of the repository.

Key Points

- Agent vs. App Docker Images:
  - The agent Docker image is used to run all pipeline stages and prepare the necessary environment to run.
  - The app Docker image is built during the pipeline and contains the compiled Java application.

- Checkout Stage:
  - Ensures the pipeline is operating on the latest code by cloning the repository.
  - Currently has a placeholder for demonstration purposes.

- Building the App Artifact:
  - The application is built into a JAR file using Maven in the `Build and Test` stage.
  - This JAR file is then included in the Docker image built in the `Build and Push Docker Image` stage.
  - This Docker image is pushed to Docker Hub and is referenced in the deployment file for subsequent deployment to Kubernetes.

- Purpose of `pom.xml` File:
  - `pom.xml` in a Maven project is similar to `requirements.txt` in a Python-based application.
  - It specifies the project dependencies, build configuration, and other project-related information.
  - Maven uses this file to manage the project's build process, ensuring all necessary dependencies are included.
