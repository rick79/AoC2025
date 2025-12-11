# Day 11: Reactor

You hear some loud beeping coming from a hatch in the floor of the factory, so you decide to check it out. Inside, you find several large electrical conduits and a ladder.

Climbing down the ladder, you discover the source of the beeping: a large, toroidal reactor which powers the factory above. Some Elves here are hurriedly running between the reactor and a nearby server rack, apparently trying to fix something.

One of the Elves notices you and rushes over. "It's a good thing you're here! We just installed a new **server rack**, but we aren't having any luck getting the reactor to communicate with it!" You glance around the room and see a tangle of cables and devices running from the server rack to the reactor. She rushes off, returning a moment later with a list of the devices and their outputs (your puzzle input).

For example:

```
aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
```

Each line gives the name of a device followed by a list of the devices to which its outputs are attached. So, `bbb: ddd eee` means that device `bbb` has two outputs, one leading to device `ddd` and the other leading to device `eee`.

The Elves are pretty sure that the issue isn't due to any specific device, but rather that the issue is triggered by data following some specific path through the devices. Data only ever flows from a device through its outputs; it can't flow backwards.

After dividing up the work, the Elves would like you to focus on the devices starting with the one next to you (an Elf hastily attaches a label which just says **`you`**) and ending with the main output to the reactor (which is the device with the label **`out`**).

To help the Elves figure out which path is causing the issue, they need you to find **every** path from `you` to `out`.

In this example, these are all of the paths from you to out:

- Data could take the connection from you to `bbb`, then from `bbb` to `ddd`, then from `ddd` to `ggg`, then from `ggg` to `out`.
- Data could take the connection to `bbb`, then to `eee`, then to `out`.
- Data could go to `ccc`, then `ddd`, then `ggg`, then `out`.
- Data could go to `ccc`, then `eee`, then `out`.
- Data could go to `ccc`, then `fff`, then `out`.

In total, there are `5` different paths leading from you to out.

**How many different paths lead from you to out?**

Your puzzle answer was `701`.

## Part Two

Thanks in part to your analysis, the Elves have figured out a little bit about the issue. They now know that the problematic data path passes through both dac (a digital-to-analog converter) and fft (a device which performs a fast Fourier transform).

They're still not sure which specific path is the problem, and so they now need you to find every path from `svr` (the server rack) to `out`. However, the paths you find must all also visit both `dac` **and** `fft` (in any order).

For example:

```
svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out
```

This new list of devices contains many paths from svr to out:

```
svr,aaa,fft,ccc,ddd,hub,fff,ggg,out
svr,aaa,fft,ccc,ddd,hub,fff,hhh,out
svr,aaa,fft,ccc,eee,dac,fff,ggg,out
svr,aaa,fft,ccc,eee,dac,fff,hhh,out
svr,bbb,tty,ccc,ddd,hub,fff,ggg,out
svr,bbb,tty,ccc,ddd,hub,fff,hhh,out
svr,bbb,tty,ccc,eee,dac,fff,ggg,out
svr,bbb,tty,ccc,eee,dac,fff,hhh,out
```

However, only **`2`** paths from `svr` to `out` visit both `dac` and `fft`.

Find all of the paths that lead from `svr` to `out`. **How many of those paths visit both `dac` and `fft`?**

Your puzzle answer was `390108778818526`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## Solution for part one
Finally a simple puzzle! This one is about traversing a graph from point `you` to `out`. I've made the assumption that there are no loops (vertices connecting to themselves) or cycles (paths from a vertex leading back to itself) in the graph and that there always are at least one path from start to finish. I wrote a simple recursive function that returns 1 if you have reached the end node, otherwise return the sum of the function called with each of the node's children. Works like a charm and was easy to implement. Since I suspected that part two would require memoization I wrapped the recursive function in a parent function so that I easily can add a cache without relying on any global variables.
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation per sample.
 Range (min … max):  70.250 μs …  3.783 ms  ┊ GC (min … max): 0.00% … 96.56%
 Time  (median):     90.166 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   93.254 μs ± 59.170 μs  ┊ GC (mean ± σ):  1.59% ±  2.62%

                 ▁▂▇▇█▇▄▃▁                                     
  ▂▁▂▂▂▁▂▂▂▂▃▃▃▄▆█████████▇▆▆▆▄▄▄▄▃▃▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂ ▃
  70.2 μs         Histogram: frequency by time         128 μs <

 Memory estimate: 45.24 KiB, allocs estimate: 975.
 ```

## Solution for part two
As I suspected, part two requires memoization. We're given a new test input to work with and I made the same assumptions as for part one. This time we're trying to go from `srv` to `out`, but we're only to count paths that have passed throu the nodes `dac` and `fft`. I added a Set to the recursive function and add the current node to it for each node I pass through that matches the required nodes. A Set works well since we can pass through them in any order. This worked well on the test input, but would have taken forever with the real puzzle input. So I added memoization in the form of a Dict with a Tuple of the function parameters as the key. Went from taking forever to running smoothly.
```
BenchmarkTools.Trial: 7422 samples with 1 evaluation per sample.
 Range (min … max):  573.167 μs …   4.791 ms  ┊ GC (min … max): 0.00% … 85.54%
 Time  (median):     613.792 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   672.167 μs ± 255.663 μs  ┊ GC (mean ± σ):  6.98% ± 12.29%

  ▆█▇▅▃▂▂▂▁                                                     ▂
  ██████████▆▇▆▆▅▅▅▃▁▁▃▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▆▅▆▆▇▇██▇▆▆▇▇▆ █
  573 μs        Histogram: log(frequency) by time       1.94 ms <

 Memory estimate: 1.10 MiB, allocs estimate: 20140.
```