openssl req -new -newkey rsa:4096 -keyout tas-admin.key -out tas-admin.csr -nodes -subj "/CN=tas-admin"

export req=$(cat tas-admin.csr | base64 | tr -d "\n")

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: tas-admin
spec:
  request: $req
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF

kubectl get csr
kubectl certificate approve tas-admin
kubectl describe csr/tas-admin
kubectl get csr tas-admin -o json | jq -r .status.certificate | base64 -d > tas-admin.crt
kubectl config set-credentials tas-admin --client-key=tas-admin.key --client-certificate=tas-admin.crt --embed-certs

