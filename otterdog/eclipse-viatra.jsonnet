local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('modeling.viatra', 'eclipse-viatra') {
  settings+: {
    blog: "https://eclipse.dev/viatra"
    description: "The VIATRA project provides a framework for scalable and reactive model queries and transformations.",
    name: "Eclipse VIATRA Project",
    web_commit_signoff_required: false,
    has_discussions: true,
    discussion_source_repository: "eclipse-viatra/org.eclipse.viatra",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/viatra/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('org.eclipse.viatra') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      description: "Main components of the VIATRA framework",
      has_discussions: true,
      homepage: "https://eclipse.dev/viatra",
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
      secrets: [
        orgs.newRepoSecret('SONAR_TOKEN') {
          value: "pass:bots/modeling.viatra/sonarcloud.io/token-org-eclipse-viatra"
        },
      ],
      variables: [
        orgs.newRepoVariable('SONAR_CLOUD_ORGANIZATION') {
          value: "eclipse-viatra",
        },
        orgs.newRepoVariable('SONAR_CLOUD_PROJECT_KEY') {
          value: "eclipse-viatra_org.eclipse.viatra",
        },
      ],
    },
    orgs.newRepo('org.eclipse.viatra.examples') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      has_discussions: true,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
    orgs.newRepo('org.eclipse.viatra.modelobfuscator') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      has_discussions: true,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
    orgs.newRepo('viatra-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      has_discussions: true,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}
