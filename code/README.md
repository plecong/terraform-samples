# Continuous Integration / Deployment

This Terraform module sets up the CodePipeline and CodeBuild resources
to build the code in the [sample/client](../sample/client).

## Configuration

Variable | Description
--- | ---
`github_oauth_token` | The token used by CodePipeline to connect to Github. See [GitHub OAuth Token Guide](https://docs.aws.amazon.com/codepipeline/latest/userguide/GitHub-rotate-personal-token-CLI.html).

## Post Setup

Terraform currently does not have resources for setting up the webhook ([See issue](terraform-providers/terraform-provider-aws#4478)). Instead following [AWS's manual instructions](https://docs.aws.amazon.com/codepipeline/latest/userguide/pipelines-webhooks-create.html), update
the `webhook.json` file to add your Github token, then run the `register-webhook.sh` script or execute the following commands manually:

```
aws codepipeline put-webhook --cli-input-json file://webhook.json
aws codepipeline register-webhook-with-third-party --webhook-name sample_webhook
```