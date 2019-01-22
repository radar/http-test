# HTTP Test

A small test suite to test your HTTP servers to see if they're compatible with `json-server`.

## Installation

Install the dependencies for this project:

```
bundle install
```

## Testing JSON Server

Run a `json-server` _without_ the `-w` option:

```
yarn json-server db.json -p 3001
```

Then run the tests:

```
SERVER=http://localhost:3001 bundle exec rspec
```

These tests should pass as they're built for json-server.

## Testing your Sinatra Server

You can test your sinatra server like this:

```
SERVER=http://localhost:4567 bundle exec rspec
```

These tests should also pass, but only if your Sinatra app's implementation matches json-server's implementation.
