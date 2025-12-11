# Day 9: Movie Theater

You slide down the firepole in the corner of the playground and land in the North Pole base movie theater!

The movie theater has a big tile floor with an interesting pattern. Elves here are redecorating the theater by switching out some of the square tiles in the big grid they form. Some of the tiles are **red**; the Elves would like to find the largest rectangle that uses red tiles for two of its opposite corners. They even have a list of where the red tiles are located in the grid (your puzzle input).

For example:

```
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
```

Showing red tiles as `#` and other tiles as `.`, the above arrangement of red tiles would look like this:

```
..............
.......#...#..
..............
..#....#......
..............
..#......#....
..............
.........#.#..
..............
```

You can choose any two red tiles as the opposite corners of your rectangle; your goal is to find the largest rectangle possible.

For example, you could make a rectangle (shown as `O`) with an area of `24` between `2,5` and `9,7`:

```
..............
.......#...#..
..............
..#....#......
..............
..OOOOOOOO....
..OOOOOOOO....
..OOOOOOOO.#..
..............
```

Or, you could make a rectangle with area `35` between `7,1` and `11,7`:

```
..............
.......OOOOO..
.......OOOOO..
..#....OOOOO..
.......OOOOO..
..#....OOOOO..
.......OOOOO..
.......OOOOO..
..............
```

You could even make a thin rectangle with an area of only `6` between `7,3` and `2,3`:

```
..............
.......#...#..
..............
..OOOOOO......
..............
..#......#....
..............
.........#.#..
..............
```

Ultimately, the largest rectangle you can make in this example has area **`50`**. One way to do this is between `2,5` and `11,1`:

```
..............
..OOOOOOOOOO..
..OOOOOOOOOO..
..OOOOOOOOOO..
..OOOOOOOOOO..
..OOOOOOOOOO..
..............
.........#.#..
..............
```

Using two red tiles as opposite corners, **what is the largest area of any rectangle you can make?**

Your puzzle answer was `4776100539`.

## Part Two

The Elves just remembered: they can only switch out tiles that are **red** or **green**. So, your rectangle can only include red or green tiles.

In your list, every red tile is connected to the red tile before and after it by a straight line of **green tiles**. The list wraps, so the first red tile is also connected to the last red tile. Tiles that are adjacent in your list will always be on either the same row or the same column.

Using the same example as before, the tiles marked `X` would be green:

```
..............
.......#XXX#..
.......X...X..
..#XXXX#...X..
..X........X..
..#XXXXXX#.X..
.........X.X..
.........#X#..
..............
```

In addition, all of the tiles **inside** this loop of red and green tiles are also green. So, in this example, these are the green tiles:

```
..............
.......#XXX#..
.......XXXXX..
..#XXXX#XXXX..
..XXXXXXXXXX..
..#XXXXXX#XX..
.........XXX..
.........#X#..
..............
```

The remaining tiles are never red nor green.

The rectangle you choose still must have red tiles in opposite corners, but any other tiles it includes must now be red or green. This significantly limits your options.

For example, you could make a rectangle out of red and green tiles with an area of `15` between `7,3` and `11,1`:

```
..............
.......OOOOO..
.......OOOOO..
..#XXXXOOOOO..
..XXXXXXXXXX..
..#XXXXXX#XX..
.........XXX..
.........#X#..
..............
```

Or, you could make a thin rectangle with an area of `3` between `9,7` and `9,5`:

```
..............
.......#XXX#..
.......XXXXX..
..#XXXX#XXXX..
..XXXXXXXXXX..
..#XXXXXXOXX..
.........OXX..
.........OX#..
..............
```

The largest rectangle you can make in this example using only red and green tiles has area ***`24`***. One way to do this is between `9,5` and `2,3`:

```
..............
.......#XXX#..
.......XXXXX..
..OOOOOOOOXX..
..OOOOOOOOXX..
..OOOOOOOOXX..
.........XXX..
.........#X#..
..............
```

Using two red tiles as opposite corners, **what is the largest area of any rectangle you can make using only red and green tiles?**

Your puzzle answer was `1476550548`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## Solution for part one
Part one is easily brute forced. For each pair of tiles calculate the area (remember to add 1 to both the width and height since we're looking at tiles and the positions goes to the top left corner of each tile), sort the sizes and pick the largest. There are probably prettier ways of doing this, but it works.
```
BenchmarkTools.Trial: 1388 samples with 1 evaluation per sample.
 Range (min … max):  3.194 ms …   4.434 ms  ┊ GC (min … max): 0.00% … 5.92%
 Time  (median):     3.580 ms               ┊ GC (median):    4.79%
 Time  (mean ± σ):   3.600 ms ± 199.429 μs  ┊ GC (mean ± σ):  4.87% ± 2.22%

            ▄▁▅▄▄▆█▃▇▇▆▂▆▄▇▅▄▄▁▄▁▁▁▃    ▂                      
  ▂▂▂▃▃▄▆▇█▇████████████████████████▆▇█▇██▅▄▆▅▅▃▃▂▂▃▃▂▂▂▂▁▂▂▁ ▅
  3.19 ms         Histogram: frequency by time        4.17 ms <

 Memory estimate: 18.54 MiB, allocs estimate: 37.
 ```

 ## Solution for part two
 For part two each tile connects to the next tile creating a line. And now we're looking for the largest area that is wholly contained by the polygon created by the lines. I made the assumption that the lines either are horizontal or vertical. I tried a few different solutions. My fist solution used the ray casting algorithm (counting the number of lines you pass if you draw a line from a given tile to the edge). It worked with the test data, but not with the puzzle input. No sursprises there. I then tried to check if the tiles in an area intersects with a boundary. Worked with the test data, but took forever with the puzzle input. I settled on checking wether a line (boundary) intersects with an area. My solution still takes 1.459 seconds to run. So while it works I'm not that happy with it.
 ```
BenchmarkTools.Trial: 4 samples with 1 evaluation per sample.
 Range (min … max):  1.458 s …    1.459 s  ┊ GC (min … max): 0.03% … 0.00%
 Time  (median):     1.459 s               ┊ GC (median):    0.02%
 Time  (mean ± σ):   1.459 s ± 599.564 μs  ┊ GC (mean ± σ):  0.02% ± 0.02%

  █                                                  █    ██  
  █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁██ ▁
  1.46 s         Histogram: frequency by time         1.46 s <

 Memory estimate: 18.58 MiB, allocs estimate: 47.
 ```