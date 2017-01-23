# Cdb-sync-manager-client

CDB Sync Manager provides a GUI for creating import synchronizations between CartoDB and a given Postgres database. The API backend for this tool can be found here: https://github.com/MAPC/cdb-sync-manager

## Sync from a list of database tables, pulled dynamically from a specified database

![Sync from a list of database tables](https://github.com/MAPC/cdb-sync-manager-client/blob/master/M73d4cf9QA.gif?raw=true "Logo Title Text 1")

## Manually sync or delete existing syncs

![Manually Sync or Delete existing syncs](https://github.com/MAPC/cdb-sync-manager-client/blob/master/ka3b0vt1He.gif?raw=true)

## How to deploy
Because this uses a submodule, I can't create a push to deploy button.

However, here are some basic instructions:

```sh
$ heroku buildpacks:clear
$ heroku buildpacks:add --index 1 heroku/nodejs
$ heroku buildpacks:add --index 2 heroku/ruby
$ heroku config:unset SKIP_EMBER
```
### Required Environment Variables:
API_KEY: CartoDB API Key
ADMIN_USER
ADMIN_PASSWORD

WARNING: Admin user and pass MUST be set - they have default in the app.

You are ready to deploy:

```bash
$ git push heroku master
```

### Postgres

The app uses a database to store database configurations. This allows it to show available tables in the GUI. 

Be sure to run `rake db:migrate`. Then, visit `/admin`, login, and create a new "Connection Configuration." Then you should be able to use the GUI.