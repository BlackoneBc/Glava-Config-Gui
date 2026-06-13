from setuptools import setup, find_packages

setup(
    name="glava-config-gui",
    version="1.0.0",
    description="A GTK4/Libadwaita GUI to configure the glava audio visualizer",
    author="BlackoneBc",
    author_email="jlm2@freenet.de",
    url="https://github.com/BlackoneBc/Glava-Config-Gui",
    license="MIT",
    python_requires=">=3.8",
    install_requires=[
        "PyGObject>=3.40.0",
    ],
    entry_points={
        "console_scripts": [
            "glava-config-gui=glava_config_gui:main",
        ],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: End Users/Desktop",
        "Topic :: Multimedia :: Sound/Audio",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Environment :: X11 Applications :: GTK",
    ],
)
