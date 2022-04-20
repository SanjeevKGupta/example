#### Preparing the operator tar

This approach uses ansible to build the operator tar. In this implementation, `make` based build process fully automates the tasks of building the operator tar.

#### `templates` directory 

**Required**
- deployment.yaml - Responsible for creeating the appliation pod

Optional but typically always needed
- service.yml - To create a service that can be used to access the service provided by the application pod 
- route.yml - Applcaible for deployment on OCP 

#### `tasks` directory

- main.yml is used by the ansible operator to orchestrate the deployment of applciation resources.
