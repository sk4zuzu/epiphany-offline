
ARG DESTINATION_IMAGE
ARG NAME

FROM epiphany-offline-${NAME}-prepare_scripts-update AS epiphany

# Continue in a clean environment.

FROM ${DESTINATION_IMAGE}

ARG SUBSCRIPTION_USERNAME
ARG SUBSCRIPTION_PASSWORD

RUN : REGISTER REDHAT SUBSCRIPTION \
 && subscription-manager register \
    --username "${SUBSCRIPTION_USERNAME}" \
    --password "${SUBSCRIPTION_PASSWORD}" \
    --auto-attach \
    --force

RUN : ENABLE REQUIRED REDHAT REPOSITORIES \
 && subscription-manager repos \
    --enable rhel-7-server-rpms \
    --enable rhel-7-server-extras-rpms \
    --enable rhel-server-rhscl-7-rpms

RUN : UPDATE YUM CACHE \
 && yum makecache

RUN : INSTALL REQUIRED PACKAGES \
 && yum install -y \
    ca-certificates \
    sudo wget gpg curl

COPY --from=epiphany /workspaces/epiphany/core/src/epicli/prepare_scripts/ /prepare_scripts/

WORKDIR /prepare_scripts/

ARG HOST_UID
ARG HOST_GID

VOLUME /output_directory/

ENTRYPOINT []

CMD : COLLECT ALL REQUIRED EPIPHANY OFFLINE SOFTWARE \
 && ./download-requirements.sh /output_directory/ \
 && : COPY THE "IMAGES TO LOAD" LIST \
 && cp /prepare_scripts/images_to_load.json /output_directory/ \
 && : SET PROPER FILE PERMISSIONS \
 && exec chown -R ${HOST_UID}:${HOST_GID} /output_directory/

# vim:ts=2:sw=2:et:syn=dockerfile:
