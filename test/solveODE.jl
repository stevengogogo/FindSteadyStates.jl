@testset "Solve ODEs" begin
    "sample ode function"
    f(u,p,t) = -1.01*u

    ExpDecay = FindSteadyStates.DEsteady(func=f, p=1.0, u0=3.0, SteadyStateMethod=Tsit5())

    # Ordinary solving
    prob = SteadyStateProblem(ExpDecay.func, ExpDecay.u0, ExpDecay.p)
    sol = solve(prob, FindSteadyStates.Default_SSMETHOD)

    # With finc, u, p  wrapper
    sol_ = FindSteadyStates.solve_SSODE(ExpDecay.func, ExpDecay.u0, ExpDecay.p; method=ExpDecay.SteadyStateMethod )

    # With ode prameters
    sol_2 = FindSteadyStates.solve_SSODE(ExpDecay)

    @test sol.u == sol_.u
    @test sol_2.u == sol.u
end
