# ntt - Neat Time Tagger

Stochastic time tracker similar to [tagti.me](http://tagti.me/).
Written in [Neat](https://neat-lang.github.io/), it's not very common yet so the Makefile includes a compiler bootstrapping process.

## How to use it

Compile `ntt` by running `make` (you need to have `gcc` installed) and put it somewhere in your path, then start `ntt-daemon.sh` in a shell when you work.
The daemon will alert you at random intervals.
After each alert, if you were working, type `ntt task id <optional comment>` on command line.
If you were taking a break, type `ntt break <optional comment>`, or just ignore the alert.
Work datapoints will be collected in your work log file at `~/.local/share/ntt/ntt.timedot` and approximate the amount of time you actually worked the more entries you make.

The log is kept in hledger's [timedot format](https://hledger.org/time-planning.html) and can be processed with hledger:

```
hledger -f ~/.local/share/ntt/ntt.timedot balance -t
```

## Misc notes

**Obvious caveat**: Due to the logging being random, logged work hours will be accurate over a long period, but not over a single day.
Do not use stochastic time tracking if you must have as accurate as possible time use records for individual days.

The average ping interval is fixed at 45 minutes.
Adjust the constant in `ntt.nt` and recompile if you want to change this.

You may want to examine and customize the `ntt-daemon.sh` script to use different shell programs to produce an alert you like.

When starting work for a day, you can immediately log a break for the previous ping time, even if a ping hasn't fired yet.
Once at least one entry exists for the day, `ntt` can start reporting the number of missing pings between now and the last entry.

Use `:` as category separator for your tasks so hledger can parse the hierarchy, `study:calculus`, `cleaning:toilet`, `job:devops` etc.

In normal use, `ntt` resets its workflow at every midnight and you're assumed to sleep during the night and track some specific effortful work during the day.
If you want to log *everything*, including how long you spend sleeping, you can backfill across the previous midnight by using `ntt done --fill <task>` that will record the given task for every ping after the last recorded one.
