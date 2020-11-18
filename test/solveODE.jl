@testset "Solve ODEs" begin
    "sample ode function"
    f_(u,p,t) = -1.01*u

    ExpDecay = DEsteady(func=f_, p=1.0, u0=3.0)

    # Ordinary solving
    prob = SteadyStateProblem(ExpDecay.func, ExpDecay.u0, ExpDecay.p)
    sol = solve(prob, ExpDecay.method)
    
    # With finc, u, p  wrapper
    sol_ = solveSS(ExpDecay.func, ExpDecay.u0, ExpDecay.p; method=ExpDecay.method )

    # With ode prameters
    sol_2 = solve(ExpDecay)

    # Solve Time-series
    de = ODEtime(func=f_, u0=3.0, p=1.0, tspan=(0.0,100.0), method= AutoTsit5(Rosenbrock23()))    
    sol_time = solve(de)

    @test sol.u == sol_.u
    @test sol_2.u == sol.u
end


@testset "Threading Grid" begin
    f_(u,p,t) = -1.01*u
    us = ParameterGrid([(1.,3.,3)])

    de = DEsteady(func = f_, p=1.0, u0=us[1], method= Tsit5() )

    solve(de)

    @test length(solve(de, us)) == length(us) # mulit-threading mehod
end


