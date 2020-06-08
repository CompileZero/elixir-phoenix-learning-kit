### What is Phoenix?

Phoenix's job is to behave as a web-server
It communicates with a database and can also communicate with HTML, JSON & Web Sockets
![phoenix](media/phoe1.png)

Database: Traditionally used PostgreSQL, but can use anything (MySQL, SQLite, MongoDb)

#### How phoenix handles incoming requests?

Look at our previous project in Elixir to create an identicon!
![identicon](media/ident.png)

The exact same steps will be followed to handle an HTTP Request
![How Phoenix Works](media/08-44-16.png)



## Create a new project in Phoenix

```elixir
> mix phx.new discuss 
```
Here `mix` is a build tool, `phx.new` command creates a new phoenix project (Earlier, it was phoenix.new), `discuss` is the name of the project.

#### The app that we are building

![The Project we are building](media/08-53-21.png)

A Forum kind of a project! Where users sign-up to the forum with `Github` (using O-Auth), they can post anything that serves as a topic of discussion, They can create a topic, and other users can comment on it. (Imagine like a reddit clone)

#### First Steps:

The first command would be `mix ecto.create`

This command will create the PostGres database for out Project.

At first you may get an error message like this
```bash

atharvakulkarni@Atharvas-MacBook-Pro discuss (master)]$ mix ecto.create
Compiling 14 files (.ex)
Generated discuss app

09:01:09.385 [error] GenServer #PID<0.375.0> terminating
** (DBConnection.ConnectionError) tcp connect (localhost:5432): connection refused - :econnrefused
    (db_connection 2.2.2) lib/db_connection/connection.ex:87: DBConnection.Connection.connect/2
    (connection 1.0.4) lib/connection.ex:622: Connection.enter_connect/5
    (stdlib 3.13) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
Last message: nil
State: Postgrex.Protocol
** (Mix) The database for Discuss.Repo couldn't be created: killed

```
This is because the username and password does not seem to match for our PostGres Database.


#### How to solve the PostGres Connection Refused Error (Phoenix Project)
To solve this issue, go to the dev.exs file in `*your project name (discuss)*/config/**dev.exs**`
![Dev.exs Configuration File](media/09-08-31.png)

Here, most likely, your username value would show `postgres`. This is the default username provided by postgres and we don't want to use that. 

```bash
> whoami
atharvakulkarni
```
1. In your terminal, type the command `whoami`, you will receive your username, paste it in the `username` field in the `dev.exs` folder.
2. Run the `mix ecto.create`

```bash
> mix ecto.create
Compiling 14 files (.ex)
Generated discuss app
The database for Discuss.Repo has been created

```
#### Starting the phoenix LiveServer

1. Execute in Terminal : `mix phx.server`
2. It starts the server at `localhost:4000`
3. You will be displayed with a nice welcome screen

![Phoenix Initial Welcome Screen](media/09-18-46.png)

#### Server Side Templating vs SPA in Phoenix

![Server Side Templating vs SPA](media/20-28-57.png)

Phoenix supports both the types, initially we start with Server Side Templating, and later on, as we deep-dive into Phoenix, we can head over to SPA kind of an architecture.

The main difference between SSR and SPA is that, whenever the user performs any action, a fresh HTTP request is sent to the server, whereas in SPA, the client (User's Web browser) already loads the entire HTML Document from the server, so when a link is clicked, it does not send a fresh HTTP Request to the server.

#### Setting up Material Design in Phoenix

Head over to [Materialize CSS](https://materializecss.com/getting-started.html), and copy the CSS CDN. We won't be needing JS CDN in this project.

Head over to `projects/3-phoenix-list/discuss/lib/discuss_web/templates/layout` and in the `app.html.eex` page