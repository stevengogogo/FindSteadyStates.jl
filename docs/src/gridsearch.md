# Grid Search

```julia
using FindSteadyStates
```

## Method 

The grid search algorithm provides a greedy search method to exploring all the parameter set. To use grid search method in `FindSteadyStates.jl`, the range of each agents can be assigned with the list of ranges. 


## Usage 

The ranges are specified in `ParameterGrid` in the following way:

```julia

ranges = [(1.,10.,10), (1.,10.,20)] # (start, end, grid numer)
param_range = ParameterGrid(ranges)

```

```julia-repl
julia> param_gen = ParameterGrid([(1.,10.,3), (4., 10., 2.)])
6-element ParameterGrid:
 [1.0, 4.0]
 [4.0, 4.0]
 [7.0, 4.0]
 [1.0, 7.0]
 [4.0, 7.0]
 [7.0, 7.0]
```




## Reference
1. grid_search.jl of ScikitLearn.jl . ([link](https://github.com/cstjean/ScikitLearn.jl/blob/master/src/grid_search.jl))