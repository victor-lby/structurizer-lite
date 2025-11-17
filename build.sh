#!/bin/zsh
./gradle clean build && docker build -t structurizr-lite-c4framework:latest . --no-cache