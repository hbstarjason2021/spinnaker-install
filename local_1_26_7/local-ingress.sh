####

cat >> spinnaker-ingress.yml <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: spinnaker
  namespace: spinnaker
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
  - host: deck.hbstarjason.spinnaker
    http:
     paths:
     - path: /
       pathType: Prefix
       backend:
          serviceName: spin-deck
          servicePort: 9000
  - host: gate.hbstarjason.spinnaker
    http:
     paths:
      - path: /
        pathType: Prefix
        backend:
          serviceName: spin-gate
          servicePort: 8084
EOF

kubectl apply -f spinnaker-ingress.yml 

