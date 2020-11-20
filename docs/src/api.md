```@meta
CurrentModule = FindSteadyStates
DocTestSetup  = quote
    using MyPackage
end
```

# FindSteadyStates

```@index
```

## Searching generator 
```@docs
ParameterGrid
ParameterRandom
```

## Meta data of Differential Equations

```@docs
DEsteady
ODEtime
FindSteadyStates.DEmeta
```

## Solvers

The ['solve'](@ref) function is extended from the `DifferentialEquations.solve`.

```@docs
solve
```

## Stability and Jacobian

```@docs
jacobian
StabilityType
```

```@audodocs
Modules = [FindSteadyStates,]
Private = false
```