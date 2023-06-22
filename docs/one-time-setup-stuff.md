# one-time-setup-stuff

There are a few important pregame steps:

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

5 - Set the new project params in the shell:

```shell
make prep
...
The new project parameters:
NAME     IS_ACTIVE  ACCOUNT          PROJECT      COMPUTE_DEFAULT_ZONE  COMPUTE_DEFAULT_REGION
default  True       user@domain.tld  projectName  us-west2-a            us-west2
```

4 - Create a project bucket for the Terraform state files:

```
source build.env stage
scripts/setup/create-project-bucket.sh
```

<!--- URLs to supporting Docs --->
[ADC credentials]:https://cloud.google.com/docs/authentication/application-default-credentials
[service accounts]:https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication-configuration
[local file]:https://cloud.google.com/docs/authentication/application-default-credentials#personal
[Google Console]:https://console.cloud.google.com/home/dashboard
