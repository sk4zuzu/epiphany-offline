# Please note, this image is supposed to be built with the --no-cache option.

ARG NAME

FROM epiphany-offline-${NAME}-prepare_scripts-cache

ARG EPIPHANY_BRANCH

WORKDIR /workspaces/epiphany/core/src/epicli/

RUN : FORCEFULLY PULL LATEST COMMITS FROM THE EPIPHANY GITHUB REPO \
 && git fetch origin ${EPIPHANY_BRANCH} \
 && git reset --hard origin/${EPIPHANY_BRANCH}

RUN : UPDATE PIP REQUIREMENTS \
 && pip3 --no-cache-dir install -r ./.devcontainer/requirements.txt

ARG NAME

RUN : GENERATE THE "PREPARE SCRIPTS" \
 && PYTHONPATH=$(pwd) python3 ./cli/epicli.py prepare --os ${NAME}

RUN : RENDER THE "IMAGES TO LOAD" LIST \
 && yq read --tojson \
    ./data/common/defaults/configuration/image-registry.yml \
    'specification.images_to_load.*' \
    > ./prepare_scripts/images_to_load.json

ENTRYPOINT []
CMD []
