@testset "Solve ODEs" begin
    "sample ode function"
    f(u,p,t) = -1.01*u

    ExpDecay = FindSteadyStates.ODEfunc(func=f, p=1.0)
    u = 1.0
    prob = SteadyStateProblem(ExpDecay.func, u, ExpDecay.p)
    sol = solve(prob, FindSteadyStates.Default_SSMETHOD, reltol=1e-8, abstol=1e-8)
    sol_ = FindSteadyStates.solve_SSODE(ExpDecay, u )

    return sol.u == sol_.u
end
