# Grid search algorithm. 
# Reference:  https://github.com/cstjean/ScikitLearn.jl/blob/master/src/grid_search.jl

export ParameterGrid

"""Grid search iterator for parameters. The sequence of ranges defines the grids to search.

Parameters
----------
- `ParameterGrid`: Contain list of ranges. The range is in `(start, end, points)` order.

Examples
--------
```julia-repl
julia> ranges = [ (1.,10.,10.), (1.,10.,10.) ] # list of ranges (start_num, stop_num, number of grids`{int}`)
julia> param_range = ParameterRange(ranges)
```
"""
struct ParameterGrid <: AbstractVector{Any}
    param_ranges 
    len 
    indexes 
end

function ParameterGrid(param_ranges)
    len = sum(Int,[ i[end] for i in param_ranges ])
    indexes = shuffle!(Array(1:1:len)) # indexes to be sampled, shuffledP
    return ParameterGrid(param_ranges, len, indexes)
end

function Base.length(self::ParameterGrid)
    return self.len
end

Base.size(self::ParameterGrid) = (Base.length(self),)


## Iterator 
"""Get the parameters that would be ```ind``` th in iteration

The total sample number is \$n1\cdot n2 \cdot n3\$

Paremeters 
----------
- `ind`{int}: The iteration index

Returns
-------
- `params`: list of numbers in the range of `ParameterGrid.param_ranges`
"""
function Base.getindex(self::ParameterGrid, ind::Int)
    i = self.indexes[ind] # number in grid sample space
    
end 

