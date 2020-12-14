@testset "Infinite ODE" begin
    """
    ODEsolver reports `NaN` (None) when steady state is absent.
    """
    
    function infinite!(du,u,p,t)
        du[1] = (u[1]-0.5)^2 * p[1] + 0.5 # Impossible to be zero
    end

    de = DEsteady(
        func = infinite!,
        u0 = [0.4],
        p = [1.0],
        method=SSRootfind()
    )

    sol = solve(de)

    @test all(isnan.(sol.u)) #NaN
end

