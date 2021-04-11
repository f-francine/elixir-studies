# How to build a Phoenix + Ecto application

- [1] To create a phoenix application, run the command:
`mix phx.new _your_app_name_ --no-ecto --no-html --no-dashboard --no-webpack --no-gettext`
##### Note¹: I am using `--no-ecto` because I want to create and configure it step by step.

- [2] Let's add the doker-compose file to our project:
##### Note²: Docker-compose is where we will configure our database and make ecto conenct to it
 - In your docker-compose.yaml file, set the database image you wanna use. In our case is **postgres**
 - After that, lets set the ports to our postgre image run
 - In everironment, we define our user and password to log in our database
 - Last, we set the service we wanna use to administrate our database. In this case, let's use adminer
So, in the end, our docker-compose file will be more or less like this:

```
version: "3.1"
services:
  db:
    image: postgres:13.2-alpine
    ports:
      - 5432:5432
    environment:
      POSTGRES_USER: "user"
      POSTGRES_PASSWORD: "user"
  adminer:
    image: adminer
    ports:
      - 8080:8080
```

- [3] Now it's time to create and configure ecto:
 - First of all, let's add ecto and postgrex depencies to our project:
  - in mix.exs, inside function `deps` add:
```
 {:ecto_sql, "~> 3.0"},
    {:postgrex, ">= 0.0.0"}
```
 - Run the command `mix deps.get`to install the depencies
 - Now, lets generate our database running the command: <br>
`mix ecto.gen.repo -r YourAppName.Repo`


After all of it, let's set up our docker container in the terminal with <br>
`docker-compose up`

And finally create our database: <br>
`mix ecto.create`

If everything went well, you'll receive a message like this:
**The database for YourAppName.Repo has been created**

Since we have our database, let's generate our tables.
To do that, let's run the command <br>`mix ecto.gen.migration table_name`

###### Important: To run the command above, make sure you have the following folders inside your projec <br>  `priv/repo/migrations` <br> Otherwise, you'll receive an error message. <br> So, to create that, just go to your project root and create the folders above.

Inside migrations, you probably have a file with a very crazy name (lots of numbers plus the migration name you create. <br>
Inside this file, you probably have some code like this:

```
defmodule YourAppName.Repo.Migrations.TableName do
  use Ecto.Migration

  def change do

  end
end
```

Let's add some code to this migration to create a new table called "people", with a few columns in it:
and run <br>`mix ecto.migrate`to create our migration.

If everything went well, you'll receive a message like this `22:25:21.291 [info]  == Migrated 20210409011323 in 0.0s`
You can go to `localhost:8080` (witch is the adress we defined in our docker-compose file and also in config.exs inside our project), fill the informations according to the config.exs file, and you'll see a table just as we created :)

### Now, let's create our schemas
- In `lib/_your_app_name_/` we will create a file, that I will call `users.ex`. Here we will map our tables.


