# Tem Açaí
> An API to show Açaí sellers that are current open

## Setup

- Clone this project with `git clone git@github.com:desenvolvendo-me/tem_acai.git`
- Move to tem_acai directory `cd tem_acai`
- Run `docker-compose up -d` to start Postgres database
- Run `bundle install`
- Run `rails db:create db:migrate` to create the project database

## Running

- Run this project with `rails s`
- Access the api endpoints through `http://localhost:3000/api/v1/{endpoint}`

## Testing

- Run `rspec`