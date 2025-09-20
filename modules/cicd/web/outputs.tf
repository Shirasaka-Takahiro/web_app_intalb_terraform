output "codebuild_project_name" {
  value = aws_codebuild_project.project.name
}

output "codedeploy_app_name" {
  value = aws_codedeploy_app.default.name
}

output "codedeploy_deployment_group_name" {
  value = aws_codedeploy_deployment_group.default.deployment_group_name
}

output "codepipeline_arn" {
  value = aws_codepipeline.pipeline.arn
}

output "codestarconnections_connection_arn" {
  value = aws_codestarconnections_connection.default.arn
}

output "bucket_id" {
  value = aws_s3_bucket.default_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.default_bucket.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.default_bucket.bucket_domain_name
}

output "bucket_name" {
  value = aws_s3_bucket.default_bucket.bucket
}