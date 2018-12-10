# Mentions

App for saving twitters mentions.

## Install

To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `cd assets && npm install`
* Start Phoenix endpoint with `mix phx.server`
* Check saved mentions on 'http://0.0.0.0:4000/mentions'

## Config

Twitter app credentials

``` elixir
config :extwitter, :oauth, [
    consumer_key: "<consumer_key>",
    consumer_secret: "<consumer_secret>",
    access_token: "<access_token>",
    access_token_secret: "<access_token_secret>"
 ]
```

Twitter username mention (screen_name)

``` elixir
config :mentions,
  ecto_repos: [Mentions.Repo],
  screen_name: "Skoda091"
```

## Description

 A simple app polling someone's mentions on Twitter. Username is set in app config. Each mention is saved in database with name, text, date and amount of retweets.

 App is fetching recent mention every minute and if unique saving to db.