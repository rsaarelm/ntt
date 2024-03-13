# ntt - Neat Time Tagger

Stochastic time tracker similar to [tagti.me](http://tagti.me/).
Written in [Neat](https://neat-lang.github.io/), unless we're in the future you probably need to manually install a Neat compiler.

## How to use it

Compile `ntt` (with `just build`) and put it somewhere in your path, then start `ntt-daemon.sh` in a shell when you work.
The daemon will alert you at random intervals.
At each interval, if you were working, type `ntt work [task] [optional comment]` on command line (if you omit the task, it'll reuse the one from your previous work entry).
If you were taking a break, type `ntt break [optional comment]`, or just ignore the alert.
Work datapoints will be collected in your work log file at `~/.local/share/ntt/work.log` and approximate the amount of time you actually worked the more entries you make.
