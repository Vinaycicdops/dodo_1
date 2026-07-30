# Makefile for ledger-api deployment and GitOps management

.PHONY: all setup namespace service-account rbac config secrets service ingress rollout policies argocd-install sync status help

# Default target
all: namespace service-account rbac config secrets service policies rollout ingress

help:
	@echo "Available commands (run from inside deploy/ directory):"
	@echo "  make all             - Apply all Kubernetes manifests in correct order"
	@echo "  make namespace       - Create the ledger-api namespace"
	@echo "  make service-account - Create hardened ServiceAccount (automountServiceAccountToken: false)"
	@echo "  make rbac            - Apply Admin, Developer, and Operator RBAC roles & bindings"
	@echo "  make config          - Apply ConfigMaps"
	@echo "  make secrets         - Apply Secrets"
	@echo "  make service         - Apply Service"
	@echo "  make ingress         - Apply Ingress rule (ledger-api.local)"
	@echo "  make rollout         - Apply Argo Rollout (Canary deployment)"
	@echo "  make policies        - Apply Kyverno ClusterPolicies (disallow-root, disallow-latest-tag, verify-signatures)"
	@echo "  make argocd-install  - Install ArgoCD and Argo Rollouts CRDs"
	@echo "  make sync            - Run ArgoCD CLI login & app sync script"
	@echo "  make status          - Check status of pods, services, rollouts, and policies"

setup:
	@echo "==> Enabling Minikube Ingress addon..."
	minikube addons disable ingress || true
	minikube addons enable ingress

namespace:
	@echo "==> Applying namespace..."
	kubectl apply -f namespace.yaml

service-account:
	@echo "==> Applying hardened ServiceAccount..."
	kubectl apply -f service-account.yaml

rbac:
	@echo "==> Applying RBAC Roles and Bindings..."
	kubectl apply -f rbac.yaml

config:
	@echo "==> Applying ConfigMap..."
	kubectl apply -f config.yaml

secrets:
	@echo "==> Applying Secrets..."
	kubectl apply -f secrets.yaml

service:
	@echo "==> Applying Service..."
	kubectl apply -f service.yaml

ingress:
	@echo "==> Applying Ingress..."
	kubectl apply -f ingress.yaml

rollout:
	@echo "==> Applying Argo Rollout..."
	kubectl apply -f rollout.yaml

policies:
	@echo "==> Applying Kyverno ClusterPolicies..."
	kubectl apply -f kyverno-policies.yaml

argocd-install:
	@echo "==> Installing ArgoCD..."
	kubectl create namespace argocd || true
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	@echo "==> Installing Argo Rollouts Controller..."
	kubectl create namespace argo-rollouts || true
	kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

sync:
	@echo "==> Triggering ArgoCD sync..."
	bash argocd.sh

status:
	@echo "==> Workload Status (ledger-api namespace):"
	kubectl get pods,svc,ingress,rollout -n ledger-api
	@echo "==> Kyverno ClusterPolicies Status:"
	kubectl get clusterpolicy
	@echo "==> ArgoCD Application Status:"
	kubectl get application -n argocd


# istioctl install --set profile=demo -y