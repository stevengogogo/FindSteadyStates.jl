# Models

function rober(du, u, p, t)
    y1, y2, y3 = u
    k1, k2, k3 = p

    du[1] = -k1*y1 + k3*y2*y3 
    du[2] = k1*y1 - k2*y2^2. - k3*y2*y3 
    du[3] = k2*y2^2.

end 

@testset "Rober model" begin

    ## Solve 
    u = [1.0,0.0,0.0]
    p = [1.0,0.0,0.0]

    ## Create jacobian genreator
    j_gen = jacobian(rober, u, p)

    ## Calculate jacbian
    rober_j =j_gen(u, p)


    ## Test
    @test size(rober_j) == (3,3)

end


function bistable_ode!(du, u, p ,t)
    s1, s2 = u
    K1, K2, k1, k2, k3, k4, n1 , n2  = p
    du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
    du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 
end

p_ = [1., 1., 20., 20., 5., 5.,  4., 4.]

u_1 = [3., 1.]


@testset "Bistable model" begin


    # Define a problem
    de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind())

    j_gen = jacobian(de) # jacobian generator

    # Searching method and domain
    param_gen = ParameterGrid([
                (0.1,5.,100), 
                (0.1,5.,100)
                ])

    # Solve
    sols = solve(de, param_gen)

    # Remove redundancy
    steadies = unique(sols)

    # Jacobian
    jac_ms = j_gen.(steadies)

    # Stability
    stab_modes = StabilityType.(jac_ms)


    # Testing and validation
    num_stable = sum(getfield.(stab_modes, :stable))
    num_saddle = sum(getfield.(stab_modes, :saddle))

    @test length(steadies) == 3 # 3 steady states 
    @test num_stable == 2
    @test num_saddle == 1

    @testset "Jacobian generating methods with state redefinition" begin
        j_gen = jacobian(de)
        j_init = j_gen()
        bis_js = map(ss->j_gen(ss,p_), steadies)
        bis_js2 = map(ss->j_gen(ss), steadies)
        @test size(bis_js[1]) == (length(u_1), length(u_1))
    end


end



@testset "Jacobian functions" begin 

saddle_es = [1.0, -1.0, 2.0, 3.0]
saddle_es_damping = [1.0, -1.0, 2+1im, 2-1im]
stable_es_no_damping = [-1.0,-10, -1, -1 ]
stable_es_damping = [-1.0,-10, -1+10im, -1-10im ]
neutral_point = [ 0+1im, 0-1im]
    
@test FindSteadyStates.is_stable( saddle_es ) == false
@test FindSteadyStates.is_stable( saddle_es_damping ) == false
@test FindSteadyStates.is_stable( stable_es_no_damping ) == true 
@test FindSteadyStates.is_stable( stable_es_damping) == true
@test FindSteadyStates.is_stable( neutral_point ) == false 

@test FindSteadyStates.is_unstable( saddle_es  ) == true
@test FindSteadyStates.is_unstable( saddle_es_damping   ) == true
@test FindSteadyStates.is_unstable( stable_es_no_damping) == false
@test FindSteadyStates.is_unstable( stable_es_damping) == false
@test FindSteadyStates.is_unstable( neutral_point ) ==  true  

@test FindSteadyStates.is_saddle( saddle_es  ) == true
@test FindSteadyStates.is_saddle( saddle_es_damping  ) == true
@test FindSteadyStates.is_saddle( stable_es_no_damping) == false
@test FindSteadyStates.is_saddle( stable_es_damping) == false
@test FindSteadyStates.is_saddle( neutral_point ) ==  false

end