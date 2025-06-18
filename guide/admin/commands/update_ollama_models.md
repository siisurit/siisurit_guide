# update_ollama_models

Ensure that all relevant Ollama models are available. If necessary, pull any missing models.

Currently, this refers to the models set with the environment variables [SII_OLLAMA_CHAT_MODEL](../configuration/environment-file.md#sii_ollama_chat_model) and [SII_OLLAMA_EMBEDDING_MODEL](../configuration/environment-file.md#sii_ollama_embedding_model).

## Example

To make sure all relevant Ollama models are readily available:

```bash
python manage.py update_ollama_models
```
