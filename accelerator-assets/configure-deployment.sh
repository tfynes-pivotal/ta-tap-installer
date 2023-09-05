
pushd ./secrets-to-seal
./encrypt-secrets.sh
popd


mv ./secrets-to-seal/config/tanzu-registry-secret.sops.yaml ../clusters/taplab/cluster-config/config/
mv ./secrets-to-seal/config/user-registry-dockerconfig.sops.yaml ../clusters/taplab/cluster-config/config/
mv ./secrets-to-seal/config/workload-git-auth.sops.yaml          ../clusters/taplab/cluster-config/config/

mv ./secrets-to-seal/dependent-resources/sso-credentials-secret.sops.yaml ../clusters/taplab/cluster-config/dependent-resources/

mkdir -p ../clusters/taplab/tanzu-sync/app/sensitive-values
mv ./secrets-to-seal/tanzu-sync/tanzu-sync-values.sops.yaml ../clusters/taplab/tanzu-sync/app/sensitive-values/

# mv ./secrets-to-seal/tanzu-sync/registry-credentials.sops.yaml ../clusters/taplab/tanzu-sync/config/.tanzu-managed/

mv ./secrets-to-seal/values/tap-sensitive-values.sops.yaml ../clusters/taplab/cluster-config/values/

mv ./secrets-to-seal/tanzu-sync/tls/taplab-tls-certs.sops.yaml ../clusters/taplab/cluster-config/config/

mv ./non-sensitive-config/tap-non-sensitive-values.yaml             ../clusters/taplab/cluster-config/values/

echo
echo DELETE /accelerator-log.md BEFORE PUSHING TO REPO AS IT CONTAINS SENSITIVE VALUES
echo