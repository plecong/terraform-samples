#!/bin/bash
aws codepipeline put-webhook --cli-input-json file://webhook.json
aws codepipeline register-webhook-with-third-party --webhook-name sample_webhook