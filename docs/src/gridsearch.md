# Grid Search

## Method 

The grid search algorithm provides a greedy way to exploring all the parameter set. To use grid search method in `FindSteadyStates.jl`, the range of each agents can be assigned with the list of ranges. 


## Usage 
The ranges are specified in `ParameterGrid` in the following way:

```julia

ranges = [(1.,10.,10), (1.,10.,20)] # (start, end, grid numer)
param_range = ParameterGrid(ranges)

```