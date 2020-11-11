var documenterSearchIndex = {"docs":
[{"location":"gridsearch/#Grid-Search","page":"Grid Search","title":"Grid Search","text":"","category":"section"},{"location":"gridsearch/#Method","page":"Grid Search","title":"Method","text":"","category":"section"},{"location":"gridsearch/","page":"Grid Search","title":"Grid Search","text":"The grid search algorithm provides a greedy way to exploring all the parameter set. To use grid search method in FindSteadyStates.jl, the range of each agents can be assigned with the list of ranges. ","category":"page"},{"location":"gridsearch/","page":"Grid Search","title":"Grid Search","text":"The ranges ","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = FindSteadyStates","category":"page"},{"location":"#FindSteadyStates","page":"Home","title":"FindSteadyStates","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [FindSteadyStates]","category":"page"},{"location":"#FindSteadyStates.Log_uniform","page":"Home","title":"FindSteadyStates.Log_uniform","text":"Sampler for log uniform distribution. a,b ∈ (0,∞)\n\n\n\n\n\n","category":"type"},{"location":"#FindSteadyStates.ParameterGrid","page":"Home","title":"FindSteadyStates.ParameterGrid","text":"Grid search iterator for parameters. The sequence of ranges defines the grids to search.\n\nParameters\n\nParameterGrid: Contain list of ranges. The range is in (start, end, points) order.\n\nExamples\n\njulia> ranges = [ (1.,10.,10.), (1.,10.,10.) ] # list of ranges (start_num, stop_num, number of grids`{int}`)\njulia> param_range = ParameterRange(ranges)\n\n\n\n\n\n","category":"type"},{"location":"#FindSteadyStates.Uniform","page":"Home","title":"FindSteadyStates.Uniform","text":"Sampler for uniform distribution\n\n\n\n\n\n","category":"type"},{"location":"#Base.getindex-Tuple{ParameterGrid,Int64}","page":"Home","title":"Base.getindex","text":"Get the parameters that would be ind th in iteration\n\nThe total sample number is # to do \n\nParemeters\n\nind{int}: The iteration index\n\nReturns\n\nparams: list of numbers in the range of ParameterGrid.param_ranges\n\n\n\n\n\n","category":"method"},{"location":"#FindSteadyStates.get_sol2array-Tuple{Any}","page":"Home","title":"FindSteadyStates.get_sol2array","text":"Get the vector of vectors of results. sol can be :EnsembleSolution or other solutions from DifferentialEquations.solve\n\n\n\n\n\n","category":"method"},{"location":"#FindSteadyStates.rand_vec-Tuple{Any}","page":"Home","title":"FindSteadyStates.rand_vec","text":"General method for sampling a vector with individual samplers\n\n\n\n\n\n","category":"method"},{"location":"#FindSteadyStates.rand_vec-Tuple{Integer,FindSteadyStates.Sampler}","page":"Home","title":"FindSteadyStates.rand_vec","text":"generate random vector with uniform distribution rand()\n\n\n\n\n\n","category":"method"},{"location":"#FindSteadyStates.rand_vec-Union{Tuple{AbstractArray{T,1}}, Tuple{T}} where T<:FindSteadyStates.Sampler","page":"Home","title":"FindSteadyStates.rand_vec","text":"Sampling a vector with a list of sampler\n\nREPL\n\nunis = [Uniform(1,2) for i in 1:10]\nvec = rand_vec(unis)\n\n\n\n\n\n","category":"method"},{"location":"#FindSteadyStates.rand_vecU-Tuple{Any}","page":"Home","title":"FindSteadyStates.rand_vecU","text":"General method. domains can be list of tuples\n\n\n\n\n\n","category":"method"},{"location":"#FindSteadyStates.rand_vecU-Tuple{Integer,Domain}","page":"Home","title":"FindSteadyStates.rand_vecU","text":"Uniform sampling of vector\n\n\n\n\n\n","category":"method"},{"location":"#FindSteadyStates.solve_SSODE_threads-Tuple{Any,Any,Any}","page":"Home","title":"FindSteadyStates.solve_SSODE_threads","text":"Multi-thread version of steady-state solver\n\nArguements\n\nfunc: DE function\nus: Vector of vectors of initial variables\np: parameter constant\n\n\n\n\n\n","category":"method"}]
}
