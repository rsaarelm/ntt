# ntt - Neat Time Tagger

Stochastic time tracker similar to [tagti.me](http://tagti.me/).
Written in [Neat](https://neat-lang.github.io/), unless we're in the future you probably need to manually install a Neat compiler.

## How to use it

Compile `ntt` (with `just build`) and put it somewhere in your path, then start `ntt-daemon.sh` in a shell when you work.
The daemon will alert you at random intervals.
At each interval, if you were working, type `ntt task [id] [optional comment]` on command line (if you omit the id, it'll reuse the one from your previous task entry).
If you were taking a break, type `ntt break [optional comment]`, or just ignore the alert.
Work datapoints will be collected in your work log file at `~/.local/share/ntt/time.log` and approximate the amount of time you actually worked the more entries you make.

You can export your hours in hledger's [timedot format](https://hledger.org/time-planning.html) with `ntt export` (it just prints to stdout, use pipe commands to direct it to a file).

```
ntt export > /tmp/work.timedot
hledger -f /tmp/work.timedot print
```

## Misc notes

When starting work for a day, you can immediately log a break for the previous ping time, even if a ping hasn't fired yet.
Once at least one entry exists for the day, `ntt` can start reporting the number of missing pings between now and the last entry.

A convention is to start comments with "--".
If you do `ntt task -- Comment`, without specifying a task, the entry will be logged to have the same task as your previous task id.

Use `:` as category separator for your tasks so Hledger can parse the hierarchy, `study:calculus`, `cleaning:toilet`, `job:devops` etc.
