---
title: "blank_project"
author: Giovanni Marelli
date: 2020-02-29
rights:  Creative Commons Non-Commercial Share Alike 3.0
language: en-US
output: 
	md_document:
		variant: markdown_strict+backtick_code_blocks+autolink_bare_uris+markdown_github
---

# blank_project


## getting started 

### installation

Install the relevant libraries with python>=3.6

```
pip3 install -r requirements.txt
```
### docker 

Build the docker container from the Docker file

```
docker build .
```

### start

Start the service 

```
./script/start_server.sh
```

### apache

Eventually activate apache and do a proxy on the port to avoid CORS restrictions

```
./script/apache.sh
```

configuration files in:

```
./conf/antani_apache.conf
./conf/antani-apache-le-ssl.conf
./onc/enable_proxy.sh
```
## testing

test scripts are in the folder

```
tests/
```

### examples

In the folder `examples` there are few applications to run the library independently from the backend

