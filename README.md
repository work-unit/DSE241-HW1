# DSE-241 Exercise 1
## Overview
This repository contains the visualizations created for Exercise 1 for DSE 241. The R scripts in this repository create a R Shiny app hosted in a Docker container.
There are two ways to run the code in this repository; 1) Build the Docker image and run a container instance or 2) pull the Docker image from Dockerhub.

## Install Docker
To run the code that produces the shiny app in this repository, follow these instructions.
1. Install Docker Desktop from this link: https://www.docker.com/products/docker-desktop.

## Pulling Docker Image
2. Run the following code from your terminal:
```
docker pull jonahbreslow/shinyapp
```
3. Then, in your terminal run:
```
docker run --rm -p 3838:3838 jonahbreslow/shinyapp
```

4. Then, launch https://localhost:3838 in your browser to see the shiny app we have created with our Olympics visualizations.

## R scripts
If you want to see the code that creates these visualizations, please navigate to `shiny-app/` to view the data preparation procedure as well as the Rshiny app creation:
	- data-prep-script.R (data preprocessing);
	- app.R (loads all of the data and creates the visualiztion).

Thank you for reading!
