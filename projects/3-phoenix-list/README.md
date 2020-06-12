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

``` elixir
> mix phx.new discuss
```

Here `mix` is a build tool, `phx.new` command creates a new phoenix project (Earlier, it was phoenix.new), `discuss` is the name of the project.

### The app that we are building

![The Project we are building](media/08-53-21.png)

A Forum kind of a project! Where users sign-up to the forum with `Github` (using O-Auth), they can post anything that serves as a topic of discussion, They can create a topic, and other users can comment on it. (Imagine like a reddit clone)

#### First Steps:

The first command would be `mix ecto.create`

This command will create the PostGres database for out Project.

At first you may get an error message like this

``` bash
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

``` bash
> whoami
atharvakulkarni
```

1. In your terminal, type the command `whoami`, you will receive your username, paste it in the `username` field in the `dev.exs` folder.
2. Run the `mix ecto.create`

``` bash
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


#### 💡 Whenever starting the liveServer, make sure you have PostGres running. I have installed PostGres as an application, so its easier for me that way

![PostGres Application Screenshot](media/08-15-46.png)

#### Server Side Templating vs SPA in Phoenix

![Server Side Templating vs SPA](media/20-28-57.png)

Phoenix supports both the types, initially we start with Server Side Templating, and later on, as we deep-dive into Phoenix, we can head over to SPA kind of an architecture.

The main difference between SSR and SPA is that, whenever the user performs any action, a fresh HTTP request is sent to the server, whereas in SPA, the client (User's Web browser) already loads the entire HTML Document from the server, so when a link is clicked, it does not send a fresh HTTP Request to the server.

#### Setting up Material Design in Phoenix

Head over to [Materialize CSS](https://materializecss.com/getting-started.html), and copy the CSS CDN. We won't be needing JS CDN in this project.

Head over to `projects/3-phoenix-list/discuss/lib/discuss_web/templates/layout` and in the `app.html.eex` page, paste the CDN link.

Run the project by the command [`mix phx.server`](#starting-the-phoenix-liveserver)

💡 Tip: Make sure you have PostGres SQL running on your machine, otherwise you may see a lot of errors in your terminal.

### MVC in Phoenix

To Understand the MVC (Model-View-Controller) Paradigm, let us consider an analogy:

You want to summarise the process of making muffins to someone else. There are essentially 3 components involved:

1. The batter itself which is the raw material required to produce muffins
2. A muffin tray, which puts the batter in a very distinctive shape and size.
3. A cook, who puts the batter in the muffin tray.

Similarly, while generating a web page like the following:

![Generating a web Page](media/20-49-14.png)

##### The following components are involved in the process:

![Model-View-Controller Explanation](media/20-49-48.png)

Similar to the previous analogy:

![MVC with Analogy](media/20-50-44.png)

💡 The controller (Cook) looks out for a particular data required, for Example : "My Customer requires Blueberry Muffins, so I'm going to make Blueberry Muffins!", Similiarly the controller knows what kind of data the user wants on the UI, and hence takes that particular data from the Model.

🌟 MVC Architecture is not limited to Object Oriented Programming! It can also be applied to Functional Programming paradigm and pretty much any other programming paradigm.

> <b>☄️ MVC Paradigm &lt;=&gt; MVC Architecture &lt;=&gt; MVC Pattern (People use these terms interchangeably but they essentially mean the same `most of the time`</b>)

#### What happens when the User makes a request (HTTP, JSON, image, media) to the application

![HTTP Request for Phoenix](media/21-05-24.png)

#### Controller & Router

In the router.ex

``` elixir
scope "/", DiscussWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
```

The above code just means

> whenever we make a request for the index page (Eg: localhost:4000 <=> localhost:4000/ )
> activate the controller called as `PageController`

Now, `PageController` is a module defined in the `projects/3-phoenix-list/discuss/lib/discuss_web/controllers/page_controller.ex`

### What happens in the `page_controller.ex` 

```elixir
def index(conn, _params) do
    render(conn, "index.html")
  end

```

The `render` function renders the `index.html` file along with data in the `conn` object.

The name `PageController` is a default controller to work with when we first generate our project. Our actual project would consist of other controllers and this one would be deleted.



### Views vs Templates in Phoenix

In the `projects/3-phoenix-list/discuss/lib/discuss_web/views/page_view.ex` page_view.ex file, we have a module defined as `PageView`. 

What does Phoenix do behind the scenes?

1. It takes the module-name `PageView` and searches for the string `Page` (the prefix of PageView), and searches for a "page" folder in the "templates" folder. 
2. If found, it executes all the files present in the "page" folder.

![Views vs Templates](media/08-18-21.png)

Executing the code:


```bash
[atharvakulkarni@Atharvas-MacBook-Pro discuss (master ✗)]$ iex -S mix phx.server
Erlang/OTP 23 [erts-11.0] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

[info] Running DiscussWeb.Endpoint with cowboy 2.8.0 at 0.0.0.0:4000 (http)
[info] Access DiscussWeb.Endpoint at http://localhost:4000
Interactive Elixir (1.10.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> 
nil

iex(3)> DiscussWeb.PageView
DiscussWeb.PageView
iex(4)> DiscussWeb.PageView.render("index.html")
{:safe,
 ["<section class=\"phx-hero\">\n  <h1>", "Welcome to Phoenix!",
  "</h1>\n  <p>Peace-of-mind from prototype to production</p>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a\n          href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\"\n          >v1.5 Changelog</a\n        >\n      </li>\n      <li>\n        <a href=\"https://google.com\">Google</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\"\n          >#elixir-lang on Freenode IRC</a\n        >\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"]}

```

Here, phoenix directly renders the Index.html page, by executing the "page" folder files directly from PageView module.

💡 The names of our Views, Templates, Models & Controllers are closely linked. So naming conventions are important in elixir & phoenix.

### The Model Layer in Phoenix

💡 Phoenix does not care which database you use, but PostGres functionality comes out-of-the-box for the Phoenix Framework. So we have used PostGres Db.


Phoenix knows that there is a database, but does not know what data is in the database.

![PostGres / Database Model](media/08-42-39.png)

#### We will create Topic Models
![Topic Models](media/08-45-10.png)

#### Working with Lists

1. Initially we have an empty database.
2. We tell PostGres to setup an empty table called "Topics"
3. This is called Db Migration, where you provide the Db with some instructions to create tables in the Db.

### Creating Migration Files

```bash
[atharvakulkarni@Atharvas-MacBook-Pro discuss (master ✗)]$ mix ecto.gen.migration add_topics
* creating priv/repo/migrations/20200610032037_add_topics.exs

```
You can see the the file is created in :
`projects/3-phoenix-list/discuss/priv/repo/migrations/20200610032037_add_topics.exs`

#### Creating a table

in the ...add_topics.exs file above, append the following code:

```elixir
def change do
    create table(:topics) do
      add :title, :string
    end
  end
```

This code:
1. Creates a table with the name "topics"
2. Adds 1 column: "title" with the type "string"

After you save the code, run this command in terminal:

```bash
[atharvakulkarni@Atharvas-MacBook-Pro discuss (master ✗)]$ mix ecto.migrate

08:56:13.008 [info]  == Running 20200610032037 Discuss.Repo.Migrations.AddTopics.change/0 forward

08:56:13.011 [info]  create table topics

08:56:13.148 [info]  == Migrated 20200610032037 in 0.1s
```

You will be able to see that the migration happened almost effortlessly. This means that, now Phoenix knows, that there is a table called "topics" with a column called "title" in our Db.


#### Looking at out Db Visually

Install a GUI Tool for PostGres: Postico (Download for Mac from [here](https://eggerapps.at/postico/))

This tool will help us visualise the databases and tables we will create further.

![Postico Edit Settings](media/09-03-33.png)

Postico Default Settings:
1. A favourite is created. Add a name "local"
2. The Host and Port is default.
3. The Username is your username
4. The Database is "discuss_dev" which we have just created.
5. Click on "Connect"

![Db Connected Postico](media/09-05-39.png)

You see that a table with the name "Topics" has been created. If you go to the table, you will see a blank table with 2 columns:
1. id
2. title

This means that our Db migration was successful. And whenever we will add any data to this table, thro' Phoenix, the data will be shown in the GUI.


#### "Add new Topic"

We want to create a page, where the user can Add New Topics to our Database,
Here is a list of potential problems and solutions for our new page:

![Add Topics Problems and Solutions](media/09-09-57.png)
![Add Topics Problems and Solutions 2](media/09-11-01.png)

#### Adding a route to our controller

In the `router.ex` file, add a line of code as follows

```elixir
scope "/", DiscussWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/topics/new", TopicController, :new #New Line
  end

```
What Happens here? The line of code means
1. Whenever the user visits the path "topics/new" page, activate the `Topic Controller`, and execute the `new` function

 Phoenix follows restful conventions:

![Common Conventions](media/09-19-04.png)

### Setting up Topic Controller

1. Create a new file `topic_controller.ex` in `projects/3-phoenix-list/discuss/lib/discuss_web/controllers/`
2. Add the following code:
  ```elixir
  defmodule DiscussWeb.TopicController do
    
  end
  ```
3. Run `mix phx.server` in the terminal.

  ![Undefined Error Messages](media/09-25-59.png)

4. You will be shown an error message: *...init/1* is undefined, meaning no init function is defined in our `TopicController` module
5. We have to **inherit** another base class called "ControllerBaseClass" which has certain default functions already defined in Elixir, ![Cont Base Class](media/09-30-07.png)
6. But there is no such provision to "inherit" a class in Elixir (It is not object-oriented right?)
7. We have 3 solutions for this kind of a problem ![Import Keywords](media/09-31-40.png)
8. The Import Keyword:![Import Keyword](media/09-32-27.png) (Topic Controller has both add and log functions/methods)
9. The alias keyword: ![Alias Keyword](media/09-33-17.png) ![Alias Keyword 2](media/09-34-21.png) (Calling Math.add works as well because it is a direct reference to the function, but we use alias, and then we can directly use add function without "Math.")

[topic_controller.ex]
```elixir
defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  def new(conn, params) do
    IO.puts("++++")
    IO.inspect(conn)
    IO.puts("++++")
    IO.inspect(params)
    IO.puts("++++")
  end
end
```

#### 📔 Code Explanation

1. This code is used to debug our /topics/new page, when it throws an error. `puts` is used to append the line on the terminal whereas `inspect` is used to loop through the entire structure/function and output every line on the terminal.
2. 🏔 Conn is an object in Elixir Struct, that represents both the Incoming and Outgoing Requests in our webpage. It is one of the most important objects for a web-project.
   ```bash
   %Plug.Conn{
  adapter: {Plug.Cowboy.Conn, :...},
  assigns: %{},
  before_send: [#Function<0.73641281/1 in Plug.CSRFProtection.call/2>,
   #Function<2.102658996/1 in Phoenix.Controller.fetch_flash/2>,
   #Function<0.105793137/1 in Plug.Session.before_send/2>,
   #Function<0.60895335/1 in Plug.Telemetry.call/2>,
   #Function<0.18437642/1 in Phoenix.LiveReloader.before_send_inject_reloader/2>],
  body_params: %{},
  cookies: %{"_ga" => "GA1.1.38883163.1590675858"},
  halted: false,
  host: "localhost",
  method: "GET",
  owner: #PID<0.566.0>,
  params: %{},
  path_info: ["topics", "new"],
  path_params: %{},
  port: 4000,
  private: %{
    DiscussWeb.Router => {[], %{}},
    :phoenix_action => :new,
    :phoenix_controller => DiscussWeb.TopicController,
    :phoenix_endpoint => DiscussWeb.Endpoint,
    :phoenix_flash => %{},
    :phoenix_format => "html",
    :phoenix_layout => {DiscussWeb.LayoutView, :app},
    :phoenix_request_logger => {"request_logger", "request_logger"},
    :phoenix_router => DiscussWeb.Router,
    :phoenix_view => DiscussWeb.TopicView,
    :plug_session => %{},
    :plug_session_fetch => :done
  },
  query_params: %{},
  query_string: "",
  remote_ip: {127, 0, 0, 1},
  req_cookies: %{"_ga" => "GA1.1.38883163.1590675858"},
  req_headers: [
    {"accept",
     "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
    {"accept-encoding", "gzip, deflate, br"},
    {"accept-language", "en-US,en;q=0.9"},
    {"connection", "keep-alive"},
    {"cookie", "_ga=GA1.1.38883163.1590675858"},
    {"host", "localhost:4000"},
    {"sec-fetch-dest", "document"},
    {"sec-fetch-mode", "navigate"},
    {"sec-fetch-site", "none"},
    {"sec-fetch-user", "?1"},
    {"upgrade-insecure-requests", "1"},
    {"user-agent",
     "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36"}
  ],
  request_path: "/topics/new",
  resp_body: nil,
  resp_cookies: %{},
  resp_headers: [
    {"cache-control", "max-age=0, private, must-revalidate"},
    {"x-request-id", "Fhe1OlxaueAX_SwAAAIC"},
    {"x-frame-options", "SAMEORIGIN"},
    {"x-xss-protection", "1; mode=block"},
    {"x-content-type-options", "nosniff"},
    {"x-download-options", "noopen"},
    {"x-permitted-cross-domain-policies", "none"},
    {"cross-origin-window-policy", "deny"}
  ],
   ```
   #### 📔 1. As you can see, the object has 2 kinds of params, one for the incoming requests (like cookies, halted, host, method etc.) and one for output responses (outgoing requests like resp-headers, resp-cookies, resp-body etc.)
   #### 2. Since we are not sending any data in the body, the `resp.body` is `nil`
3. On the web-page, you might see an error like this : `expected action/2 to return a Plug.Conn, all plugs must receive a connection (conn) and return a connection, got: :ok` : 📔 This means that, a function is only defined in the module, but it does not perform any action.


### Models in Phoenix

#### Topic Model

1. 🌟 Phoenix >1.3, a lot of changes have occured since then. 1.5 does not have a `models` directory, it contains a lib folder which is further broken down into "discuss" and "discuss_web" folders. The "discuss" folder contains the `model` of the Discuss project. 



Steps to Document:
1. Use ### to signify a topic
2. Use #### to signify a sub-topic 
3. There are 2 types:
   1. If a concept is explained:
      1. Add a diagram
      2. Explain the Diagram in Points
   2. If a code is explained:
      1. Add the code snippet
      2. Add a ###### Explanation
      3. Explain the code in points
4. Use 💡 and ⭐️ for Tips and Point to remember later respectively.
## Legend
#### 🏔 : Definition
#### 📔 : Code Explanation
#### <=> : Which is the same as
#### 💡: Tip
#### ⭐️ : Important Point to Remember