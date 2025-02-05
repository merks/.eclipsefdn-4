local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-simrel') {
  settings+: {
    default_repository_permission: 'none',
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "SimRel provides infrastructure for coordinating the release of projects used to build Eclipse IDE/RCP applications.",
    members_can_change_project_visibility: false,
    name: "Eclipse Simultaneous Release",
    packages_containers_internal: false,
    packages_containers_public: false,
    readers_can_create_discussions: true,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/simrel/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('simrel.build') {
      allow_update_branch: false,
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          bypass_pull_request_allowances+: [
            "@fredg02",
            "@merks"
          ],
          required_approving_review_count: 0,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('simrel.tools') {
      allow_update_branch: false,
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          bypass_pull_request_allowances+: [
            "@fredg02",
            "@merks"
          ],
          required_approving_review_count: 0,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
  ],
}
