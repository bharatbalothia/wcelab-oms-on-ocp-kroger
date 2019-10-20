#!/bin/bash
sh ./build_custom.sh
cd /opt/ssfs/runtime/docker-samples/imagebuild
./generateImages.sh --MODE=app --WAR_FILES=smcfs --EXPORT=true
echo PUSH_DOCKERCFG_PATH $PUSH_DOCKERCFG_PATH
echo "Content of the file $(cat $PUSH_DOCKERCFG_PATH/.dockercfg)"
(echo "{ \"auths\": " ; sudo cat $PUSH_DOCKERCFG_PATH/.dockercfg ; echo "}") > /tmp/.dockercfg
buildah tag om-app:10.0 ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}
buildah push --tls-verify=false --authfile=/tmp/.dockercfg ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}