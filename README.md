# Gitiki as Docker container

Gitiki is an open source PHP wiki engine from a Git repository (or not).

## How to use

Starting a Gitiki instance is simple:

```bash
$ docker run --name some-gitiki -v /your/wiki/path:/srv/wiki -p 1234:80 -d gitiki/gitiki
```
