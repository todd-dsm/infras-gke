# infras-gke

This is a simple representation of a GKE cluster. The code herein is raw and for the purpose of experimenting with some pipeline stuff; it is not for perfect GKE code, yet.

---

## Getting Started

Check the docs for [one-time setup steps].

Source-in the project variables to your environment:

`source scripts/setup/build.env <stage|prod>`

Set the project specifics in the shell and check the output:

```bash
make prep
...
The new project parameters:
NAME     IS_ACTIVE  ACCOUNT          PROJECT      COMPUTE_DEFAULT_ZONE  COMPUTE_DEFAULT_REGION
default  True       user@domain.tld  projectName  us-west2-a            us-west2
```

If this all looks good you're ready to start Terraforming.

`make tf-init`, `make plan` and `make apply` or, just `make all`. 

---

[one-time setup steps]:https://github.com/todd-dsm/infras-gke/blob/master/docs/one-time-setup-stuff.md