# FindSteadyStates

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://=.github.io/FindSteadyStates.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://=.github.io/FindSteadyStates.jl/dev)
[![Build Status](https://travis-ci.com/=/FindSteadyStates.jl.svg?branch=master)](https://travis-ci.com/=/FindSteadyStates.jl)
[![Coverage](https://codecov.io/gh/=/FindSteadyStates.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/=/FindSteadyStates.jl)

Exploring the steady states of ODE in given domain.

## Features
1. Find steady states
2. Classify stability: stable and saddle point.


## Multi-threading

To enable multi-threading. One needs to set up threads outside Julia. Use the following command to start Julia.

```sh
julia --threads 4 # 4 is the number of the thread you want.
```
review [the Thread documentation](https://docs.julialang.org/en/v1/manual/multi-threading/) for further info.
