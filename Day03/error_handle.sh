#!/bin/bash

create_directory(){
	mkdir test

}

if ! create_directory; then
	echo "The code is being exited as the directory already exists"
	exit 1
fi

echo "This should not work because the code is interrupted"
