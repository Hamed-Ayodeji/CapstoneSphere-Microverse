# LET'S ENCRYPT

## Overview

Let's Encrypt is a free, automated, and open Certificate Authority. It provides free SSL/TLS certificates for your website. It is a service provided by the Internet Security Research Group (ISRG). The certificates are valid for 90 days and are trusted by all major browsers. Let's Encrypt is a great way to secure your website and protect your users' privacy. It is easy to use and can be integrated with your web server or application.

This directory contains YAML files that deploy issuers that get the certificate from Let's Encrypt using cert-manager. The cert-manager is a Kubernetes add-on to automate the management and issuance of TLS certificates from various issuing sources. It will ensure that your certificates are valid and up to date. The issuer files are used to configure the Let's Encrypt issuer to get the certificate.

There are two issuer files in this directory. The `staging-issuer.yaml` file is used to get a staging certificate from Let's Encrypt. The staging certificate is not trusted by browsers and is used for testing purposes. The `production-issuer.yaml` file is used to get a production certificate from Let's Encrypt. The production certificate is trusted by browsers and is used for your live website. the production issuer has a rate limit of 50 certificates per week, hence why testing is first done with the staging issuer, and when everything is working as expected, the production issuer is used.
