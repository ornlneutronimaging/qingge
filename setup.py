#!/usr/bin/env python
from setuptools import setup, find_packages
import codecs


def read_file(filename):
    """
    Read a utf8 encoded text file and return its contents.
    """
    with codecs.open(filename, 'r', 'utf8') as f:
        return f.read()

setup(
    name = "project",
    version = "0.0.1",
    author = "Qingge Xie, Jiao Lin, Jean Bilheux",
    author_email = "linjiao@ornl.gov, bilheuxjm@ornl.gov",
    packages = find_packages(exclude=['tests', 'notebooks']),
    test_suite = 'tests',
    install_requires = [
        'numpy',
        'pandas',
        'pprint',
    ],
    dependency_links = [
    ],
    description = "Bragg Edge Modeling Package",
    long_description = read_file('README.rst'),
    license = 'BSD',
    keywords = ['neutron','Bragg edge','modeling','imaging'],
    url = "https://github.com/ornlneutronimaging/qingge.git",
    classifiers = ['Development Status :: 3 - Alpha',
                   'License :: OSI Approved :: BSD License',
                   'Topic :: Scientific/Engineering :: Physics',
                   'Intended Audience :: Developers',
                   'Programming Language :: Python', 
                   'Programming Language :: Python :: 3.5',
                   'Programming Language :: Python :: 3.6',
                   'Natural Language :: English'],
)

# End of file
