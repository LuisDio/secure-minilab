package main

# Rule 1: Improved image tag check
deny[msg] {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    endswith(container.image, ":latest")
    msg := sprintf("Container '%v' uses 'latest' tag which is not allowed. Use a specific version tag", [container.name])
}

# Rule 2: Enhanced security context check
deny[msg] {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.securityContext
    msg := sprintf("Container '%v' is missing security context configuration", [container.name])
}

deny[msg] {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    sc := container.securityContext
    not sc.runAsNonRoot == true
    msg := sprintf("Container '%v' must explicitly set runAsNonRoot: true", [container.name])
}