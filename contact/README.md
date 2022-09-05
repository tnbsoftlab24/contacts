# README

This README documents the steps necessary to get the Contact-App Ruby on Rails application up and running locally.
# About
We want a Frontend + Backend application that allows you to create, read, update and delete a list of contacts.
[Demo](https://turbo-contact.herokuapp.com/)


<!-- TOC -->

- [README](#readme)
- [Installation](#installation)
  - [Bundle dependencies](#bundle-dependencies)
  - [Install Ruby](#install-ruby)
  - [Install Node](#install-node)
  - [Setting up dependencies](#setting-up-dependencies)
  - [Clone repository](#clone-repository)
  - [Set up the database](#set-up-the-database)
  - [Install gems and yarn packages:](#install-gems-and-yarn-packages)
  - [Run the app](#run-the-app)
    - [Other commands to run](#other-commands-to-run)
  - [Run the tests](#run-the-tests)

<!-- /TOC -->

# Installation

This describes all that you need to make the app run successfully.

## Bundle dependencies

This includes all infrastructure dependencies ([besides nvm](#install-node)).
To install these required items,
first, make sure you have [homebrew installed and set up](https://brew.sh/).
Afterward, run the following command in the root of the repository:

```
brew bundle
```

## Install Ruby

Install [rvm](https://github.com/rvm/rvm) and Ruby 3.1.0

```
rvm install 3.1.0
```

## Install Node

Install [nvm](https://github.com/nvm-sh/nvm#installing-and-updating) and Node 16.13.1

Install yarn

via `npm install --global yarn` (in your node's version)

or

via homebrew `brew install yarn`

## Setting up dependencies

Put PostgreSQL on the path (zsh example):

```
echo 'export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"' >> ~/.zshrc
```

To run on startup:

```
# to have launchd start postgresql now and restart at login
brew services start postgresql@12
brew services stop postgresql@12
brew services restart postgresql@12
```

## Clone repository

```
git clone https://github.com/tnbsoftlab24/naturetropicale.git
```

### Set up the database

Run rake tasks to create the schema and run any pending migrations.

```bash
bundle exec rake db:setup
bundle exec rake db:migrate
```

To add test data in development, run:

```
bundle exec rake db:seed
```
## Install gems and yarn packages:

Since we are using some yarn packages and `ruby` gems, we need to install all of them by running the commands:

```
gem install bundler
bundle install
yarn install
```

## Run the app

To start the web server, run this command:

```
bin/dev
```

Then open your browser to [http://localhost:3000](http://localhost:3000). You should see the home page of the contact App.

### Other commands to run

There are some other common commands you'll want to run:

```
rails console # interactive console
tail -f log/development.log
```

## Run the tests

To run the tests, run this command:

```
bundle exec rake spec
```

or

```
bundle exec rails spec
```

To set up the test databases needed to run:

```
RAILS_ENV=test bundle exec rake db:setup
```

## Other resources
[Turbo Hotwire](https://turbo.hotwired.dev/)
[Turbo Hotwire](https://hotwired.dev/)