# Models

include("model.jl")

@testset "Rober model" begin

    ## Solve 
    u = rober_model.u0
    p = rober_model.p
    rober = rober_model.func

    ## Create jacobian genreator
    j_gen = jacobian(rober, u, p)

    ## Calculate jacbian
    rober_j =j_gen(u, p)


    ## Test
    @test size(rober_j) == (3,3)

end



@testset "Bistable model" begin

    @unpack func, p, u0 = bistable_model

    # Define a problem
    de = DEsteady(func=func, p=p, u0= u0, method=SSRootfind())

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