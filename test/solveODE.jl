@testset "Solve ODEs" begin
    "sample ode function"
    f_(u,p,t) = -1.01*u

    ExpDecay = DEsteady(func=f_, p=1.0, u0=3.0, SteadyStateMethod=Tsit5())

    # Ordinary solving
    prob = SteadyStateProblem(ExpDecay.func, ExpDecay.u0, ExpDecay.p)
    sol = solve(prob, ExpDecay.SteadyStateMethod)
    
    # With finc, u, p  wrapper
    sol_ = solveSS(ExpDecay.func, ExpDecay.u0, ExpDecay.p; method=ExpDecay.SteadyStateMethod )

    # With ode prameters
    sol_2 = FindSteadyStates.solve(ExpDecay)

    # Solve Time-series
    de = ODEtime(func=f_, u0=3.0, p=1.0, tspan=(0.0,100.0), method= AutoTsit5(Rosenbrock23()))    
    sol_time = solve(de)

    @test sol.u == sol_.u
    @test sol_2.u == sol.u
end

