```@setup tutorial
    using FindSteadyStates 
    using DifferentialEquations 
    using LabelledArrays 
```


```@setup img
    using PyPlot
```

# Prerequisite

In this section, classicial ordinary differetnaial equations are used to demonstrate the function of `FindSteadyStates.jl`. Before entering the following sections, one needs to make sure that `FindSteadyState.jl` and `DifferentialEquations.jl` are successfully installed and precompiled. 

```@example
using FindSteadyStates
using DifferentialEquations
using LabelledArrays
```

# Exponential Decay 

```@example tutorial
    deS = DEsteady(func=x->x, u0= LVector(s1=1.0,s2=2.0), p=1.0)

```

```@example tutorial
    deS = DEsteady(func=x->x, u0= LVector(s1=1.0,s2=2.0), p=1.0)

```

```@example img 
    fig, ax = subplots()
    ax = plot([1,2],[3,4])
    fig.savefig("test.svg") # hide
    @info pwd()
```
![](test.svg)

# Bistable Model





# References




## Unstable
