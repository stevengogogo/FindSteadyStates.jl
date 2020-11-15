# Adding Hone
## Pkg Registry
```@repl
using Pkg
Pkg.add("https://github.com/stevengogogo/FindSteadyStates.jl")
Pkg.add("DiffererntialEquations")

using FindSteadyStates
using DifferentialEquations
```
## Unstable
```@repl
julia> ]
pkg> add Hone#Unstable
```
## Specified Versions
```@example
julia> ]
pkg> add Hone#0.0.1
```
```@autodocs
Modules = [Hone]
```