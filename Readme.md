# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) hub-updater
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/hub-updater/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/hub-updater/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/hub-updater.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/hub-updater.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/hub-updater/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/hub-updater/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![dockeri.co](https://dockeri.co/image/dsuite/hub-updater)](https://hub.docker.com/r/dsuite/hub-updater)

Update docker hub full description.


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Environment variables

<table>
 <thead>
  <tr>
   <th>Env Variable</th>
   <th>Description</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td><code>DOCKER_USERNAME</code></td>
   <td>Docker-hub user name used to login</td>
  </tr>
  <tr>
   <td><code>DOCKER_PASSWORD</code></td>
   <td>Docker-hub user password used to login</td>
  </tr>
  <tr>
   <td><code>DOCKER_IMAGE</code></td>
   <td>Name of the docker image to update<br/>(example: <code>dsuite/hub-updater</code>)</td>
  </tr>
  <tr>
   <td><code>README_FILE</code></td>
   <td>Path to the readme.md file to update to docker hub<br/>(default: <code>/data/README.md</code>)</td>
  </tr>
 </tbody>
</table>


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) How to use it

```bash
    DOCKER_USERNAME="myUserName" 
    DOCKER_PASSWORD="myUserPassword" 
    DOCKER_IMAGE="dsuite/hub-updater" 
    README_FILE="/data/README.md" 

	docker run -t --rm \
		-e DOCKER_USERNAME=${DOCKER_USERNAME} \
		-e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
		-e DOCKER_IMAGE=${DOCKER_IMAGE} \
		-e README_FILE=${README_FILE} \
		-v /path/to/folder:/data \
		dsuite/hub-updater
```


[alpine]: http://alpinelinux.org/
[docker-suite]: https://github.com/docker-suite/
[alpine-base]: https://github.com/docker-suite/alpine-base/
