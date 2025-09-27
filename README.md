# Sample Workflows for Deploying a Web Application on GKE

This repository contains sample workflows for deploying a web application on Google Kubernetes Engine (GKE) using Helm charts. The project is structured to facilitate continuous integration and deployment through GitHub Actions.

## Project Structure

- **.github/workflows/**: Contains GitHub Actions workflows for CI and deployment.
  - **ci.yml**: Defines the CI pipeline to run tests on code changes.
  - **deploy.yml**: Defines the deployment pipeline to GKE using Helm.

- **charts/sample-web-app/**: Contains the Helm chart for the sample web application.
  - **Chart.yaml**: Metadata about the Helm chart.
  - **values.yaml**: Default configuration values for the Helm chart.
  - **templates/**: Contains Kubernetes resource templates.
    - **deployment.yaml**: Defines the deployment resource.
    - **service.yaml**: Defines the service resource.
    - **ingress.yaml**: Defines the ingress resource.
    - **_helpers.tpl**: Helper templates for other templates.
    - **NOTES.txt**: Instructions after installation.

- **src/app/**: Contains the source code for the sample web application.
  - **package.json**: Configuration file for npm.
  - **index.js**: Entry point of the web application.

- **Dockerfile**: Instructions to build a Docker image for the application.

- **.dockerignore**: Specifies files to ignore when building the Docker image.

- **.gitignore**: Specifies files to ignore in the Git repository.

## Getting Started

To get started with this project, follow these steps:

1. **Clone the repository**:
   ```
   git clone https://github.com/tuttify-ai/sample-workflows.git
   cd sample-workflows
   ```

2. **Build the Docker image**:
   ```
   docker build -t sample-web-app .
   ```

3. **Deploy to GKE**:
   Ensure you have a GKE cluster set up and configured. Use the Helm chart to deploy the application:
   ```
   helm install sample-web-app charts/sample-web-app
   ```

4. **Run CI/CD**:
   Push changes to the repository to trigger the CI/CD workflows defined in GitHub Actions.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.