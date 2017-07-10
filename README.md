# Cdb-sync-manager-client

CDB Sync Manager provides a GUI for creating import synchronizations between CartoDB and a given Postgres database. The API backend for this tool can be found here: https://github.com/MAPC/cdb-sync-manager

## Sync from a list of database tables, pulled dynamically from a specified database

![Sync from a list of database tables](https://github.com/MAPC/cdb-sync-manager-client/blob/master/M73d4cf9QA.gif?raw=true "Logo Title Text 1")

## Manually sync or delete existing syncs

![Manually Sync or Delete existing syncs](https://github.com/MAPC/cdb-sync-manager-client/blob/master/ka3b0vt1He.gif?raw=true)

## Steps and troubleshooting for adding new datasets
To add a new dataset, click the "Add New Connection" button in the top right. You will see a form in which you can choose the database and table. In the schema field, you will have to manually type the correct schema (often it is simply "tabular"). 

### Caveats
1. The sync is stuck on "Created"
This probably means it failed to sync. Click "delete now", refresh, and try again, but make sure the table in question is setup with correct permissions. If you are in the process of adding several new connections, you may need to pause for a few minutes as the database server gets overloaded sometimes.

2. The new datasets aren't appearing in the external [Data Catalog](databrowser.mapc.org). 
This requires two additional steps:
a. Re-sync the `tabular._data_browser` table
This table is is the crosswalk that tells the data catalogue where everything is and how to connect to it. 
b. Login to the mapc-admin.carto.com account and set all new datasets to "public"
Sadly, Carto defaults datasets to "private" on enterprise accounts. We're communicating with their team about this. 

3. Check for duplicates
If Carto sees a dataset with the same name, it will simply append `_2` to the end of the dataset once it's synced. This will cause issues for the data catalogue! Double-check mapc-admin.carto.com for this.

## Updating datasets
Currently, datasets are set to re-sync every 6 months by default. This helps keep data fresh in case anything is missed. To re-sync immediately, maintainers can use this app. Simply find the dataset by its table name, and click "Sync Now". 

## Metadata
Right now, metadata needs to be synced manually by specifying a "tablename" argument in the synchronization, and prefixing the table name with `meta_`. The Data Catalogue is set to find metadata tables by prefixing the table name with `meta_`. This is because metadata and data are being sync'd to the same Carto account, which exist under the same table schema so they cannot share the same table name. 

There are better ways to handle this including:
1. Creating a separate Carto "seat" for metadata, which would mirror our system.
2. Updating this application to create another sync for the metadata automatically. 

## The Future
Carto's SQL API is an immensely powerful tool that addresses many of Data Services needs. However, the management of data through the Carto Synchronization API is unsustainable because over 200 connections must be maintained and updated with the use of shims like this. It would be a better investment of time to stand up the Carto SQL API and point it to our data browser. See this fork of Carto's SQL API for the start of that work: https://github.com/MAPC/carto-sql-api-heroku. 

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
