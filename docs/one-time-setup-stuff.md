# one-time-setup-stuff

## Install Required Programs

* [homebrew] - the macOS package manager
* [gcloud]
    * macOS: `brew install google-cloud-sdk`
    * Then install the [gke-gcloud-auth-plugin]: `gcloud components install gke-gcloud-auth-plugin -q` 
* [keybase] - used to cryptographically validate the Terraform package
    * macOS: `brew install --cask keybase`
    * Install it, open it and configure it.
    * **Leave `keybase` running during the Terraform install**
* [Terraform] (but I just use `tfenv`)
    * `brew install tfenv` [quickstart]
* [IntelliJ] Community Edition
    * macOS: `brew install intellij-idea-ce`
        * install the Terraform plugin
        * Preferences > Plugins > Search: [Terraform and HCL]
        * Install this plugin and restart IntelliJ
* [helm] 3.x
    * macOS: `brew install kubernetes-helm`
    * [Debian/Ubuntu]

---

## Configuration Steps:

1 - Configure [ADC credentials] for local Terraform use; this is the quick-n-dirty method but it's completely safe.

`gcloud auth application-default login`

Follow this path through the web browser and agree; this creates a [local file]. Export the variable assignment in the correct place for your system. For Oh My ZSH, it would look something like:

```shell
% grep GOOGLE ~/.oh-my-zsh/custom/environment.zsh
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json"
```

Pull this new parameter into the shell

```shell
% exec zsh
% echo "$GOOGLE_APPLICATION_CREDENTIALS"
/Users/userName/.config/gcloud/application_default_credentials.json
```

_NOTE: Using Terraform-specific [service accounts] to authenticate with GCP is the recommended practice._

2 - Create the new Projects in the [Google Console]; a good place to start would be something like:

* staging: `myProject=projectName-stage`
* prod: `myProject=projectName`

I named this one `infras-gke` and `infras-gke-stage`.

This new project name goes in the file `build.env` as the value to the variable `TF_VAR_project`.

3 - While you're in `build.env`, may as well set all Organization, Project and any Security-related parameters and values as well.

Source-in the project variables to your environment:

`source build.env <stage|prod>`

4 - Set the new project params in the shell:

```shell
make prep
...
The new project parameters:
NAME     IS_ACTIVE  ACCOUNT          PROJECT      COMPUTE_DEFAULT_ZONE  COMPUTE_DEFAULT_REGION
default  True       user@domain.tld  projectName  us-west2-a            us-west2
```

5 - Create a project bucket for the Terraform state files:

```
scripts/setup/create-project-bucket.sh
```

Then you should be ready to start Terraforming!

<!--- URLs to supporting Docs --->

[homebrew]:https://brew.sh/
[gcloud]:https://cloud.google.com/sdk/docs/install-sdk
[gke-gcloud-auth-plugin]:https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
[kubectl]:https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-with-homebrew-on-macos
[native package management]:https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
[ktx]:https://github.com/heptiolabs/ktx
[Linux-install]:https://docs.aws.amazon.com/eks/latest/userguide/install-gke-gcloud-auth-plugin.html
[keybase]:https://keybase.io/docs/the_app/install_macos
[Terraform and HCL]:https://plugins.jetbrains.com/plugin/7808-terraform-and-hcl
[IntelliJ]:https://www.jetbrains.com/idea/
[helm]:https://helm.sh/docs/intro/install/#from-homebrew-macos
[Terraform]:https://www.hashicorp.com/blog/announcing-hashicorp-homebrew-tap
[quickstart]:https://gist.github.com/todd-dsm/1dc120506e89ec36d4d9a05ccb93f68c
[ADC credentials]:https://cloud.google.com/docs/authentication/application-default-credentials
[service accounts]:https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication-configuration
[local file]:https://cloud.google.com/docs/authentication/application-default-credentials#personal
[Google Console]:https://console.cloud.google.com/home/dashboard
