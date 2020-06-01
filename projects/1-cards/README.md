# Cards

**TODO: Add description**

## Problem Statement

## Concepts Explained

## Hello

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cards` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cards, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cards](https://hexdocs.pm/cards).

Elixir is a purely functional programming language

#### A module is a collection of different methods or functions

To run an elixir file : use command: iex -S mix (iex - interactive elixir shell)

You can run the command using Cards.hello

You can call function with/without parenthesis

Elixir has implicit return, which means Whenever a method or function runs whatever the last value inside that function is will automatically get returned. So I could have just as easily said Return Hi there or I could just left it off.

```elixir
def hello do
    "Hey"
end

//Function Call
Cards.hello //This function will implicitly return "Hey"

```
Lists:

We can define a list of elements by using the bracket notation for an array which is similar to Ruby javascript Java. Tons of other languages. So again nothing too bad here just yet we can create our array or our list as the term we are using a lot. After placing these square braces so directly in here we can put in a first couple of cards as just strings like is two and three. Notice I'm using double quotes in here as opposed to single quotes, They are are supported, but double quotes are convention,

Recompile: Elixir runtime cannot automatically check for and build changes in the code, it has to be done manually by the command "recompile"

Object Oriented vs Functional Programming:
Diff 1:

![Object Oriented concept](media/cards_oo.png)

In OO approach, we have an instance of a class, with some methods, which operate on its local instance variable.
For Example:
![Object Oriented concept](media/cards_oo2.png)

![Functional Programming concept](media/cards_fp.png)
Modules are collection of methods, and nothing else. There are no instance variables.

After creating your first method, you might encounter this error:

`** (UndefinedFunctionError) function Cards.shuffle/0 is undefined or private (cards 0.1.0) Cards.shuffle()`
Here `Cards.shuffle/0` means that shuffle method having `0` arguments, but we do not have such a method, we have something like `Cards.shuffle/1`, because we need to pass an argument `deck` to the shuffle method.

`arity` refers to number of arguments that need to be passed. eg: `shuffle/1` means that the `arity` is 1.

Elixir standard library includes lists, numbers, file-system, http library.

Immutability in Elixir: We cannot modify any data structure in Elixir. Every data structure is immutable. Whenever we modify a data structure, we create a new data structure and return.
![Immutability concept](media/cards_shuffle1.png)

Convention: Whenever, a function/method is supposed to return a true/false (boolean value), use a post-fix of `?` to indicate the same.

For eg: for a sample method `contains` which takes in arguments `deck, hand` & returns either `true/false`, this method can be defined as follows:
`def contains?(deck, hand) do //Enter body here end`
Notice, the ? does not do anything, except that it used as a convention.

### List: A collection of similiar records.

### List comprehension:

![List comprehension](media/list_comprehension.png)

`for suit <- suits do suit end`
This can be read as,

> For every element in suits, return the element. And the entire returned array is a map.

> 💡 Elixir supports template literals `"#{value} of #{suit}"`

#### Nested Comprehension

Whenever a nested list comprehension method is called, it finally returns a list of list, so to convert it into a simple list, use List.flatten function.

Solution 2: A much efficient solution.
`for suit <- suits, value <- values do "#{value} of #{suit}" end`

#### Tuples: A collection of different types, but is indexed, which means the order carries some meaning

`{["elem1","elem2","elem3","elem4"] , ["elem4","elem5","elem6"]}`

`deck[0] does not work in elixir for lists or tuples, we cannot get an element at the 0th index in this manner.`

### Pattern Matching: Elixir's replacement for variable assignment which means

`{hand, deck} = {Hand, The Rest} #Here, Hand list is stored in hand variable, and The Rest list is stored in deck variable. In this way both of the values of the tuple can be extraced`

> Anytime you use equals, think pattern matching

Whenever using pattern matching, you have to make sure, that the no, of elements are equal on the left and right hand side.
If not, you may get an error like `e:noent` which means 
> error, no entity.

### How does elixir work?

![Elixir Code Execution](media/eli_to_execution.png)

###### Erlang was used for telephony purposes


###### Pattern matching continued

```
def load(path) do
    {status, binary} = File.read(path)

    case status do
      :ok -> :erlang.binary_to_term(binary)
      :error -> "File does not exist"
    end
  end
```

Instead of using ef else blocks, Elixir has a much easier way of using pattern matching, wherein, by using case statements, you can easily assign functions to certain conditions (look in the code above, and if else block would mean another 10 lines of code, which was solved in about 4 lines of code)

## Pattern Matching in Case Statements

Whenever we see colon and then a word inside of elixir `:ok` this is a primitive data type that we refer to as an ***atom / symbol***.

Atoms are used throughout elixir as handling kind of like status codes or messages or handling control flow throughout our application to the most common outer atoms that we're going to see. OK I want to think of them as being exactly like strings.

So right now again I just want you to think of them as being essentially like strings but they're for codifying error messages that only developers can see.

//Add code here
```elixir
ef load(path) do
    case File.read(path) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "File does not exist"
    end
  end
```

Instead of using case for status, we can use the pattern matching in the above manner. In one step, 2 operations are being done. That is, in the first step, we check whether the status is ok or error, and in the second step, we assign the output value to either `binary` or `reason` depending upon `:ok` and `:error`

💡 If you declare a variable, and do not use it anywhere, then it's going to show you a warning, that variable is unused. To get ride of this error, you can use an `_` underscore before the variable, eg `_reason` so that it overrides the warning:

```elixir
def load(path) do
    case File.read(path) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist"
    end
  end
```

## The Pipe Operator

Sometimes, you might have certain functions which are always called one after the other, over & over again. Eg. in our cards function: We create a deck, shuffle it, and deal a card from it (over and over again). In these cases, its beneficial to create a function, that can do all the 3 things for us.

![Cards Sync Functions](media/sync_functions.png)

So it turns out that this pattern of passing in some amount of data from method to method you know like
call this thing pass result here past the result here then get the feedback over here is so common elixir
that the language has its own operator which is called the pipe operator to set up this chain of method
calls.

Initial Code

```elixir
def create_hand(hand_size) do
    deck = Cards.create_deck()
    deck = Cards.shuffle(deck)
    hand = Cards.deal(deck, hand_size)
  end
```

Refactored Code

```elixir
def create_hand(hand_size) do    
    Cards.create_deck
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
```

Here, `Cards.create_deck` is called first,
and the returned value is passed on to `Cards.shuffle()` as an argument.
Finally, the value returned from  `Cards.shuffle()` is passed on to `Cards.deal(hand_size)` as the ***first argument***
Which means, that the last function is called as `Cards.deal(deck, hand_size)`.

This function is easy to read, write and eliminated unnecessary variable assigns.

## Module Documentation

Documentation is important for other developers when they try to use your code.

First we'll install a package called X dock into our project and then we'll write the documentation itself.
The purpose of X dock is to give us the ability to generate a standalone pile of documentation automatically.

In the `mix.exs` file, there is deps, which means dependencies
```elixir
defp deps do
    [
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end
```

After defining the dependencies, use `mix deps.get` command in the command line.

## Writing and Generating Documentation

Syntax for writing documentation

```elixir
@moduledoc """
Provides methods for creating and handling deck of cards

"""
```

ex Docs have a super-fun feature, where it creates an entire documentation HTML web-page for your module.
Use the function `mis docs` to do the same. Output:

```bash
[a@aa-MacBook-Pro 1-cards (master ✗)]$ mix docs
==> nimble_parsec
Compiling 4 files (.ex)
Generated nimble_parsec app
==> makeup
Compiling 44 files (.ex)
Generated makeup app
==> earmark
Compiling 1 file (.yrl)
Compiling 2 files (.xrl)
Compiling 3 files (.erl)
Compiling 32 files (.ex)
Generated earmark app
==> makeup_elixir
Compiling 4 files (.ex)
Compiling lib/makeup/lexers/elixir_lexer.ex (it's taking more than 15s)
Generated makeup_elixir app
==> ex_doc
Compiling 22 files (.ex)
Generated ex_doc app
==> cards
Compiling 1 file (.ex)
Generated cards app
Generating docs...
View "html" docs at "doc/index.html"
View "epub" docs at "doc/cards.epub"
```

To generate documentation for a method just use 
```elixir
@doc """
    Divides a deck into a hand and remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.
  """
```

Now, suppose you want to give an example of what your function does, you can do so by Adding two hashes `##` with a space and `Examples`
and below, leave 3 total tabs and write your appropriate terminal execution.

Like this:

```elixir
@doc """
    Divides a deck into a hand and remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

    ## Examples
       iex> deck = Cards.create_deck()
       iex> {hand, deck} = Cards.deal(deck,1)
       iex> hand
       ["Ace of Spades"]
  """
```

![Functions](media/fun_docs.png)


## Testing is fully featured, you can do it right out of the box with Elixir.

Elixir gives clear feedback for a failed test case 
```elixir

  1) test the truth (CardsTest)
     test/cards_test.exs:5
     Assertion with == failed
     code:  assert 1 + 1 == 3
     left:  2
     right: 3
     stacktrace:
       test/cards_test.exs:6: (test)



Finished in 0.06 seconds
1 doctest, 1 test, 1 failure
```

## DocTest

As you can see even though we have 1 test case, it shows that there are 2 tests running, `1 test` and `1 doctest`, Now, this means, whenever we have an exampel in our documentation, it is treated as a test, and the last value is compared with the final value after running the lines of code present in the example:
Eg.:

```elixir
@doc """
    Divides a deck into a hand and remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

    ## Examples
       iex> deck = Cards.create_deck()
       iex> {hand, deck} = Cards.deal(deck,1)
       iex> hand
       ["Ace of Spades"]
  """
```
In the above code, iex runs till line 3, where it calculates the value of `hand` and compares it  with the last value ie `["Ace of Spades"]`

## Writing effective doctest

Step 1: Write effective documentation and examples code in the documentation
Step 2: Make sure you have the `doctest {your_module_name}` in the `{test_file_name}.exs` file.


## Case Tests

In your `cards_test.exs` file, you can add your own test cases, just to test a particular functionality, eg:

```elixir
defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck())
    assert deck_length == 20
  end
end
```

Here, `"Create_deck makes 20 cards"` is a test case which passes when `deck_length` equals `20`

### What to test?

What behaviours do you care about in your module? Write those tests.

💡`assert {value 1} == {value 2}` is the same as `refute {value 1} != {value 2}` 

## Intro to Maps

Maps are like plain javascript objects
Syntax: `colors = %{ primary: "red", secondary: "blue" }`

We can also use pattern matching in maps: `%{secondary: secondary_color} = colors`
Here, the value of the property `secondary` is stored in the variable `secondary_color`

## Updating Values in Maps

```bash
iex(1)> colors = %{primary: "red"}
%{primary: "red"}
iex(2)> colors.primary = "blue"
** (CompileError) iex:2: cannot invoke remote function colors.primary/0 inside a match
```
It throws an error because we cannot re-assign/update the values once it is declared,

To update a map value, use the `Map.put()` function : 

```elixir
# Map.put(map, key, value)
Map.put(colors, primary, "pink")
```

💡 Map.put() does not update a value in the map, it simply creates a new map with the updated property.

2nd Method 

```elixir
%{colors | primary: "green"}
```

🟠Disadvantage: So this syntax can only be used when we are updating an existing property. It cannot be used when we are trying to add a property to the map.

