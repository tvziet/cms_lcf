# README

## Description
> Used to manage employees of multiple subsidiaries of a company. In addition, the main purpose is to manage digital documents in businesses.

## Setup without Docker

```bash
cp .env.example .env
```

Update ENV variables, then run commands:

```bash
rails db:create
```

```bash
rails db:migrate
```

```bash
rails db:seed
```

## Setup with Docker
```
docker-compose up
```
