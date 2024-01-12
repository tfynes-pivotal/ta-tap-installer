#!/bin/bash


#! ACCELERATOR SERVER-SIDE CREATED
#! CLUSTERLIST.CSV
#!
#! SCRIPT WALKS CSV AND CREATES ENCRICHED JSON FILE (with cluster urls and access tokens)
#! CLUSTERS.JSON
#!
#! SCRIPT USES YTT TO GENERATE CONFIGURATION FRAGMENT FOR TAP-GUI BLOCK OF TAP-VALUES (SENSITIVE) EMBEDDING CLUSTERS.JSON CONTENT
#!
#! TODO - take output yaml fragment and embed into tap-sensitive-values, reencrypt and update version deployed to git repo





mv clustersData.json clustersData.json.old 


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
        echo "\"url\":\"$CLUSTER_URL\"," >> clustersData.json
        echo "\"name\":\"$tapClusterName\"," >> clustersData.json
        echo "\"authProvider\":\"serviceAccount\"," >> clustersData.json
        echo "\"serviceAccountToken\":\"$CLUSTER_TOKEN\"," >> clustersData.json
        echo "\"skipTLSVerify\":\"true\"," >> clustersData.json
        echo "\"skipMetricsLookup\":\"true\"" >> clustersData.json
    echo "}," >> clustersData.json
  fi 
done < ./clusterList.csv
cat clustersData.json | sed '$d' > clustersData-tmp.json
mv clustersData-tmp.json clustersData.json
echo "}" >> clustersData.json	
echo "]}" >> clustersData.json


ytt -f mc.yaml --data-value-file clusters=clusters.json


# - url: #@ data.values.CLUSTERS[0].NAME
#           name: FULL
#           authProvider: serviceAccount
#           serviceAccountToken: FULL_CLUSTER_TOKEN
#           skipTLSVerify: true
#           skipMetricsLookup: true




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
