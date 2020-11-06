export get_sol2array, flatten
"Get the vector of vectors of results. `sol` can be `:EnsembleSolution` or other solutions from `DifferentialEquations.solve`
"
get_sol2array(sol) = getfield.(sol.u, :u)

flatten(arr_arrs) = collect(Iterators.flatten(arr_arrs))
