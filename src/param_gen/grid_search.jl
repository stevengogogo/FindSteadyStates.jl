# Grid search algorithm. 
# Reference:  https://github.com/cstjean/ScikitLearn.jl/blob/master/src/grid_search.jl

export ParameterGrid, recursive_index, UniformGrid, LogGrid




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

```julia-repl

julia> ParameterGrid([ [1,1000,5], [1,3,1]]; method=LogGrid())
5-element ParameterGrid:
 [1.0999, 3.0]
 [1.999, 3.0]
 [10.99, 3.0]
 [100.9, 3.0]
 [1000.0, 3.0]
```

"""
@with_kw struct ParameterGrid <: ParameterGenerator
    param_ranges
    len
    indexes
    method = UniformGrid()
end

"""
Construct parameter grid from list of ranges (`[start, end, grid_num]`). The grid distribution is default to be uniform. 
"""
function ParameterGrid(param_ranges; method=UniformGrid()::GridSampler, SHUFFLE=false)
    len = convert(Int, prod((i[end] for i in param_ranges)))
    indexes = Array(1:1:len)
    SHUFFLE ? shuffle!(indexes) : nothing # indexes to be sampled, shuffled
    return ParameterGrid(param_ranges, len, indexes, method)
end


function ParameterGrid(param_ranges::AbstractArray{T,1}; method=UniformGrid()::GridSampler, SHUFFLE=false) where {T<:AbstractRange}

    param_ranges_ = ranges2tuples(param_ranges)

    return ParameterGrid(param_ranges_; method=method, SHUFFLE=SHUFFLE)
end





"""
Grid object with ranges and distribution function 

"""
function ParameterGrid(param_ranges, method)
    len = convert(Int, prod((i[end] for i in param_ranges)))
    indexes = Array(1:1:len)
    shuffle!(indexes) # indexes to be sampled, shuffledP
    return ParameterGrid(param_ranges, len, indexes, method)
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
    ind_ = self.indexes[ind]
    vec_i = recursive_index(self, ind_) # number in grid sample space

    values = zeros(length(vec_i))
    for i in eachindex(values)
        rang = self.param_ranges[i]
        str, ed, grid_num = rang
        values[i] = self.method(str, ed, grid_num, vec_i[i])
    end
    return values
end

"""
get the number of a given range from index with uniform distribution.

```julia-repl
julia> FindSteadyStates.uniformGrid(1,10,3, 2)
5
```
"""
struct UniformGrid <: GridSampler end

function (self::UniformGrid)(str_num, end_num, grid_num, ind)
    @assert end_num >= str_num  # end number is equal or bigger than start
    @assert ind <= grid_num # grid size should greater or equal to the specified index
    move = (end_num - str_num) / (grid_num - 1)  # Step size. Start and end is included. Therefore: grid_num -1
    return str_num + move * (ind - 1.0)
end

@with_kw struct LogGrid <: GridSampler
    decay = 10.0
end

function (self::LogGrid)(str_num, end_num, grid_num, ind)
    @assert end_num > str_num  # end number is bigger than start
    @assert ind <= grid_num # grid size should greater or equal to the specified index
    step = (end_num - str_num)
    move = step / (self.decay)^(grid_num - ind)
    return str_num + move
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
function recursive_index(self::ParameterGrid, ind)::Array{Integer,1}

    lens = [i[end] for i in self.param_ranges]

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
            l = prod(lens[1:i-1]) # multiply from first to the previous neighbor digit 
            mov = (ind - 1) ÷ l  # move 1 digit when the prevous layer exceed length
            id = mov % lens[i] + 1
            vec_param[i] = id
        end
    end

    return vec_param

end
