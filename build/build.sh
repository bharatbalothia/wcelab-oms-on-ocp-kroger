#!/bin/bash
sh ./build_custom.sh
cd /opt/ssfs/runtime/docker-samples/imagebuild
#./generateImages.sh --MODE=app --WAR_FILES=smcfs --EXPORT=true
./generateImages.sh --MODE=agent --EXPORT=true
echo PUSH_DOCKERCFG_PATH $PUSH_DOCKERCFG_PATH
echo "Content of the file $(cat $PUSH_DOCKERCFG_PATH/.dockercfg)"
(echo "{ \"auths\": " ; sudo cat $PUSH_DOCKERCFG_PATH/.dockercfg ; echo "}") > /tmp/.dockercfg
echo "OUTPUT_REGISTRY" ${OUTPUT_REGISTRY}
echo "RELEASE_VERSION" ${RELEASE_VERSION}
buildah tag om-agent:10.0 ${OUTPUT_REGISTRY}/${OMS_AGENT_IMG_STREAM}:${RELEASE_VERSION}
echo "buildah tag done"
sudo docker images
buildah push --tls-verify=false --authfile=/tmp/.dockercfg ${OUTPUT_REGISTRY}/${OMS_AGENT_IMG_STREAM}:${RELEASE_VERSION}
echo "buildah push done"