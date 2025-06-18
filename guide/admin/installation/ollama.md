# Ollama setup

[Ollama](https://ollama.com/) is a platform that enables to run large language models (LLMs) directly on a local computer or a server within your own infrastructure. Ollama has a [library pf models](https://ollama.com/library) that can be downloaded for private use.

## Local installation

Ollama can be downloaded and installed from <https://ollama.com/download>.

For macOS with [homebrew](https://brew.sh/), you can install it with:

```bash
brew install ollama
```

To automatically run it as a service on startup, set up a service:

```bash
brew services start ollama
```

## Docker installation

Alternatively, you can run ollama from the [compose.yaml](../configuration/compose-file.md). For example:

```yaml
services:
  ollama:
    container_name: "siisurit-ollama"
    image: ollama/ollama:0.9.1
    volumes:
      - ollama-data:/root/.ollama
    env_file:
      - "./.env"

volumes:
  ollama-data:
```

After that, add set the environment variable to `.env`

```dotenv
SII_OLLAMA_URL=http://ollama:11434/
```

or extend the `backend` in your `compose.yaml` with an `environment`:

```yaml
services:
  backend:
    # ...
    env_file:
      - ".env"
    environment:
      SII_OLLAMA_URL: "http://ollama:11434/"
```
