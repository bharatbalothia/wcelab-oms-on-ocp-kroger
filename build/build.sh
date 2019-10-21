#!/bin/bash
sh ./build_custom.sh
cd /opt/ssfs/runtime/docker-samples/imagebuild
#./generateImages.sh --MODE=app --WAR_FILES=smcfs --EXPORT=true
./generateImages.sh --MODE=agent --EXPORT=true
echo PUSH_DOCKERCFG_PATH $PUSH_DOCKERCFG_PATH
echo "Content of the file $(cat $PUSH_DOCKERCFG_PATH/.dockercfg)"
(echo "{ \"auths\": " ; sudo cat $PUSH_DOCKERCFG_PATH/.dockercfg ; echo "}") > /tmp/.dockercfg
echo "OUTPUT_REGISTRY" ${OUTPUT_REGISTRY}
echo "OUTPUT_IMAGE" ${OUTPUT_IMAGE}
buildah tag om-app:10.0 ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}
echo "buildah tag done"
sudo docker images
buildah push --tls-verify=false --authfile=/tmp/.dockercfg ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}
echo "buildah push done"