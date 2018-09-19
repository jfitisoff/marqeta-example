# marqeta-example
Some sample tests for Marqeta's "Core" API.

The tests use an API client I've been experimenting with.

## Setup
1. Clone the repo.

2. Add a `credentials.yml` file to the root of the repo. This file should store valid credentials for the core API (format below.)

3. Run bundler to install dependencies.

To run the spec: `bundle exec rspec users_spec.rb`

There's also a console app that loads the API: `bundle exec ./console.rb`

### credentials.yml
Here's how `credentials.yml` needs to be formatted (file should be written to the root dir of the repo.):

```
base_url: BASE_URL_HERE
app_token: APP_TOKEN_HERE
access_token: ACCESS_TOKEN_HERE
```
