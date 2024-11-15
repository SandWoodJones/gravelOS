from setuptools import setup, find_packages

setup(
    name="unsupOpen",
    version="0.1.0",
    py_modules=["main"],
    entry_points = {
        "console_scripts": [ "unsup-open=main:main" ]
    }
)
