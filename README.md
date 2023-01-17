[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# rsvisa-python

Python image Dockerfile baked with a R&amp;S VISA in order to test with instruments. The utilized R&S VISA version is 5.12.3. Furthermore, `pyvisa` is already pre-installed and configured to use R&S VISA.

## Getting started

Building the Docker image by calling

```shell
docker build --build-arg=PYTHON_INTERPRETER="python" --build-arg=PYTHON_VERSION="3.8" -t rsvisa-python:3.8 .
```

Start the Docker image by calling

```shell
docker run -it rsvisa-python:3.8
```

In the Python's REPL of the container, you can import pyvisa for controlling your instruments.

```Python
>>> import pyvisa
>>> rm = pyvisa.ResourceManager()
>>> instr = rm.open_resource('tcpip::your.ip.address::INSTR')
>>> print(instr.query('*IDN?'))
```

## License

The Dockerfile is licensed under [LICENSE](LICENSE). With Dockerfile building and execution you are accepting all listed 3rd party license under the [`/licenses`](licenses) folder.