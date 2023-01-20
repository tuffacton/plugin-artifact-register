
# artifact-register
Harness/Drone plugin for registering an arbitrary artifact as a file-upload artifact for a Build step.

## Usage

One stage variable need to be set:
```
variables:
  - name: PLUGIN_ARTIFACT_FILE
    type: String
    description: ""
    value: /addon/tmp/.plugin/artifact
```

See the example Harness YAML. The following need to be done:
* The following output variables need to be set in a previous step:
  * `ARTIFACT_URL` - the URI for your Artifact
  * `ARTIFACT_NAME` - The name for your Artifact
* The following need to be set as settings for the Plugin. This might need to be done in the YAML:
  * `artifact_url` - Example would be `<+steps.Find_Artifact.output.outputVariables.ARTIFACT_URL>` where `Find_Artifact` is the name of the previous step.
  * `artifact_name` - Example would be `<+steps.Find_Artifact.output.outputVariables.ARTIFACT_NAME>`

## Example Harness step YAML
```yaml
pipeline:
  projectIdentifier: Nic_Sandbox
  orgIdentifier: Sandbox
  tags: {}
  stages:
    - stage:
        name: Plugin Testing
        identifier: Build
        type: CI
        spec:
          cloneCodebase: false
          execution:
            steps:
              - step:
                  type: Run
                  name: Find Artifact
                  identifier: Find_Artifact
                  spec:
                    connectorRef: Nics_Registry
                    image: ubuntu:22.04
                    shell: Sh
                    command: |-
                      export ARTIFACT_URL=https://www.amazon.com/
                      export ARTIFACT_NAME=Amazon
                    outputVariables:
                      - name: ARTIFACT_URL
                      - name: ARTIFACT_NAME
              - step:
                  type: Plugin
                  name: Register Artifact
                  identifier: create_artifact
                  spec:
                    connectorRef: Nics_Registry
                    image: tuffacton/registerartifact
                    settings:
                      artifact_url: <+steps.Find_Artifact.output.outputVariables.ARTIFACT_URL>
                      artifact_name: <+steps.Find_Artifact.output.outputVariables.ARTIFACT_NAME>
                    entrypoint:
                      - /build.sh
                    imagePullPolicy: Always
                  description: Registers an arbitrary artifact URI in a pipeline execution.
        variables:
          - name: PLUGIN_ARTIFACT_FILE
            type: String
            description: ""
            value: /addon/tmp/.plugin/artifact
```

# contributing notes

Be sure to add `--platform linux/amd64` to your `docker build` step if you're building on a Mac or Windows system as the CPU architecture might not play nice on Harness K8S.