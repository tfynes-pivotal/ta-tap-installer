export IMGPKG_REGISTRY_HOSTNAME=harbor.harborlab.fynesy.net
export IMGPKG_REGISTRY_USERNAME=admin
export IMGPKG_REGISTRY_PASSWORD='Harbor12345!'
export TAP_VERSION=1.6.3
export TDS_VERSION=1.7.0
#! export TBS_VERSION=1.10.9

docker login registry.tanzu.vmware.com

# imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:$TAP_VERSION        --to-repo $IMGPKG_REGISTRY_HOSTNAME/tap-packages --include-non-distributable-layers       

imgpkg copy -b registry.tanzu.vmware.com/packages-for-vmware-tanzu-data-services/tds-packages:$TDS_VERSION  --to-repo $IMGPKG_REGISTRY_HOSTNAME/tds-packages/tds-packages --include-non-distributable-layers

#! imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/full-tbs-deps-package-repo:1.10.8   --to-repo=$IMGPKG_REGISTRY_HOSTNAME/tap/tbs-full-deps
#!imgpkg copy -b registry.tanzu.vmware.com/spring-cloud-gateway-for-kubernetes/scg-package-repository:2.0.0 --to-tar=/Users/thomasfynes/PIVOTAL/TAP/tap15offline/scg.tar
#!imgpkg copy -b registry.tanzu.vmware.com/packages-for-vmware-tanzu-data-services/tds-packages:1.7.0       --to-tar=/Users/thomasfynes/PIVOTAL/TAP/tap15offline/tds.tar
#!imgpkg copy -b registry.tanzu.vmware.com/p-rabbitmq-for-kubernetes/tanzu-rabbitmq-package-repo:1.4.1      --to-tar=/Users/thomasfynes/PIVOTAL/TAP/tap15offline/rmq.tar
