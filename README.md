# README

Terrible Sudoku implementation used as a Rails playground.

## Configuration

```shell
bundle
yarn
rails db:migrate
```

## Running

Start the server with

```shell
rails s
```

Start the Sidekiq scheduler (used to update the time spent solving each puzzle) with

```shell
bundle exec sidekiq
```

Run the tests with
```shell
rails t
```