# poem-blog
Poem blog

## Hugo

### setup

```bash
git submodule update --init --recursive
```

### dev

```bash
hugo server -D
```

### build

```bash
hugo --gc --minify && git add -A && git commit -m "build"
```

## uv

### Install dependencies

```bash
uv sync
```

### ruff, black

```bash
uv run ruff check .
```

```bash
uv run black .
```

### Run

```bash
uv run python main.py
```
