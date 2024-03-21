# Helm_charts

## Overview

This directory contains terraform configurations that use the Helm provider to deploy Helm charts to a Kubernetes cluster. The configurations are used to deploy the following Helm charts:

- [cert-manager](https://cert-manager.io/docs/)

- [Argo CD](https://argoproj.github.io/argo-cd/)

You can add more Helm charts to the `tools.tf` file to deploy additional applications to your Kubernetes cluster. This configuration depends on the AKS cluster created in the `infrastructure` directory. Ensure that the AKS cluster is up and running before deploying the Helm charts.
