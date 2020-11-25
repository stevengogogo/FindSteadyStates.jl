# FindSteadyStates


[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://stevengogogo.github.io/FindSteadyStates.jl/dev) [![codecov](https://codecov.io/gh/stevengogogo/FindSteadyStates.jl/branch/master/graph/badge.svg?token=eNsRLcRA69)](https://codecov.io/gh/stevengogogo/FindSteadyStates.jl) 

Exploring the steady states of ODE in given domain.

## Features
1. Find steady states
2. Classify stability: stable and saddle point.




## Multi-threading

To enable multi-threading. One needs to set up threads outside Julia. Use the following command to start the REPL.

```sh
julia --threads 4 # 4 is the number of the thread you want.
```
review [the Thread documentation](https://docs.julialang.org/en/v1/manual/multi-threading/) for further info.

##  Methods

### Steady-states Searching for Differential equations

Theoretically, The steady states of differential equations can be analtically devised by letting the derivaitatives of time equal to zero. However, in most of cases, the analyical solution of steady-states
