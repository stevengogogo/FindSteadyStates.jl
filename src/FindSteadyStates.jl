module FindSteadyStates

using DifferentialEquations
using Parameters



include("Sampling.jl")
include("Solve.jl")

@with_kw struct domain
    low::Number
    high::Number
end

@with_kw struct 

function fixedpoint_gen(func, ranges, RandNum, EqNum)


end




end
