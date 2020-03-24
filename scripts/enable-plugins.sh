#!/usr/bin/env bash
set -euo pipefail

OMERO_WEB_EXEC='docker-compose exec omeroweb /opt/omero/web/OMERO.web/bin/omero'

fpbioimage() {
  if ${OMERO_WEB_EXEC} config get omero.web.apps | grep -q "omero_fpbioimage"; then
    echo "fpbioimage already enabled"
    return
  fi

  ${OMERO_WEB_EXEC} config append omero.web.apps '"omero_fpbioimage"'
  ${OMERO_WEB_EXEC} config append omero.web.open_with '["omero_fpbioimage", "fpbioimage_index", {"script_url": "fpbioimage/openwith.js", "supported_objects": ["image"], "label": "FPBioimage"}]' 
}

webtagging-autotag() {
  if ${OMERO_WEB_EXEC} config get omero.web.apps | grep -q "omero_webtagging_autotag"; then
    echo "webtagging-autotag already enabled"
    return
  fi

  ${OMERO_WEB_EXEC} config append omero.web.apps '"omero_webtagging_autotag"'
  ${OMERO_WEB_EXEC} config append omero.web.ui.center_plugins '["Auto Tag", "omero_webtagging_autotag/auto_tag_init.js.html", "auto_tag_panel"]'
}

webtagging-tagsearch() {
  if ${OMERO_WEB_EXEC} config get omero.web.apps | grep -q "omero_webtagging_tagsearch"; then
    echo "webtagging-tagsearch already enabled"
    return
  fi

  ${OMERO_WEB_EXEC} config append omero.web.apps '"omero_webtagging_tagsearch"'
  ${OMERO_WEB_EXEC} config append omero.web.ui.top_links '["Tag Search", "tagsearch"]'
}

main() {
  fpbioimage
  webtagging-autotag
  webtagging-tagsearch

  ${OMERO_WEB_EXEC} config list
  ${OMERO_WEB_EXEC} web syncmedia
}

main "$@"
