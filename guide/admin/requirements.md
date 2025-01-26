# Requirements

## Skills

In order to install and operate Siisurit, you need:

- Be comfortable working in the terminal and have a grasp of its essential commands like `cd`.
- Understand how environment variables work.
- Be comfortable working with configuration files in various text formats (YAML, CSV, ...). A modern text editor with syntax highlighting is recommended.
- Be comfortable to analyze log files in case things go wrong.

While this guide aims to provide concise examples you can modify to your own requirements, you still need to be able to do so and decide by yourself where to make which modification to what end.

## Infrastructure

In order to run Siisurit in your own infrastructure, you need a machine capable of running [Docker](https://www.docker.com/). Some examples are:

- An Intel compatible computer running [Ubuntu](https://ubuntu.com/). At the time of this writing, Ubuntu 24 is the current long time support version, which we use for testing inhouse.
- An M-family Apple Macintosh with macOS 15,

The actual resources needed largely depend on the amount of data and users are supposed to be processed. A good starting point should be:

- 4+ GB of RAM
- 4+ CPU cores
- 5+ GB of additional storage
