#!/usr/bin/env bash
set -euo pipefail

# NOTE (BNR): For some magical reason the group of /OMERO changes to root when
#             this container starts. This is a last ditch effort to reverse the
#             group change so omero can run properly.
sudo chown -R omero-server:omero-server /OMERO
