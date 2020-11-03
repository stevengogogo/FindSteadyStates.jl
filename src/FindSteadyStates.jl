module FindSteadyStates

using DifferentialEquations: SteadyStateProblem, solve, AutoTsit5, Rosenbrock23


include("types.jl")
include("sampling.jl")
include("solve.jl")



end
