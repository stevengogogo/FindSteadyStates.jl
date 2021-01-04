#=
Objective
---------
Use customized root-finding method.

Finding
-------
Name tuple is allowed
=#

include("testutils.jl") 

de = DEsteady(func=bistable_ode!, p=Vector(p_), u0= Vector(u_1), method=SSRootfind(nlsolve = (f,u0,abstol) -> (res=NLsolve.nlsolve(f,u0,autodiff=:forward,method=:newton,iterations=Int(1e6),ftol=abstol);res.zero) ))

sol = solve(de)
sol.retcode == :Success

#=
With boundary
=#
de_b = DEsteady(de, method=SSRootfind(nlsolve = (f,u0,abstol) -> (res=NLsolve.nlsolve(f,u0, zeros(length(u0)), fill(Inf, length(u0)) ,autodiff=:forward,method=:newton,iterations=Int(1e6),ftol=abstol);res.zero) )
)
