# ntt - Neat Time Tagger

Stochastic time tracker similar to [tagti.me](http://tagti.me/).
Written in [Neat](https://neat-lang.github.io/), it's not very common yet so the Makefile includes a compiler bootstrapping process.

## How to use it

Compile `ntt` by running `make` (you need to have `gcc` installed) and put it somewhere in your path, then start `ntt-daemon.sh` in a shell when you work.
The daemon will alert you at random intervals.
At each interval, if you were working, type `ntt task [id] [optional comment]` on command line (if you omit the id, it'll reuse the one from your previous task entry).
If you were taking a break, type `ntt break [optional comment]`, or just ignore the alert.
Work datapoints will be collected in your work log file at `~/.local/share/ntt/ntt.timedot` and approximate the amount of time you actually worked the more entries you make.

The log is kept in hledger's [timedot format](https://hledger.org/time-planning.html) and can be processed with hledger:

```
hledger -f ~/.local/share/ntt/ntt.timedot balance -t
```

## Misc notes

The average ping interval is fixed at 45 minutes.
Adjust the constant in `ntt.nt` and recompile if you want to change this.

When starting work for a day, you can immediately log a break for the previous ping time, even if a ping hasn't fired yet.
Once at least one entry exists for the day, `ntt` can start reporting the number of missing pings between now and the last entry.

A convention is to start comments with "--".
If you do `ntt task -- Comment`, without specifying a task, the entry will be logged to have the same task as your previous task id.

Use `:` as category separator for your tasks so hledger can parse the hierarchy, `study:calculus`, `cleaning:toilet`, `job:devops` etc.
