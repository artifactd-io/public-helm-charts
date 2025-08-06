# Artifactd Helm Charts

## Regenerating Helm chart READMEs
### Linux
```shell
cd artifactd-self-hosted
docker run --rm --volume "$(pwd):/helm-docs" -u $(id -u) jnorwood/helm-docs:latest
```

### Windows
```shell
cd artifactd-self-hosted
docker run --rm --volume "$(pwd):/helm-docs" jnorwood/helm-docs:latest
```