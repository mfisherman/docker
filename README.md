# Docker

A selection of dockerfiles that I made over time. Images are available on [docker hub](https://hub.docker.com/u/mfisherman).


## Getting Started

The project relies on docker.
For each dockerfile/docker image, an according subfolder exists including a README that explains how to use the docker image.


### Prerequisites

You need docker installed on your machine to build the dockerfiles and run the images.
Follow the [installation](https://docs.docker.com/v17.12/install/) as described by docker.


### Creating Images

Go into the according directory and create the image, e.g.:
```
cd mpich
sudo docker build . -t mpich:3.3.2
```

If you wish to create a docker image for a different architecture, follow the steps described in the [docker documentations](https://docs.docker.com/docker-for-mac/multi-arch/) that user buildx.


## Artifacts

The docker images are available on [docker hub](https://hub.docker.com/u/mfisherman) for different architectures (including ARM for Raspberry Pi).


## Contributing

Any contributions you make are **greatly appreciated**.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request


## License

This project is licensed under CC BY-NC-SA 4.0 see the [LICENSE](LICENSE) file for details or [the CC website](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Note that the docker images on docker hub are not part of this project and are published under the according docker hub license.