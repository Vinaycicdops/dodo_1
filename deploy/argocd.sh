
PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)




argocd login localhost:8081 --grpc-web --insecure --username admin --password $PASSWORD


argocd app create ledger-api \
  --repo https://github.com/Vinaycicdops/dodo_1.git \
  --path deploy \
  --dest-namespace ledger-api \
  --dest-server https://kubernetes.default.svc \
  --sync-policy automated \
  --auto-prune \
  --self-heal \
  --upsert
# 4. Trigger the initial manual sync
argocd app sync ledger-api