apiVersion: kappctrl.k14s.io/v1alpha1
kind: App
metadata:
  name: tanzu-data-services
  namespace: tanzu-package-repo-data-services
  annotations:
    kapp.k14s.io/change-rule.create-order: "upsert after upserting tanzu-data-services/rbac"
    kapp.k14s.io/change-rule.delete-order: "delete before deleting tanzu-data-services/rbac"
spec:
  serviceAccountName: tanzu-data-services-sa
  fetch:
  - git:
      url: git@github.com:samarsinghal/gha-workflows-with-gitops-for-tanzu-application-platform
      ref: origin/{{ .git_ref_name }}
      secretRef:
        name: git-ssh-for-carvel
  template:
  - ytt:
      paths:
      - gitops/tanzu/data-services/base

      valuesFrom:
      - configMapRef:
          name: tanzu-data-services
      - secretRef:
          name: tanzu-data-services
  deploy:
  - kapp: {}
