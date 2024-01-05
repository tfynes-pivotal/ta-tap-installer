
FULL_CLUSTER_CONTEXT=akslab4
RUN_CLUSTER_CONTEXT=akslab5

kubectl config use-context $FULL_CLUSTER_CONTEXT
FULL_CLUSTER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
FULL_CLUSTER_TOKEN=$(kubectl -n tap-gui get secret tap-gui-viewer -o=json | jq -r '.data["token"]' | base64 --decode)

kubectl config use-context $RUN_CLUSTER_CONTEXT
RUN_CLUSTER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
RUN_CLUSTER_TOKEN=$(kubectl -n tap-gui get secret tap-gui-viewer -o=json | jq -r '.data["token"]' | base64 --decode)


echo FULL_CLUSTER_URL = $FULL_CLUSTER_URL
echo FULL_CLUSTER_TOKEN = $FULL_CLUSTER_TOKEN
echo RUN-CLUSTER-URL = $RUN_CLUSTER_URL
echo RUN_CLUSTER_TOKEN = $RUN_CLUSTER_TOKEN

sed -i bak -e 's|FULL_CLUSTER_URL|'"${FULL_CLUSTER_URL}"'|g' multiClusterLocations.yaml
sed -i bak -e 's|FULL_CLUSTER_TOKEN|'"${FULL_CLUSTER_TOKEN}"'|g' multiClusterLocations.yaml
sed -i bak -e 's|RUN_CLUSTER_URL|'"${RUN_CLUSTER_URL}"'|g' multiClusterLocations.yaml
sed -i bak -e 's|RUN_CLUSTER_TOKEN|'"${RUN_CLUSTER_TOKEN}"'|g' multiClusterLocations.yaml
