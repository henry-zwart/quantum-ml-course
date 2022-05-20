# -*- coding: utf-8 -*-
from setuptools import find_packages, setup

setup(
    name="quantum-ml-course",
    version="0.1",
    packages=find_packages(exclude=["tests*"]),
    description="A python package for prototyping CV for seabird bycatch",
    url="https://github.com/dragonfly-science/CV-seabirds",
    author="Henry Zwart",
    author_email="henrybzwart@gmail.com",
    include_package_data=True,
)
