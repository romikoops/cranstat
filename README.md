# README

You can find original task description here ./COUP-Challenge-CRAN.pdf

Assumption: Similarly with https://cran.r-project.org/src/contrib/ this application fetches all
package versions, but keeps last version of each package only.

## Ruby version

2.4.1

## System dependencies

- Postgresql
- Redis
- Bundler

## Configuration

All settings are placed in .env.<ENVIRONMENT> files. As an example, please use '.env.example'

## Deployment instructions

The application is deployed with Heroku

### Production

```
http://
```

### Development

* Prerequisites

```
rake db:create db:migrate
```

```
foreman start -f Procfile.dev
```

And then in browser:

```
http://localhost:3000/
```

### Testing

Prerequisites
```
RAILS_ENV=test rake db:create
```

To execute all tests:
```
rspec
```
