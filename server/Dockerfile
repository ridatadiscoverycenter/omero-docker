FROM openmicroscopy/omero-server:5.6.1

ARG CERTS_DIR=/opt/omero/server/OMERO.server/certs
ARG OMERO=/opt/omero/server/OMERO.server/bin/omero

ARG LDAP_URL
ARG LDAP_BASE_DN
ARG LDAP_PASSWORD
ARG LDAP_USERNAME
ARG LDAP_USER_MAPPING

# NOTE(BNR): Additional plugins must be installed by root in the virtual
#            environment. Everything else will happen as omero-server.
USER root
RUN source /opt/omero/server/venv3/bin/activate \
    && pip install omero-certificates

RUN yum install -y postgresql12 && yum clean all


# NOTE(BNR): For whatever lucky reason, we can set config values via the
#            interactive script at build time even if omero isn't running. We
#            take advantage of that to build up our images so we don't need to
#            mount special config directories, or config after the container
#            has started.
USER omero-server
RUN mkdir -p "${CERTS_DIR}" \
    && "${OMERO}" config set omero.glacier2.IceSSL.DefaultDir "${CERTS_DIR}" \
    && "${OMERO}" certificates

RUN "${OMERO}" config set omero.ldap.config true \
    && "${OMERO}" config set omero.ldap.urls "${LDAP_URL}" \
    && "${OMERO}" config set omero.ldap.base "${LDAP_BASE_DN}" \
    && "${OMERO}" config set omero.ldap.username "${LDAP_USERNAME}" \
    && "${OMERO}" config set omero.ldap.password "${LDAP_PASSWORD}" \
    && "${OMERO}" config set omero.ldap.user_mapping "${LDAP_USER_MAPPING}"
