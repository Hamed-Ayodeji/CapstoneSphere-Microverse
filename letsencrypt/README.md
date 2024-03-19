# LET'S ENCRYPT

## Overview

Let's Encrypt is a free, automated, and open Certificate Authority. It provides free SSL/TLS certificates for your website. It is a service provided by the Internet Security Research Group (ISRG). The certificates are valid for 90 days and are trusted by all major browsers. Let's Encrypt is a great way to secure your website and protect your users' privacy. It is easy to use and can be integrated with your web server or application.

This directory contains YAML files that deploy issuers that get the certificate from Let's Encrypt using cert-manager. The cert-manager is a Kubernetes add-on to automate the management and issuance of TLS certificates from various issuing sources. It will ensure that your certificates are valid and up to date. The issuer files are used to configure the Let's Encrypt issuer to get the certificate.

There are two issuer files in this directory. The `staging-issuer.yml` file is used to get a staging certificate from Let's Encrypt. The staging certificate is not trusted by browsers and is used for testing purposes. The `production-issuer.yml` file is used to get a production certificate from Let's Encrypt. The production certificate is trusted by browsers and is used for your live website. the production issuer has a rate limit of 50 certificates per week, hence why testing is first done with the staging issuer, and when everything is working as expected, the production issuer is used.

## Testing

To test the issuer files, you can deploy them to your Kubernetes cluster using the following command:

```bash
kubectl apply -f 1-issuer-staging.yml
```

When the staging issuer is deployed to the cluster, you can use the SSL/TLS certificate for your website. This is done by adding the following annotations to your Ingress resource:

```yaml
metadata:
  annotations:
    cert-manager.io/issuer: staging
```

and an extra tls block to your Ingress resource:

```yaml
spec:
  tls:
  - hosts:
    - example.com
    secretName: example-com-tls
```

Replace `example.com` with your domain name and `example-com-tls` with your secret name. When the Ingress resource is updated, the cert-manager will automatically get the certificate from Let's Encrypt and store it in a Kubernetes Secret. The Secret will be used by your web server to serve the website over HTTPS.

The staging certificate is not trusted by browsers, so you will see a warning when you visit your website. This is expected and is used for testing purposes.

Screenshot of the warning message:

![staging-certificate-warning](.img/failed%20acme.png)

When you click on the not secure warning, you will see the following message:

![staging-certificate-warning-details](.img/failed%20acme%202.png)

This proves that a staging certificate was given to the website, but it is not trusted by browsers.

When you are happy with the testing, you can deploy the production issuer to your Kubernetes cluster using the following command:

```bash
kubectl apply -f 2-issuer-production.yml
```

When the production issuer is deployed to the cluster, you can use the SSL/TLS certificate for your website. This is done by adding the following annotations to your Ingress resource:

```yaml
metadata:
  annotations:
    cert-manager.io/issuer: production
```

and the extra tls block to your Ingress resource, just as we did above.

Replace `example.com` with your domain name and `example-com-tls` with your secret name. When the Ingress resource is updated, the cert-manager will automatically get the certificate from Let's Encrypt and store it in a Kubernetes Secret. The Secret will be used by your web server to serve the website over HTTPS.

The production certificate is trusted by browsers, so you will not see a warning when you visit your website. This is expected and is used for your live website.

Screenshot of the secure website:

![production-certificate-secure](.img/secure-page.png)

**Note:** The commands above contains file names and configurations that are specific to this repository. You may need to modify the commands to match your environment.

## Conclusion

Let's Encrypt is a great way to secure your website and protect your users' privacy. It is easy to use and can be integrated with your web server or application. The cert-manager is a Kubernetes add-on to automate the management and issuance of TLS certificates from various issuing sources. It will ensure that your certificates are valid and up to date. The issuer files are used to configure the Let's Encrypt issuer to get the certificate. The staging issuer is used for testing purposes, and the production issuer is used for your live website. The production issuer has a rate limit of 50 certificates per week, hence why testing is first done with the staging issuer, and when everything is working as expected, the production issuer is used.
