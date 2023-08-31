
pushd ./secrets-to-seal
./encrypt-secrets.sh
popd


cp ./secrets-to-seal/config/tanzu-registry-secret.sops.yaml ../clusters/taplab/cluster-config/config/
cp ./secrets-to-seal/config/user-registry-dockerconfig.sops.yaml ../clusters/taplab/cluster-config/config/
cp ./secrets-to-seal/config/workload-git-auth.sops.yaml          ../clusters/taplab/cluster-config/config/

cp ./secrets-to-seal/dependent-resources/sso-credentials-secret.sops.yaml ../clusters/taplab/cluster-config/dependent-resources/
cp ./secrets-to-seal/tanzu-sync/tanzu-sync-values.sops.yaml ../clusters/taplab/tanzu-sync/app/sensitive-values/

cp ./ytt-outputs/tap-non-sensitive-values.yaml             ../clusters/taplab/cluster-config/values/