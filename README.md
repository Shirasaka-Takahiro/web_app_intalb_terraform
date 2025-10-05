■About
1. Web + APP + CI/CD
2. Web and App component are to be created in a different service
3. Web component(service) will proxy the traffic to App component(service) by DNS

■Order to deploy
1. env/${env}/common/network
2. env/${env}/common/domain
3. env/${env}/web
4. env/${env}/app
5. env/${env}/cicd/cicd_web
6. env/${env}/cicd/cicd_app

■How to work CI/CD
1. Create Github repository for each component
2. Confirm Codestar Connection of each component on AWS console 
3. Push code to Github repository
4. CodePipeline will work

■Repository
1. WEB: https://github.com/Shirasaka-Takahiro/nginx_docker (Private)
2. APP: https://github.com/Shirasaka-Takahiro/php-fpm_docker (Private)

■Resources
<br />
Network
<br />
ECS Fargate (Web and app)
<br />
ACM
<br />
ALb (HTTPS Listener)
<br />
Route53
<br />
CodeStartConnections(GitHub)
<br />
CodeBuild
<br />
CodeDeploy
<br />
CodePipeline
<br />
CloudWatch
<br />
IAM
<br />

■Infrastracture
<pre>
.
├── README.md
├── env
│   └── dev
│       ├── app
│       │   ├── app.tf
│       │   ├── backend.tf
│       │   ├── outputs.tf
│       │   ├── remote_state.tf
│       │   ├── terraform.tfvars
│       │   └── variables.tf
│       ├── cicd
│       │   ├── cicd_app
│       │   │   ├── backend.tf
│       │   │   ├── cicd_app.tf
│       │   │   ├── outputs.tf
│       │   │   ├── remote_state.tf
│       │   │   ├── terraform.tfvars
│       │   │   └── variables.tf
│       │   └── cicd_web
│       │       ├── backend.tf
│       │       ├── cicd_web.tf
│       │       ├── outputs.tf
│       │       ├── remote_state.tf
│       │       ├── terraform.tfvars
│       │       └── variables.tf
│       ├── common
│       │   ├── domain
│       │   │   ├── backend.tf
│       │   │   ├── domain.tf
│       │   │   ├── outputs.tf
│       │   │   ├── terraform.tfvars
│       │   │   └── variables.tf
│       │   └── network
│       │       ├── backend.tf
│       │       ├── network.tf
│       │       ├── outputs.tf
│       │       ├── terraform.tfvars
│       │       └── variables.tf
│       └── web
│           ├── backend.tf
│           ├── outputs.tf
│           ├── remote_state.tf
│           ├── terraform.tfvars
│           ├── variables.tf
│           └── web.tf
└── modules
    ├── cicd
    │   ├── app
    │   │   ├── codebuild.tf
    │   │   ├── codedeploy.tf
    │   │   ├── codepipeline.tf
    │   │   ├── codestartconnections.tf
    │   │   ├── iam.tf
    │   │   ├── iam_json
    │   │   │   ├── codebuild_assume_role.json
    │   │   │   ├── codebuild_build_policy.json
    │   │   │   ├── codedeploy_assume_role.json
    │   │   │   ├── codedeploy_deploy_policy.json
    │   │   │   ├── codepipeline_assume_role.json
    │   │   │   ├── codepipeline_event_bridge_assume_role.json
    │   │   │   ├── codepipeline_event_bridge_policy.json
    │   │   │   └── codepipeline_pipeline_policy.json
    │   │   ├── outputs.tf
    │   │   ├── s3.tf
    │   │   └── variables.tf
    │   └── web
    │       ├── codebuild.tf
    │       ├── codedeploy.tf
    │       ├── codepipeline.tf
    │       ├── codestartconnections.tf
    │       ├── iam.tf
    │       ├── iam_json
    │       │   ├── codebuild_assume_role.json
    │       │   ├── codebuild_build_policy.json
    │       │   ├── codedeploy_assume_role.json
    │       │   ├── codedeploy_deploy_policy.json
    │       │   ├── codepipeline_assume_role.json
    │       │   ├── codepipeline_event_bridge_assume_role.json
    │       │   ├── codepipeline_event_bridge_policy.json
    │       │   └── codepipeline_pipeline_policy.json
    │       ├── outputs.tf
    │       ├── s3.tf
    │       └── variables.tf
    ├── common
    │   ├── domain
    │   │   ├── acm.tf
    │   │   ├── outputs.tf
    │   │   ├── route53.tf
    │   │   └── variables.tf
    │   └── network
    │       ├── ecs_cluster.tf
    │       ├── network.tf
    │       ├── outputs.tf
    │       └── variables.tf
    └── resource
        ├── app
        │   ├── alb.tf
        │   ├── cloudwatch.tf
        │   ├── container_definition
        │   │   └── container_definition.json
        │   ├── ecr.tf
        │   ├── ecs.tf
        │   ├── iam.tf
        │   ├── iam_json
        │   │   ├── fargate_task_assume_role.json
        │   │   └── task_execution_policy.json
        │   ├── outputs.tf
        │   ├── route53.tf
        │   ├── securitygroup.tf
        │   └── variables.tf
        └── web
            ├── alb.tf
            ├── cloudwatch.tf
            ├── container_definition
            │   └── container_definition.json
            ├── ecr.tf
            ├── ecs.tf
            ├── iam.tf
            ├── iam_json
            │   ├── fargate_task_assume_role.json
            │   └── task_execution_policy.json
            ├── outputs.tf
            ├── route53.tf
            ├── securitygroup.tf
            └── variables.tf
</pre>