# marqeta-example
Some sample tests for Marqeta's "Core" API, including a limited API definition and a very simple factory for users.

I used a [REST client that I'm working on](https://github.com/jfitisoff/klient) to build the client that the tests are using (the client lib is still very much a WIP.)

## Setup
1. Clone the repo.

2. Add a `credentials.yml` file to the root of the repo. This file should store valid credentials for the core API (format below.)

3. `bundle install` to install dependencies.

To run the spec: `bundle exec rspec spec/users_spec.rb`

There's also a console app that loads the API: `bundle exec ./console.rb`

*Note:* You must use bundler when running tests or using the console.

### credentials.yml
Here's how `credentials.yml` needs to be formatted (this file should be written to the root dir of the repo.):

```
base_url: BASE_URL_HERE
app_token: APP_TOKEN_HERE
access_token: ACCESS_TOKEN_HERE
```
