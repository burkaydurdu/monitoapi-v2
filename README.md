# Monito API Service

## Development Environment Setup

### 0. Install Xcode

You will need Xcode, write in your terminal:

```
xcode-select --install
```

If you get the following message, you can just skip this step and go to next step.

```
# command line tools are already installed, use "Software Update" to install updates
```

### 1. Homebrew
Homebrew is “the missing package manager for OS X”. To install Homebrew enter this command in your terminal:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### 2. rbenv
If you already use RVM and know how to use it, skip this step.

rbenv is a ruby version manager. Install it:
```
brew install rbenv ruby-build
```
Now, you are ready to install the latest ruby version, and set it as the default version.

### 3. Ruby version
For example, if the version is `2.5.8` run (assuming you have rbenv):

```
rbenv install 2.5.8
```

Set it as your system default (not mandatory):

```
rbenv global 2.5.8
```

Then restart your Terminal.
```
ruby -v
```
You should see something starting with ruby 2.5.8.

### 4. PostgreSQL

```
brew install postgresql
```

Once you've done that, let's check if it worked:

```bash
psql -d postgres
```

If you enter a new prompt like this one, you're good!

```bash
psql (9.4.4)
Type "help" for help.

postgres=#
```

### 5. Setup DB and installing the Ruby dependencies

Navigate to the repo’s main folder and type

```
gem install bundler foreman
bundle install
rails db:create
rails db:migrate
```
For Ubuntu users: You have to create a Postgres user with your OS account name before executing "rails db:create", otherwise it fails. Although not tested, might be required for other distros too.

### 6. Running the server locally

To start API, type in main folder

```    
foreman start --port=3000
```

## Code Quality

### Brekeman
A static analysis security vulnerability scanner.

```
bundle exec brakeman
```

### Bundler Audit

```
bundle exec bundle audit check --update
```

### Lint (Rubocop)
A Ruby static code analyzer and formatter.
```
bundle exec rubocop --format simple
```

## Test

### Rspec Test
There are model, request tests in project (29)
```
bundle exec rspec
```

## Dockerize

```sh
$ docker-compose up --build
$ docker-compose exec api rails db:create
$ docker-compose exec api rails db:migrate
```
After these initial commands everytime you need to run the project you can just use;

```sh
$ docker-compose start
$ docker-compose stop
```

or

```sh
$ docker-compose up
$ docker-compose down
```

## Health Check

URL: **http://localhost:3000/health_check** <br>
username: monito-admin<br>
password: m1n2t3<br>
