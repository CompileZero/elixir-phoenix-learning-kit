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

#### 