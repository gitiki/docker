# Gitiki as Docker container

Gitiki is an open source PHP wiki engine from a Git repository (or not).

## How to use

Starting a Gitiki instance is simple:

```bash
$ docker run --detach --name "some-gitiki" --volume "/your/wiki/path:/srv/wiki" --publish "1234:80" gitiki/gitiki
```
