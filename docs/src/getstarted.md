
```@setup exp
    using FindSteadyStates
    using DifferentialEquations
```

# Get Started


```julia
using FindSteadyStates
using DifferentialEquations
```

## Create Differential Equation System

The standard way to create DE system is to create a derivative function in the form of `f(du,u,p,t)` with preallocated derivatives (`du`), initial variables ('u'), parameters (`p`) and time ('t')

```@example exp; continued = true

function bistable_ode!(du, u, p ,t)
	s1, s2 = u
	K1, K2, k1, k2, k3, k4, n1 , n2  = p
	du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
	du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 
end

```

!!! tips "NameTuple may cause error"
    One may want to use `NameTuple` like `LabelledArrays` to create Tuple array and apply to the ode function. However, this may cause `getindex undefined error` for Jacobian Calculation via `ModelingToolkit`, but still safe with solving steady states with `NameTuple` as returns.

 
## Create DE Problem for Solving 


```@example exp; continued = true

de = DEsteady(func = bistable_ode!,
         p =  [1.,1.,20.,20.,5.,5.,4.,4.],
         u0 = [3.,1.],
         method = SSRootfind()
         )
```

!!! tips "Method for solving steady state"
    The `DEsteady.method` will further be used for `DifferentialEquation.solve`. Both dynamic solver (`Dynamicss` which reaches steady states by solving DE) and root finding (`SSRootfind`) can get the **stable point**. However, only `SSRootfind` can find the **saddle point** if the initial values is near by.


The system is now well organized and ready to be solved.

```@example exp; continued = true

sol = solve(de)

```

## Exploring the initial states

To find all the steady states, one needs to sample the initial state by grid or random search. To begin with, the `ParameterGrid` (grid search) and `ParameterRandom` (random search) are useful generator for iterating and returning the parameter set.

```@example exp; continued = true

    param_rand = ParameterRandom(
        methods= [
            Uniform(0.,100.),
            Uniform(0.,100.)
        ],
        len= 100
    )

     param_grid = ParameterGrid(
        param_ranges= [
            [0.,100.,100],
            [0.,100.,100]
        ]
    )

```

```@example  exp; continued = true

     println(param_grid)
```


## Solve solutions with multi-threading


**Random Search**

```@example exp; continued = true

    sols_rand = solve(de, param_rand)

```


**Grid Search**

```@example exp
    sols_grid = solve(de, param_grid)
```