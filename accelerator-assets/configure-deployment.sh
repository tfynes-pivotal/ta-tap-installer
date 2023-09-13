
pushd ..
if [ CREATE_AGE_KEY = 'create-key' ]
then
age-keygen > ../key.txt
export SOPS_AGE_KEY=\$(cat $(pwd)/key.txt)
echo SOPS ENCRYPTION KEY CREATED IN TOP LEVEL OF GITREPO FOLDER
fi
popd


pushd ./secrets-to-seal
./encrypt-secrets.sh
popd

pushd ..
if [ CREATE_AGE_KEY != 'create-key' ]
then
mv ./secrets-to-seal/key.txt ../
echo
echo SOPS ENCRYPTION KEY MOVED TO TOP LEVEL OF GITREPO FOLDER 
fi


echo INITIALIZE SOPS ENV VAR AS FOLLOWS
echo
echo "export SOPS_AGE_KEY=\$(cat $(pwd)/key.txt)"
popd
echo "(/key.txt added to .gitignore)"
echo
echo
echo
popd

mv ./secrets-to-seal/config/tanzu-registry-secret.sops.yaml ../clusters/taplab/cluster-config/config/
mv ./secrets-to-seal/config/user-registry-dockerconfig.sops.yaml ../clusters/taplab/cluster-config/config/
mv ./secrets-to-seal/config/workload-git-auth.sops.yaml          ../clusters/taplab/cluster-config/config/

mv ./secrets-to-seal/dependent-resources/sso-credentials-secret.sops.yaml ../clusters/taplab/cluster-config/dependent-resources/

mkdir -p ../clusters/taplab/tanzu-sync/app/sensitive-values
mv ./secrets-to-seal/tanzu-sync/tanzu-sync-values.sops.yaml ../clusters/taplab/tanzu-sync/app/sensitive-values/

# mv ./secrets-to-seal/tanzu-sync/registry-credentials.sops.yaml ../clusters/taplab/tanzu-sync/config/.tanzu-managed/

mv ./secrets-to-seal/values/tap-sensitive-values.sops.yaml ../clusters/taplab/cluster-config/values/

if [ TLS_MODE = 'tlsManual' ]
then
mv ./secrets-to-seal/tls/taplab-tls-certs.sops.yaml ../clusters/taplab/cluster-config/config/
fi

mv ./non-sensitive-config/tap-non-sensitive-values.yaml             ../clusters/taplab/cluster-config/values/



echo "DELETE /accelerator-log.md BEFORE PUSHING TO REPO AS IT CONTAINS SENSITIVE VALUES"
echo