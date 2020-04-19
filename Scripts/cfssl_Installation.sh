#!/bin/bash
sudo curl -s -L -o /usr/local/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
sudo curl -s -L -o /usr/local/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
sudo chmod 775 /usr/local/bin/cfssl*
export PATH=$PATH:/usr/local/bin
   
