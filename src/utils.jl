export get_sol2array, flatten
"""Get the vector of vectors of results. `sol` can be `:EnsembleSolution` or other solutions from `DifferentialEquations.solve`
"""
get_sol2array(sol) = getfield.(sol.u, :u)

flatten(arr_arrs) = collect(Iterators.flatten(arr_arrs))

"""
Multiplication of series.
"""
function mul(array1D) 
    m = 1
    for i in array1D
        m = m * i
    end
    return m
end

"""
Multipication of series with type converting.
"""
function mul(type, array1D) 
    m = 1
    for i in array1D
        m = m * i
    end
    return convert(type, m)
end

