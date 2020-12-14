@testset "Bistable System" begin 

include("testutils.jl")


@testset "Time-series" begin

	de1, de2 = [ODEtime(func=bistable_ode!, 
				u0 = u, 
				p = p_, 
				tspan=(0.,4.)) for u in [u_1, u_2]]

	sol1, sol2 = solve.([de1, de2])

	@test sol1[end].s1 > sol1[end].s2
	@test sol2[end].s2 > sol2[end].s1

	# Plotting
	#p1, p2 = plot.([sol1, sol2])
	#pp_ = plot(p1, p2)
	#plot!(pp_, title="Bistable System")
	#display(pp_)
end

@testset "Calculate Steady State from given initial state" begin
	de1, de2 = [ DEsteady(func = bistable_ode!,
							p=p_,
							u0=u,
							method= Tsit5()) 
							for u in [u_1, u_2] ]

	sol1, sol2 = solve.([de1, de2])

	@test sol1.u.s1 > sol1.u.s2
	@test sol2.u.s2 > sol2.u.s1
end


@testset "Find steady state with given region: Single core computation" begin
        
	param_gen = ParameterGrid([(0.1,5.,10), (0.1,5.,10)])

	de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=Tsit5())

	u_ = de.u0

	sol = solve(de) # create `sol` struct 
	sols = Vector{Any}(undef,length(param_gen)) # allocate the memory
	
	
	sols = map(param_gen) do u
		u_ .= u 
		de_ = de(u_)
		return solve(de_)
	end # there is no significantly difference between using for loop and map. 

	for s in sols
		println(s.u)
	end


end


@info "Grid search"

@testset "Type renew" begin
	param_gen = ParameterGrid([(0.,5.,100), (0.,5.,1000)])

	de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind())
	de_new = de([100.0,200.0])

	@time sols = map(param_gen) do u
		de_i = de(u) 
		return solve(de_i)
	end;

	@test length(sols) == length(param_gen)
	@test de_new.u0 != de.u0
end



@testset "Find steady state with given region: Multi-threading" begin

	param_gen = ParameterGrid([(0.1,5.,100), (0.1,5.,100)])

	de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind())

	@time sols = solve(de, param_gen)

	@test length(sols) == length(param_gen)

end


@info "Random Search"

@testset "Random search: multi-threading ($(Threads.nthreads()))" begin

	param_gen = ParameterRandom([(0,1), (0,10)], Uniform(), 10000)

	de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind())

	@time sols = solve(de, param_gen; ensemble_method=EnsembleThreads())

	@test length(sols) == length(param_gen)

end



end 

