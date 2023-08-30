
./secrets-to-seal/encrypt-secrets.sh


cp ./secrets-to-seal/config/tanzu-registry-secret.sops.yaml ../clusters/taplab/cluster-config/config/
cp ./secrets-to-seal/config/user-registry-dockerconfig.sops.yaml ../clusters/taplab/cluster-config/config/
cp ./secrets-to-seal/config/workload-git-auth.sops.yaml          ../clusters/taplab/cluster-config/config/

cp ./secrets-to-seal/dependent-resources/sso-credentials-secret.sops.yaml ../clusters/taplab/cluster-config/dependent-resources/

cp ./ytt-outputs/tap-non-sensitive-values.yaml             ../clusters/taplab/cluster-config/values/
cp ./secrets-to-seal/values/tap-sensitive-values.sops.yaml ../clusters/taplab/cluster-config/values/
