# Integration Provider API Docs

Site generator for the provider facing integration API

Deployed to https://passfort.github.io/integration-docs/

Built using [Slate](https://github.com/slatedocs/slate)

### Dev Usage

1. Clone this repository
2. Initialize and start middleman:

```shell
bundle config set path 'vendor/bundle'
bundle install
bundle exec middleman server
```

You can now see the docs at http://localhost:4567.


### Building for Deployment

To build the static site for upload to a web server, use `middleman build`:

```shell
bundle exec middleman build --clean
rsync -avz build/* www@host.com:/wwwroot/
```
