# FindSteadyStates


[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://stevengogogo.github.io/FindSteadyStates.jl/dev) [![codecov](https://codecov.io/gh/stevengogogo/FindSteadyStates.jl/branch/master/graph/badge.svg?token=eNsRLcRA69)](https://codecov.io/gh/stevengogogo/FindSteadyStates.jl) 

Exploring the steady states of ODE in given domain.

## Features
1. Find steady states
2. Classify stability: stable and saddle point.


## Usage

```julia
using FindSteadyStates
using DifferentialEquations

# Model
function bistable_ode!(du, u, p ,t)
    s1, s2 = u
    K1, K2, k1, k2, k3, k4, n1 , n2  = p
    du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
    du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2
end

# Parameters
p_ = [1., 1., 20., 20., 5., 5.,  4., 4.]
u_1 = [3., 1.]


# Define a problem
de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind())

j_gen = jacobian(de) # jacobian generator

# Searching method and domain
param_gen = ParameterGrid([
            (0.1,5.,100),
            (0.1,5.,100)
            ])

# Solve
sols = solve(de, param_gen)

# Remove similar solutions
steadies = unique(sols)

# Jacobian
jac_ms = j_gen.(steadies)

# Stability
stab_modes = StabilityType.(jac_ms)

```


## Multi-threading

To enable multi-threading. One needs to set up threads outside Julia. Use the following command to start the REPL.

```sh
julia --threads 4 # 4 is the number of the thread you want.
```
review [the Thread documentation](https://docs.julialang.org/en/v1/manual/multi-threading/) for further info.

##  Methods

### Steady-states Searching for Differential equations

Theoretically, The steady states of differential equations can be analtically devised by letting the derivaitatives of time equal to zero. However, in most of cases, the analyical solution of steady-states
