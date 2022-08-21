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
          service:
            Name: spin-deck
            Port: 
              number: 9000
  - host: gate.hbstarjason.spinnaker
    http:
     paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            Name: spin-gate
            Port: 
              number: 8084
EOF

kubectl apply -f spinnaker-ingress.yml 

