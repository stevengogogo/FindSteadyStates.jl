# Models

@testset "Rober model" begin
    function rober(du, u, p, t)
        y1, y2, y3 = u
        k1, k2, k3 = p

        du[1] = -k1*y1 + k3*y2*y3 
        du[2] = k1*y1 - k2*y2^2. - k3*y2*y3 
        du[3] = k2*y2^2.

    end 



    ## Solve 

    ## Create jacobian genreator
    j_gen = jacobian(rober, [1.0,0.0,0.0], [1.0,0.0,0.0])


    ## Calculate jacbian
    rober_j =j_gen([1.0,1.0,1.0], [1.0,0.0,0.0])



    ## Test

    @test size(rober_j) == (3,3)

end


@test "Bistable model" begin
    function bistable_ode!(du, u, p ,t)
        s1, s2 = u
        K1, K2, k1, k2, k3, k4, n1 , n2  = p
        du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
        du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 
    end

    p_ = [1., 1., 20., 20., 5., 5.,  4., 4.]

    u_1 = [3., 1.]

    de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind())

    param_gen = ParameterGrid([
                (0.1,5.,100), 
                (0.1,5.,100)
                ])

    sols = solve(de, param_gen)

    steadies = unique(sols)


    j_gen = jacobian(de)


    bis_js = map(ss->j_gen(ss,p_), steadies)
    eigvals.(bis_js)
    @test size(bis_j) == (length(u_1), length(u_2))

end