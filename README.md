# poem-blog
Poem blog

## setup

```bash
git submodule update --init --recursive
```

## dev

```bash
hugo server -D
```

## build

```bash
hugo --gc --minify && git add -A && git commit -m "build"
```
