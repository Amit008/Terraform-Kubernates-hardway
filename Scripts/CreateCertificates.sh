cfssl gencert -initca ../../JasonFiles/ca-csr.json | cfssljson -bare ../../Certificate/ca
cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/admin-csr.json | cfssljson -bare ../../Certificate/admin
cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-controller-manager-csr.json | cfssljson -bare ../../Certificate/kube-controller-manager
cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/service-account-csr.json | cfssljson -bare ../../Certificate/service-account
cfssl gencert -ca=../../Certificate/ca.pem -ca-key=ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-proxy-csr.json | cfssljson -bare ../../Certificate/kube-proxy



cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -hostname=10.32.0.1,10.240.0.10,10.240.0.11,10.240.0.12,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,${KUBERNETES_HOSTNAMES} -profile=kubernetes ../../JasonFiles/kubernetes-csr.json | cfssljson -bare ../../Certificate/kubernetes
