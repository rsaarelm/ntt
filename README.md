# ntt - Neat Time Tagger

Stochastic time tracker similar to [tagti.me](http://tagti.me/).
Written in [Neat](https://neat-lang.github.io/), it's not very common yet so the Makefile includes a compiler bootstrapping process.

## How to use it

Compile `ntt` by running `make` (you need to have `gcc` installed) and put it somewhere in your path

`ntt` polls you using pings that are fixed points of time spread out randomly, but averaging 45 minutes between two consecutive ones.
When you start working, start `ntt-daemon.sh` in a shell window.
It will wait until the next ping point and alert you.
When you get the ping, use the command-line `ntt` program to record what you were doing at the moment it happened, using a suitable task identifier, eg. `ntt done housework:gardening`.
This will record you having done 45 minutes work on the task in the `ntt` log file `~/.local/share/ntt/ntt.timedot`.
If you weren't working on anything you care to log, log a break with `ntt break`, or just ignore the ping and wait for the next one.
The command-line program will always try to save a record for the previous ping, even if it happened hours ago (ping times are fixed and can be deterimend retroactively), so you usually want to keep it up to date with recorded work or break time during a workday.

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

You may want to edit your time log manually, eg. rewrite in-between breaks into tasks.
The special part `ntt` looks for on each line to recognize it as a ping record is a trailing comment that starts with a time-of-day value, `; 15:04:05`.
You can have other timekeeping data in the same file without this marker and `ntt` will just ignore it.

When starting work for a day, you can immediately log a break for the previous ping time, even if a ping hasn't fired yet.
Once at least one entry exists for the day, `ntt` can start reporting the number of missing pings between now and the last entry.

Use `:` as category separator for your tasks so hledger can parse the hierarchy, `study:calculus`, `cleaning:toilet`, `job:devops` etc.

In normal use, `ntt` resets its workflow at every midnight and you're assumed to sleep during the night and track some specific effortful work during the day.
If you want to log *everything*, including how long you spend sleeping, you can backfill across the previous midnight by using `ntt done --fill <task>` that will record the given task for every ping after the last recorded one.
