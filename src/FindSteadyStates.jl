module FindSteadyStates

import DifferentialEquations

using DifferentialEquations: SteadyStateProblem, solve, Tsit5,AutoTsit5, Rosenbrock23, EnsembleProblem, EnsembleThreads, remake, ODEProblem, solve, SSRootfind



using Parameters
using Random: shuffle!



include("types.jl")
include("utils.jl")
include("param_gen/types.jl")
include("param_gen/sampling.jl")
include("param_gen/grid_search.jl")
include("solve.jl")

end
 