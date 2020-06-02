# Identicon

**TODO: Add description**

## Description of Project
We would be writing a program to randomly generate an identicon / gravatar, which can be seen on Github Profiles like this:

![Example 1](media/img_1.png)
![Example 2](media/img_2.png)


The important thing about this identicon is that it is always mirrored vertically, meaning, that the LHS = RHS.

![Mirrored Vertically](media/mirror.png)

We have to generate a 5x5 grid with squares 50px tall and 50px wide: (Total 250px X 250px)

![Grid](media/grid_1.png)

Also, the identicon is based on the "name" that is provided and we need to have same identicon for the same name: Eg: if "billy" is entered twice, it should display the same identicon everytime
![Same Identicon](media/same_identicon.png)

#### The Process

![The Process](media/the_process.png)

## Conversion of String to Image

![Converting String to Image](media/str_img.png)

## hashing

When we hash a string, we get a series of numbers corresponding to the string

## Create the Main Function

This function has a set of pipe functions which call all the functions of the processes shown in the above image

## Hashing

```bash
iex(1)> hash = :crypto.hash(:md5, "banana")
<<114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65>>
iex(2)> :binary.bin_to_list(hash)
[114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
```

## The Purpose of Hex List

An identicon has a color assigned to it, and a series of rectangles.

#### The process again:

The first 3 values define the RGB value of the color to be used.
![Color](media/color.png)

###### The grid contains has indices where-in they start from the left hand side, and continue till the middle, and the last two values of a row are just the mirror images of the first two values

![Grid Index](media/grid_index.png)


###### Next, the values in the Grid are assigned to the rows in the following manner:


![Values in Grid](media/values_in_grid.png)
###### And, the all the even numbers are colored whereas the odd-numbers are not colored


## Data Modeling with Struct

A Struct is a map that is used to store data in an Elixir application. They are just like maps, except with 2 extra properties:
1. They can store default properties
2. They have additional compile-time checking properties

## TODO: What exactly is a struct??

##### Create a file `image.ex` whose sole purpose is to hold the struct

Create a struct hex with default value nil:

```elixir
defstruct hex: nil 
```
 ON terminal:
 ```bash
iex(2)> %Identicon.Image{}
%Identicon.Image{hex: nil}
 ```
 This creates a new struct with the value nil

```elixir
def main(input) do
    input
    |> hash_input()
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
```

Output on Terminal:

```bash
iex(1)> Identicon.main("asdf")
%Identicon.Image{
  hex: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112]
}
```

## Pattern matching struct

```elixir
def main(input) do
    input
    |> hash_input()
    |> pick_color()
  end

  def pick_color(image) do
    %Identicon.Image{hex: hex_list} = image
    [r, g, b] = hex_list
    [r, g, b]
  end
```

In the `pick_color(image)` function, we receive `image` as a struct, from which we have to:
1. Convert struct into a list, 
2. Receive the first 3 values (as rgb values)

Output on Terminal :
```bash
iex(3)> Identicon.main("asdf")
** (MatchError) no match of right hand side value: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112]
    (identicon 0.1.0) lib/identicon.ex:23: Identicon.pick_color/1
```

Here, elixir throws an error, because `hex_list` does not match `[r, g, b]` as it has 16 values in the list and not just 3.

Use this instead: `[r, g, b | _tail] = hex_list` Here, it will give only the first 3 values.

```bash
iex(5)> Identicon.main("asdf")
[145, 46, 200]
```

The code can finally be refactored in the following manner:

```elixir
def pick_color(image) do
    %Identicon.Image{hex: [r, g, b | _tail]} = image
    [r, g, b]
  end
```

## Updating Struct

Extremely Refactored code:

```elixir
def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end
```

## Building the grid

The process is like this:

![Chunk](media/chunk.png)


We have to create 2 functions, `Enum.chunk_every()` where it segregates 3 elements in a separate list, and also function `mirror_row(row)` where it receives a single row, and then it appends the first 2 values of the row to the end of the row (mirroring the elements)

![Mirror](media/mirror_row.png)
![Mirror 2](media/mirror_row_2.png)


```elixir
def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_row/1)

    # |> mirror_row
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    ## append to the list function
    row ++ [second, first]
  end
```

## TODO : How is Enum.map() used in this function?? What is the use of /1? 

## Grid Structure

`List.flatten(list)`, converts the nested list into 1 list. (Awesome Function!)

💡 Most of elixir iterations run independent of index!

To use index, use `Enum.with_index()` function

```elixir

iex(28)> list = Identicon.main("asdf")
[145, 46, 200, 46, 145, 3, 178, 206, 178, 3, 73, 228, 165, 228, 73, 65, 6, 141,
 6, 65, 73, 90, 181, 90, 73]
iex(29)> Enum.with_index(list)
[
  {145, 0},
  {46, 1},
  {200, 2},
  {46, 3},
  {145, 4},
  {3, 5},
  {178, 6},
  {206, 7},
  {178, 8},
  {3, 9},
  {73, 10},
  {228, 11},
  {165, 12},
  {228, 13},
  {73, 14},
  {65, 15},
  {6, 16},
  {141, 17},
  {6, 18},
  {65, 19},
  {73, 20},
  {90, 21},
  {181, 22},
  {90, 23},
  {73, 24}
]

```
Returns a list of tuples, which have the value and index in it

## Giving an Identicon Shape

A new way to write a function, similar to lambda in Python:

final code : 

```elixir
def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
    |> filter_odd_squares()
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Identicon.Image{image | grid: grid}
  end
```

## Creating the pixel map

Use Erlang EGD (Erland Graphical Drawer)
![EGD](media/egd.png)

EGD assumes the **top-left position** as `0,0`
## TODO: Explain the below code properly


```elixir
def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
    |> filter_odd_squares()
    |> build_pixel_map()
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end
```


## Drawing the Rectangle