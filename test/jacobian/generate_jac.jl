#=
Test the wrapper function. 

Reference
---------
1. https://github.com/stevengogogo/FindSteadyStates.jl/issues/29
=#

include("model.jl")

function fixedpoint_gen(func, u0, p, ranges)


    # Define a problem
    de = DEsteady(func=func, p=p, u0= u0, method=SSRootfind())
    
    j_gen = jacobian(de) # jacobian generator
    
    # Searching method and domain
    param_gen = ParameterGrid(ranges)
    
    # Solve
    sols = solve(de, param_gen)
    
    # Remove similar solutions
    steadies = unique(sols)
    
    
    # Jacobian
    jac_ms = j_gen.(steadies)
    
    
    # Stability
    stab_modes = StabilityType.(jac_ms)
    
    
    return steadies, jac_ms, jac_ms
    
end 


func_ = bistable_model.func 
p_ = bistable_model.p
u0_ = bistable_model.u0


fixedpoint_gen(func_, u0_, p_, [1:0.1:2, 1:0.1:2])