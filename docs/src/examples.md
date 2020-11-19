```@setup tutorial
    using FindSteadyStates 
    using DifferentialEquations 
    using PyPlot
```



# Prerequisite

In this section, classicial ordinary differetnaial equations are used to demonstrate the function of `FindSteadyStates.jl`. Before entering the following sections, one needs to make sure that `FindSteadyState.jl` and `DifferentialEquations.jl` are successfully installed and precompiled. 

```@example tutorial
using FindSteadyStates
using DifferentialEquations
using LabelledArrays
```

# Exponential Decay 

```@example tutorial ; continued = true
    deS = DEsteady(func=x->x, u0= [1.0,2.0], p=1.0)

```

```@example tutorial ; continued = true
    deS = DEsteady(func=x->x, u0= [1.0,2.0], p=1.0)

```

```@example tutorial
    fig, ax = subplots()
    ax = plot([1,2],[3,4])
    fig.savefig("test.svg") # hide
    @info pwd()
```
![](test.svg)

# Bistable Model





# References




## Unstable
