apiVersion: kappctrl.k14s.io/v1alpha1
kind: App
metadata:
  name: tanzu-ingress-additional
  namespace: tanzu-user-managed-packages
  annotations:
    kapp.k14s.io/change-group: tanzu-ingress-additional/app
    kapp.k14s.io/change-rule: "upsert after upserting tanzu-ingress/rbac"
spec:
  serviceAccountName: ingress-sa
  fetch:
  - git:
      url: git@github.com:samarsinghal/gha-workflows-with-gitops-for-tanzu-application-platform
      ref: origin/{{ .git_ref_name }}
      secretRef:
        name: git-ssh-for-carvel
  template:
  - ytt:
      paths:
      - gitops/tanzu/ingress/azure/additional

      valuesFrom:
      - configMapRef:
          name: tanzu-ingress
      - secretRef:
          name: tanzu-ingress
  deploy:
  - kapp: {}
