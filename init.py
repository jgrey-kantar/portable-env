import os
import platform
import subprocess

if platform.system() == "Linux":
    try:
        subprocess.run(["docker", "--version"], check=True, stdout=subprocess.DEVNULL)
    except:
        print("Error: Docker is not installed on this system.")
        exit(1)
elif platform.system() == "Windows":
    try:
        subprocess.run(["docker.exe", "--version"], check=True, stdout=subprocess.DEVNULL, shell=True)
    except:
        print("Error: Docker is not installed on this system.")
        exit(1)
else:
    print("Error: This script is not supported on this operating system.")
    exit(1)

subprocess.run(["docker", "build", "-t", "portable_dev", "."])
subprocess.run(["docker", "run", "--name", "portable_dev", "-it", "--detach", "portable_dev"])

