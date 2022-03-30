export get_sol2array, unique_solutions

"""Get the vector of vectors of results. `sol` can be `:EnsembleSolution` or other solutions from `DifferentialEquations.solve`
"""
get_sol2array(sol) = getfield.(sol.u, :u)

"""

```julia
unique_solutions(sols; tol_digit=4)
```

Filter unique steady-state solutions `sols` with tolerance to `tol_digit` significant digits.
"""
function unique_solutions(sols; tol_digit::Int=4)
    result = map(sols) do sol
        round.(sol.u, sigdigits=tol_digit)
    end
    unique!(result)
    return result
end