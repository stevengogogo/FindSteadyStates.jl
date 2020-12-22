include("testutils.jl")

# name tuples are allowed. 
de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind(nlsolve = (f,u0,abstol) -> (res=NLsolve.nlsolve(f,u0,autodiff=:forward,method=:newton,iterations=Int(1e6),ftol=abstol);res.zero) ))

de_ = DEsteady(de, method=SSRootfind())

sol = solve(de)
sol_ = solve(de_)

@testset "Solution" for i in [sol, sol_]
    @test i.retcode == :Success
end

