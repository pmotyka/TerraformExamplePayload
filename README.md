# TerraformExamplePayload

This is a template and example for using terraform to deploy AWS Lambdas, using importable Github-based modules for the lambda definition, and for the pipeline.

Example consumer of:
https://code.amazon.com/packages/TerraformLambdaModule/trees/mainline
https://code.amazon.com/packages/TerraformCodePipelineModule/trees/mainline

To deploy the pipeline for this project, run `./scripts/deploy_pipeline.sh`
This will create the pipeline, which in turn will run the terraform found in the conventionally location `terraform/payload` (according to https://code.amazon.com/packages/TerraformCodePipelineModule/trees/mainline)