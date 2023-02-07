# Portable Development Environment

The portable development environment is intended to reduce complexity for development teams in an effort to standardize the execution and configuration that is needed locally to run, debug, test, and deploy code for your team. The portable development environment helps maintain multiple projects that teams are responsible for by managing the underlying tooling (and versioning of that tooling) that is ultimately used during the development process. This can include things like what version of Python is run when executing aws scripts, even when that version differs by project. 

The aim of this project is that once a team has configured their portable environment, it can be shared across the team to provide a single starting point to get up and running from scratch, across platforms, without worry of any specific individual's setup or OS. 


---
## Portable Development Environment: Build -> Run -> Interact
---
1. The portable development environment can be started by running the provided python "init.py" file from your terminal. 
    `python3 init.py`
2. The script should create and spin up a new docker container that you can start a terminal session using the following command: 
    `docker exec -it portable_dev /bin/bash`



---
### TODO:
1. If the image is already built/running: Ask if user wants to change auto startup behavior (startup at login)
    - Also don't recreate the image every time unless user wants a fresh start (WARN THIS WILL RESET ALL FILES: WORK CAN BE LOST)
    - Add a "Are you sure" prompt before wiping everything out
2. Make run argument that allows user to immediately be presented with a logged in terminal after container is spun up
3. Update "install_deps.sh" to handle more detailed dpkg json config and remove hard coded lines
4. Make the git repository a script argument and use as a volume with "-v" docker run argument
    - Just don't do anything if not provided
