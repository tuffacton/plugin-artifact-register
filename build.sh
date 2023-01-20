#!/bin/bash

set -e

ARTIFACT_NAME=$PLUGIN_ARTIFACT_NAME
ARTIFACT_URL=$PLUGIN_ARTIFACT_URL
REPO=$PLUGIN_REPO
TAG=$PLUGIN_TAG

echo "Artifact Name = $ARTIFACT_NAME"
echo "Artifact URL = $PLUGIN_ARTIFACT_URL"

# Make the plugin artifact file

mkdir -p $(dirname $PLUGIN_ARTIFACT_FILE)
cat >"${PLUGIN_ARTIFACT_FILE}" << 'EOF'
{
  "kind": "fileUpload/v1",
  "data": {
    "fileArtifacts": [
      {
        "name": "artifact_name",
        "url": "artifact_url"
      }
    ]
  }
}
EOF

sed -i "s|artifact_name|${ARTIFACT_NAME}|" $PLUGIN_ARTIFACT_FILE
sed -i "s|artifact_url|${ARTIFACT_URL}|" $PLUGIN_ARTIFACT_FILE


cat "${PLUGIN_ARTIFACT_FILE}"

echo "Plugin registration successful!"