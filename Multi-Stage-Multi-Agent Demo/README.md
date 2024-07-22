**Multi-Stage, Multi-Agent Jenkins Pipeline Demo**

This Jenkins pipeline demonstrates the use of multiple stages and agents to build and test a project with different environments for the back-end and front-end stages. By making use of Docker images for each stage, this pipeline ensures consistency & isolation in the build and test environments. 

**Use Case:** This approach is particularly useful for projects that require different tools or versions of tools for different parts of the application. Basically, for use cases with more than one project stage or more than one project agent to be used.

**Major prerequisites:**

To enable this pipeline in your Jenkins setup, ensure you have:

1. Docker installed on the Jenkins host.

2. The appropriate Docker images (maven:3.8.1-adoptopenjdk-11 and node:16-alpine) available either locally or from a Docker registry.

3. Jenkins configured with the necessary permissions to run Docker containers.

**Project Parts:**

The pipeline is defined using Jenkins' declarative pipeline syntax and consists of two main stages as mentioned: **Back-end and Front-end.**

**Stages and Agents**

**1. Back-end Stage**

Agent: maven:3.8.1-adoptopenjdk-11

Purpose: This stage sets up a Maven environment to handle tasks related to the back-end of the project.

Steps: Executes _mvn --version_ to verify the Maven installation and environment.

**2. Front-end Stage**

Agent: node:16-alpine

Purpose: This stage sets up a Node.js environment to handle tasks related to the front-end of the project.

Steps: Executes _node --version_ to verify the Node.js installation and environment.

**Project Flow:**

_**Pipeline Initialization:**_

The pipeline starts with _agent none_, indicating that no global agent is defined for the entire pipeline. Each stage specifies its own agent.

_**Back-end Stage Execution:**_

A. Jenkins creates a Docker container using the specified image - maven:3.8.1-adoptopenjdk-11.

B. The sh 'mvn --version' command runs inside this container, ensuring that Maven is available and properly configured.

_**Front-end Stage Execution:**_

Jenkins creates another Docker container using the specified image - node:16-alpine.

The sh 'node --version' command runs inside this container, ensuring that Node.js is available and properly configured.
