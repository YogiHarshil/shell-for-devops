#!/bin/bash

<<Task
Deploy a Django app
and handle the code for errors
Task
i
code_clone(){
	echo "Cloning the Django app..."
	git clone https://github.com/YogiHarshil/django-notes-app.git

}

install_requirements(){
	echo"Intalling dependencies"
        sudo apt-get update
	sudo apt-get install docker.io -y 
	sudo apt-get install nginx
}

required_restarts(){
	sudo chown $USER /var/run/docker.sock
	sudo systemctl start docker
	sudo systemctl enable docker
	sudo systemctl start nginx
	sudo systemctl enable nginx
	sudo systemctl restart docker
}

deploy(){
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}

echo "********* DEPLOYMENT STARTED **********"
if ! code_clone; then
	echo"The code directory already exists"
	cd django-notes-app
fi
if ! install_requirements; then 
	echo "Intallation Failed"
	exit 1
fi
if ! required_restarts; then
	echo "System fault identified"
	exit 1
fi
if ! deploy; then
	echo "Deployment Failed"
	# sendmail
	exit 1
fi
echo "********* DEPLOYMENT DONE **********"
