# Contributing

This document describes how to build the documentation yourself using [MkDocs](https://www.mkdocs.org/).

## Set up project

1. Fork the [GitHub project](https://github.com/siisurit/siisurit_guide/issues) and create a local working copy.
2. Install [uv](https://docs.astral.sh/uv/).
3. Open a terminal, cd into the working copy you just created and run:
   ```bash
   sh scripts/set_up_project.sh
   ```

## Working with the project

To build the documentation, run:

```bash
sh scripts/build_guide.sh
```

After that, to browse the local copy, run:

```bash
uv run mkdocs serve
```

## Adding and changing documents

Refer to the [MkDocs user guide](https://www.mkdocs.org/user-guide/).
