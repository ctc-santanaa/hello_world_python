# hello_world_python

The goal is to create a small container with a controlled python environment
that will help us print out, 'Hello World' to the console.

# Building the containers

After opening the project in vs code within the development container,
run the "Build" task. That will create the `abd/devexp/proddeploy:1.0` container
in the local docker repo.

# Publishing the container

Running the "Publish Containers" task in vs code. That will build and push
the container to docker hub as `codewala/devexperience:python`

# Running the command

`docker run abd/devexp/proddeploy:1.0`
`docker run codewala/devexperience:python`
