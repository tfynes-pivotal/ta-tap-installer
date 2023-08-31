
if [ -f ./key.txt ]
then
export SOPS_AGE_RECIPIENTS=$(cat ./key.txt | grep "# public key: " | sed 's/# public key: //')
export SOPS_AGE_KEY=$(cat ./key.txt)

sops -e ./config/tanzu-registry-secret.yaml > ./config/tanzu-registry-secret.sops.yaml
sops -e ./config/user-registry-dockerconfig.yaml > ./config/user-registry-dockerconfig.sops.yaml
sops -e ./config/workload-git-auth.yaml > ./config/workload-git-auth.sops.yaml

sops -e ./dependent-resources/sso-credentials-secret.yaml > ./dependent-resources/sso-credentials-secret.sops.yaml

sops -e ./tanzu-sync/tanzu-sync-values.yaml > ./tanzu-sync/tanzu-sync-value.sops.yaml

sops -e ./values/tap-sensitive-values.yaml > ./values/tap-sensitive-values.sops.yaml

else

echo copy 'key.txt' to current secrets-to-seal folder

fi