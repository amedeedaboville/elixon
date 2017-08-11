# Elixon

Elixon is a Phoenix port of [Mastodon](github.com/tootsuite/mastodon).

It is currently heavily unfinished. Check the progress in the Issues.

## Why Phoenix/Elixir?

Here is why I'm writing it: 
* Mostly for fun
* To try out the Phoenix Ecosystem
* To see the performance boost of Phoenix in a 'real-world' use case
* To get a better handle on Rails -> Phoenix re-writes

## Usage

To start your Elixon server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Production

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).
