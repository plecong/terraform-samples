# Terraform CloudPipeline and CloudBuild Setup

This Terraform module sets up the CodePipeline and CodeBuild resources
to build the code in the [sample/client](../sample/client).

## Configuration

| Variable             | Description                                                                                                                                                                           |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `github_oauth_token` | The token used by CodePipeline to connect to Github. See [GitHub OAuth Token Guide](https://docs.aws.amazon.com/codepipeline/latest/userguide/GitHub-rotate-personal-token-CLI.html). |

## Post Setup

Terraform currently does not have resources for setting up the webhook ([See issue](https://github.com/terraform-providers/terraform-provider-aws/issues/4478)). Instead following [AWS's manual instructions](https://docs.aws.amazon.com/codepipeline/latest/userguide/pipelines-webhooks-create.html), update
the `webhook.json` file to add your Github token, then run the `register-webhook.sh` script or execute the following commands manually:

```
aws codepipeline put-webhook --cli-input-json file://webhook.json
aws codepipeline register-webhook-with-third-party --webhook-name sample_webhook
```

## References

- @stelligent: [Continuous Delivery to S3 via CodePipeline and CodeBuild](https://stelligent.com/2017/09/05/continuous-delivery-to-s3-via-codepipeline-and-codebuild/)
- @stelligent: [Static pipeline](https://github.com/stelligent/devops-essentials/blob/master/samples/static/pipeline.yml)
- [@kylegalbraith](https://twitter.com/kylegalbraith): [How to continuously deploy a static website in style using GitHub and AWS](https://medium.freecodecamp.org/how-to-continuously-deploy-a-static-website-in-style-using-github-and-aws-3df7ecb58d9c)
