#!/bin/bash

while IFS=, read -r tapClusterName tapClusterContext; do
if [[ "$tapClusterName" != "# CLUSTER_LIST" ]]
  then
    #echo "name = $tapClusterName context = $tapClusterContext";
    echo "Fetching URL and ServiceAccount Token for Cluster Name $tapClusterName on context $tapClusterContext";
  fi
done < ./clusterList.csv


echo "{\"CLUSTERS\":[" >> clustersData.json
while IFS=, read -r tapClusterName tapClusterContext; do
if [[ "$tapClusterName" != "# CLUSTER_LIST" ]]
  then
    echo "Fetching URL and ServiceAccount Token for Cluster Name $tapClusterName on context $tapClusterContext";
    kubectl config use-context $tapClusterContext
    CLUSTER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
    CLUSTER_TOKEN=$(kubectl -n tap-gui get secret tap-gui-viewer -o=json | jq -r '.data["token"]' | base64 --decode)
    echo 
    echo "Cluster $tapClusterName"
    echo "Context $tapClusterContext"
    echo "URL = $CLUSTER_URL"
    echo "TOKEN = $CLUSTER_TOKEN"
    echo 
    echo "{" >> clustersData.json
    echo "\"NAME\":\"$tapClusterName\",\"CONTEXT\":\"$tapClusterContext\",\"URL\":\"$CLUSTER_URL\",\"TOKEN\":\"$CLUSTER_TOKEN\"" >> clustersData.json
    echo "}," >> clustersData.json
  fi 
done < ./clusterList.csv
cat clustersData.json | sed '$d' > clustersData-tmp.json
mv clustersData-tmp.json clustersData.json
echo "}" >> clustersData.json	
echo "]}" >> clustersData.json







# CLUSTER_LIST 
# FULL_CLUSTER_CONTEXT=akslab4
# RUN_CLUSTER_CONTEXT=akslab5

# kubectl config use-context $FULL_CLUSTER_CONTEXT
# FULL_CLUSTER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
# FULL_CLUSTER_TOKEN=$(kubectl -n tap-gui get secret tap-gui-viewer -o=json | jq -r '.data["token"]' | base64 --decode)

# kubectl config use-context $RUN_CLUSTER_CONTEXT
# RUN_CLUSTER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
# RUN_CLUSTER_TOKEN=$(kubectl -n tap-gui get secret tap-gui-viewer -o=json | jq -r '.data["token"]' | base64 --decode)


# echo FULL_CLUSTER_URL = $FULL_CLUSTER_URL
# echo FULL_CLUSTER_TOKEN = $FULL_CLUSTER_TOKEN
# echo RUN-CLUSTER-URL = $RUN_CLUSTER_URL
# echo RUN_CLUSTER_TOKEN = $RUN_CLUSTER_TOKEN

# sed -i bak -e 's|FULL_CLUSTER_URL|'"${FULL_CLUSTER_URL}"'|g' multiClusterLocations.yaml
# sed -i bak -e 's|FULL_CLUSTER_TOKEN|'"${FULL_CLUSTER_TOKEN}"'|g' multiClusterLocations.yaml
# sed -i bak -e 's|RUN_CLUSTER_URL|'"${RUN_CLUSTER_URL}"'|g' multiClusterLocations.yaml
# sed -i bak -e 's|RUN_CLUSTER_TOKEN|'"${RUN_CLUSTER_TOKEN}"'|g' multiClusterLocations.yaml
