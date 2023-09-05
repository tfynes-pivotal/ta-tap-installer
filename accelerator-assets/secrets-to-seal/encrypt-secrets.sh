
export SOPS_AGE_RECIPIENTS=$(cat ./key.txt | grep "# public key: " | sed 's/# public key: //')
export SOPS_AGE_KEY=$(cat ./key.txt)

sops -e ./config/tanzu-registry-secret.yaml > ./config/tanzu-registry-secret.sops.yaml
sops -e ./config/user-registry-dockerconfig.yaml > ./config/user-registry-dockerconfig.sops.yaml
sops -e ./config/workload-git-auth.yaml > ./config/workload-git-auth.sops.yaml

sops -e ./dependent-resources/sso-credentials-secret.yaml > ./dependent-resources/sso-credentials-secret.sops.yaml

sops -e ./tanzu-sync/tanzu-sync-values.yaml > ./tanzu-sync/tanzu-sync-values.sops.yaml

sops -e ./tls/taplab-tls-certs.yaml > ./tls/taplab-tls-certs.sops.yaml
                                             

sops -e ./values/tap-sensitive-values.yaml > ./values/tap-sensitive-values.sops.yaml

echo
echo DELETE '/accelerator-assets/secrets-to-seal' FOLDER AS UNENCRYPTED SECRETS CONTAINED THEREIN MUST NOT BE PUSH TO A REPO
echo

