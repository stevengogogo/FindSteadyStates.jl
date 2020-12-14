include("testutils.jl")

de = DEsteady(func=bistable_ode!, p=Vector(p_), u0= Vector(u_1), method=SSRootfind(
    nlsolve = (f,u0) -> NLsolve.nlsolve(f,u0,autodiff=true,method=:newton,iterations=Int(1e6))
))

#@show solve(de)
