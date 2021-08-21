# rsvisa-python

Python image Dockerfile baked with a R&amp;S VISA in order to test with instruments. The utilized R&S VISA version is 5.12.3.

## Getting started

Start the Docker image by calling

```shell
docker run -it -p 4880:4880 --entrypoint /bin/bash docker.io/casabre/rsvisa-python:3.8
```

Port 4880 is the HiSLIP control channel which can be utilized for VXI11 connections too.

In the container, you can install now pyvisa for instance and run Python

```shell
root@container: pip install pyvisa
root@container: python
```

In the Python REPL, you can import pyvisa for controlling your instruments.

```Python
>>> import pyvisa
>>> rm = pyvisa.ResourceManager()
>>> instr = rm.open_resource('tcpip::your.ip.address::INSTR')
>>> print(instr.query('*IDN?'))
```
