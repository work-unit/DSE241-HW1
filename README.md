# DSE-241 Exercise 1
## Overview
This repository contains the visualizations created for Exercise 1 for DSE 241. The R scripts in this repository create a R Shiny app hosted in a Docker container.
There are two ways to run the code in this repository; 1) Build the Docker image and run a container instance or 2) pull the Docker image from Dockerhub.

## Build Docker Image 
To run the code that produces the shiny app in this repository, follow these instructions.
1. Clone this repository
1. run the following code in your terminal after installing [Docker Desktop](https://www.docker.com/products/docker-desktop).
```
docker build -t my-shiny-app .
```
This code will build the Docker image detailed in the Dockerfile. 
2. Once the image has been built, run the following code in your terminal:
```
docker run --rm -p 3838:3838 my-shiny-app
```
3. Then, launch [localhost:3838](https://localhost:3838) to see the shiny app we have created with our Olympics visualizations included.

## Pulling Docker Image
If you don't want to build the Docker image from scratch, you can alternatively pull this Docker image from [Dockerhub](https://hub.docker.com). 
1. Run the following code from your terminal:
```
docker pull jonahbreslow/shinyapp
```
2. Then, in your terminal run:
```
docker run --rm -p 3838:3838 jonahbreslow/shinyapp
```

## R scripts
If you want to see the code that creates these visualizations, please navigate to `~/app/shiny-app` to view the data preparation procedure as well as the 
Rshiny app creation.

Thank you for reading!
