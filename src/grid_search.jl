# Grid search algorithm. 
# Reference:  https://github.com/cstjean/ScikitLearn.jl/blob/master/src/grid_search.jl

export ParameterGrid, recursive_index

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

    len = mul(Int,[ i[end] for i in param_ranges ])
    indexes = Array(1:1:len)
    shuffle!(indexes) # indexes to be sampled, shuffledP
    return ParameterGrid(param_ranges, len, indexes);
end

function Base.length(self::ParameterGrid)
    return self.len
end

Base.size(self::ParameterGrid) = (Base.length(self),)


## Iterator 
"""Get the parameters that would be ```ind``` th in iteration

The total sample number is # to do 

Paremeters 
----------
- `ind` {int}: The iteration index

Returns
-------
- `params`: list of numbers in the range of `ParameterGrid.param_ranges`
"""
function Base.getindex(self::ParameterGrid, ind::Int)
    vec_i = recursive_index(self.param_ranges, ind) # number in grid sample space
    
end 


"""
Recursive indexing.
This function uses list of ranges and index to provide a vector of indexes.

Example
-------
```julia-repl 
julia> ranges = [(1,2,2), (4,45,2)]
julia> param_range = ParameterGrid(ranges)
julia> vec_i = recursive_index(param_range, 4)
julia> vec_i
[2,2]
```
"""
function recursive_index(self::ParameterGrid, ind) :: Array{Integer,1}

    lens = [ i[end] for i in self.param_ranges]

    index = self.indexes[ind]

    vec_param = zeros(length(self.param_ranges)) #output vector 

    for i in eachindex(vec_param)
        if i == 1 # first index
            id = ind % lens[i] # mod
            if id == 0 # end of Array
                id = lens[i]
            end
            vec_param[i] = id
        else # otherwise
            l = mul(lens[1:i-1]) # multiply from first to the previous neighbor digit 
            mov = (ind-1) ÷ l  # move 1 digit when the prevous layer exceed length
            id = mov % lens[i] + 1
            vec_param[i] = id
        end
    end

    return vec_param

end
