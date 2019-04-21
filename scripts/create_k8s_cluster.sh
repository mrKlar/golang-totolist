minikube start --memory=8192 --cpus=4 \
  --vm-driver=hyperkit \
  --disk-size=30g \
  --extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"

kubectl apply --filename https://github.com/knative/serving/releases/download/v0.5.0/istio-crds.yaml &&
curl -L https://github.com/knative/serving/releases/download/v0.5.0/istio.yaml \
  | sed 's/LoadBalancer/NodePort/' \
  | kubectl apply --filename -

# Label the default namespace with istio-injection=enabled.
kubectl label namespace default istio-injection=enabled

curl -L https://github.com/knative/serving/releases/download/v0.5.0/serving.yaml \
  | sed 's/LoadBalancer/NodePort/' \
  | kubectl apply --filename -

  