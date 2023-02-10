# fluxed-sops
End to end example of flux not working with sops values with diffs



```
me@mycomputer:/fluxed-sops/fluxed# flux diff kustomization apps --path .
✓  Kustomization diffing...
► Deployment/podinfo/backend drifted

metadata.generation
  ± value change
    - 1
    + 2

spec.template.metadata.annotations.prometheus.io/port
  ± value change
    - 9797
    + ENC[AES256_GCM,data:6DOYZg==,iv:6FJH/3KdGLkNwBRYKiAx5tcoz0fMZFU1aWQqHYOpLi4=,tag:4k9vN4E45T86l3vrxxqJwA==,type:str]
```