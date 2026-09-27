# running ai apps

belt gives you access to ai apps from your terminal. no api keys to manage per-provider — one `belt login` and you can run anything.

## image generation

```bash
# search for image models
belt app search "image"

# check what inputs a model needs
belt app get openai/gpt-image-2
belt app sample openai/gpt-image-2

# generate an image
belt app run openai/gpt-image-2 --input '{"prompt": "a neon city at night, cyberpunk style"}'

# or use other providers
belt app run reve/create --input '{"prompt": "a neon city at night, cyberpunk style"}'
belt app run pruna/p-image --input '{"prompt": "a neon city at night, cyberpunk style"}'

# upscale
belt app run pruna/p-image-upscale --input '{"image_url": "https://..."}'
```

## video generation

```bash
belt app search "video"

# text to video
belt app run google/veo-2 --input '{"prompt": "a timelapse of a flower blooming"}'

# image to video
belt app run seedance/seedance-2-i2v --input '{"image_url": "https://...", "prompt": "gentle camera pan"}'
```

## llms

```bash
belt app run anthropic/claude --input '{"prompt": "explain quantum computing in one paragraph"}'
belt app run google/gemini --input '{"prompt": "summarize this article", "context": "..."}'
```

## web search

```bash
belt app run tavily/search --input '{"query": "latest rust 2026 features"}'
belt app run exa/search --input '{"query": "best practices for go error handling", "num_results": 5}'
```

## audio

```bash
# text to speech
belt app run elevenlabs/tts --input '{"text": "hello world", "voice": "adam"}'

# music generation
belt app search "music generation"
```

## batch processing

```bash
# generate sample input, modify it, run
belt app sample openai/gpt-image-2 --save input.json
# edit input.json...
belt app run openai/gpt-image-2 --input input.json

# use jq to process results
belt app run tavily/search --input '{"query": "..."}' --json | jq '.results[].url'
```
