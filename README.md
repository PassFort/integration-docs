# Integration Provider API Docs

Site generator for the provider facing Passfort Partner API

Deployed to https://passfort.github.io/integration-docs/ by a GitHub Action
using the a token from the `github-deploy` account: see under the `.github`
directory.

Built using [Slate](https://github.com/slatedocs/slate)

# Experimental branch

We plan to move to generating a large portion of these docs from OpenAPI schema. 

The tool [widdershins](https://github.com/Mermade/widdershins) can be used to generate files compatible with `slate` as follows

```
widdershins --summary --environment schema/config.json schema/one-time-polled-screening.json -o source/experimental.html.md.erb
```

The generated documentation site can then be viewed by following the normal instructions below.



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
