#! /usr/bin/env sh

cat > ./bin/kind.yaml <<EOF
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF

# create the kind cluster
kind create cluster --config=bin/kind.yaml

# bootstrap flux FILL THIS OUT PLEASE :)
flux bootstrap github --owner=username --repository=forked-repo-name --private=false --personal=true

# import public pgp
gpg --import public.pgp

# import private pgp (to decrypt already encrypted file)
gpg --import private.pgp

# install sops key to the flux namespace
gpg --export --armor A13EBDCD7CD64CCD931E5AD93945D207A3325B05 | kubectl create secret generic sops-gpg --namespace=flux-system --from-file=sops.asc=/dev/stdin

# decrypt the file... just for the fun of it
sops --decrypt --in-place fluxed/podinfo.yaml

# encrypt a simple value
sops --encrypt --in-place fluxed/podinfo.yaml

# do a diff with an encrypted value
flux diff kustomization apps --path fluxed/