# rsvisa-python

Python image Dockerfile baked with a R&amp;S VISA in order to test with instruments. The utilized R&S VISA version is 5.12.3.

## Getting started

Building the Docker image by calling

```shell
docker build --build-arg="python" --build-arg="3.8" -t rsvisa-python:3.8 .
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
