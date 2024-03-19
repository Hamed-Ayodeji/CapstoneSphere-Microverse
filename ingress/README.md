# INGRESS

## Overview

This directory contains the deployment of the Nginx ingress control file and ingress manifest files for the sock-shop microservices.

### Nginx Ingress Controller

The Nginx Ingress Controller is a Kubernetes add-on that uses ConfigMap to store the Nginx configuration. The Nginx Ingress Controller is deployed to the `ingress-nginx` namespace and is used to route traffic to the sock-shop microservices. It also works as a load balancer and reverse proxy for the sock-shop microservices.

To deploy the Nginx Ingress Controller, use the following command:

```bash
kubectl apply -f nginx-ingress.yml
```

### Sock Shop Ingress

The Sock Shop Ingress is a Kubernetes resource that routes traffic from the internet to the sock-shop microservices. It is deployed to the `sock-shop` namespace and is used to define the desired state of the application. The Sock Shop Ingress is used to route traffic to the sock-shop microservices and is defined in the `sock-shop.yml` file.

To deploy the Sock Shop Ingress, use the following command:

```bash
kubectl apply -f sock-shop.yml
```

**Note:** The Sock Shop Ingress is deployed to the `sock-shop` namespace, so make sure you are in the correct namespace before deploying the ingress. Also because it carrier configuration for the certificate, make sure you have the certificate issuer deployed before deploying the ingress.

## Testing

After the Nginx Ingress Controller and Sock Shop Ingress are deployed, you can test the ingress by visiting the URL provided in the ingress resource. The URL is the host defined in the ingress resource and the path defined in the ingress resource. For example, the host is `sock-shop.qurtana.com.ng` and the path is `/catalogue`, you can visit the URL `https://sock-shop.qurtana.com.ng/catalogue` to test the ingress.

Here are screenshots of the deploy sock-shop microservices application:

### Homepage

![sock-shop-home](.img/homepage.png)

### Catalogue

![sock-shop-catalogue](.img/catalogue.png)

### Login Page

![sock-shop-login](.img/login.png)

### Cart

![sock-shop-cart](.img/cart.png)

### Checkout

![sock-shop-checkout](.img/orders.png)

### Twitter icon

![sock-shop-twitter](.img/twittericon.png)

### Mailing icon

![sock-shop-mailing](.img/emailicon.png)

## Conclusion

The Nginx Ingress Controller and Sock Shop Ingress are deployed to the `ingress-nginx` and `sock-shop` namespaces respectively. The Nginx Ingress Controller is used to route traffic to the sock-shop microservices and works as a load balancer and reverse proxy for the sock-shop microservices. The Sock Shop Ingress is used to define the desired state of the application and routes traffic from the internet to the sock-shop microservices. After the Nginx Ingress Controller and Sock Shop Ingress are deployed, you can test the ingress by visiting the URL provided in the ingress resource. The URL is the host defined in the ingress resource and the path defined in the ingress resource. For example, the host is `sock-shop.qurtana.com.ng` and the path is `/catalogue`, you can visit the URL `https://sock-shop.qurtana.com.ng/catalogue` to test the ingress.
