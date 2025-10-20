package main

deny[msg] {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  container.image == "secure-mini-lab:latest"
  msg := "Image tag 'latest' is not allowed. Use a versioned tag."
}

deny[msg] {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext.runAsNonRoot
  msg := "Containers must run as non-root."
}
