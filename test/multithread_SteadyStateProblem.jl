@testset "Multithread for solving steady states: single value ODE function" begin

    atol = 1e-10
    # Linear ODE which starts at 0.5 and solves from t=0.0 to t=1.0
    de_func(u, p, t) = 0.9u * p

    us = [1, 2, 3] # vec
    p_ = 1
    u_ss_real = zeros(length(us))

    sim = solve_SSODE_threads(de_func, us, p_)
    res = collect(Iterators.flatten(get_sol2array(sim)))

    @test isapprox(res, u_ss_real; atol=atol)

end

@testset "Multithread for solving steady states: 2D ODE functions" begin

    function f(du, u, p, t)
        du[1] = p[1] * u[1]
        du[2] = p[2] * u[2]
    end

    us = [[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]]
    p = [0.9, 0.8]

    ode = DEsteady(func=f, p=p, u0=us, method=SSRootfind())

    @time sim = solve_SSODE_threads(f, us, p; method=Tsit5())
    @time sim_ = solve_SSODE_threads(ode) #Rootfind method 


    @testset "compare solutions" for us_ in sim.u
        s = us_.u
        @test isapprox(s, [0.0, 0.0]; atol=1e-10)
    end

    @testset "compare solutions" for us_ in sim_.u
        s = us_.u
        @test isapprox(s, [0.0, 0.0]; atol=1e-10)
    end

end
