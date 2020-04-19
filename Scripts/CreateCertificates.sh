cfssl gencert -initca ../../JasonFiles/ca-csr.json | cfssljson -bare ../../Certificate/ca
cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/admin-csr.json | cfssljson -bare ../../Certificate/admin
cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-controller-manager-csr.json | cfssljson -bare ../../Certificate/kube-controller-manager
cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/service-account-csr.json | cfssljson -bare ../../Certificate/service-account
cfssl gencert -ca=../../ca.pem -ca-key=ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-proxy-csr.json | cfssljson -bare ../../Certificate/kube-proxy
