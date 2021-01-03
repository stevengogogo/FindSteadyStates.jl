#=
Test the wrapper function. 
=#

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

