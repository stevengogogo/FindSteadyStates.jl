module FindSteadyStates

import DifferentialEquations
import ModelingToolkit

using DifferentialEquations: SteadyStateProblem, solve, Tsit5,AutoTsit5, Rosenbrock23, EnsembleProblem, EnsembleThreads, remake, ODEProblem, solve, SSRootfind, EnsembleSolution

using Random: shuffle!, rand
using LinearAlgebra: eigvals

using Parameters: @with_kw, @unpack 



include("types.jl")
include("utils.jl")

# Paramger Generator
include("param_gen/types.jl")
include("param_gen/utils.jl")
include("param_gen/sampling.jl")
include("param_gen/grid_search.jl")

# Solvers
include("solve.jl")

# Stability
include("jacobian.jl")


end
 