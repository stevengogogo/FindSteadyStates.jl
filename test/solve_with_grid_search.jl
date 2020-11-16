@testset "Bistable System" begin 

"""
The bistable model of mutual antagonism. To perform the bistability, the parameters are defined symmetrically, contributing to a stable system with steady-states determined by the initial state.

In this section, we are going to examine wheter this package can successfully find two steady states by grid searching and predefined ranges.


Reference
---------
1. p.82-p.83, Figure 4.8. Ingalls, B. P. (2013). Mathematical modeling in systems biology: an introduction. MIT press.
"""
function bistable_ode!(du, u, p ,t)
	s1, s2 = u.s1, u.s2
	K1, K2, k1, k2, k3, k4, n1 , n2  = p.K1, p.K2, p.k1, p.k2, p.k3, p.k4, p.n1 , p.n2 
	du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
	du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 
end

p_ = LVector(K1=1., K2=1., k1=20., k2=20., k3=5., k4=5., n1= 4., n2=4.)

u_1 = LVector(s1=3., s2=1.)
u_2 = LVector(s1=1., s2=3.)


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


@info "Grid search: Single-core"
@testset "Type renew" begin
	param_gen = ParameterGrid([(0.,5.,100), (0.,5.,1000)])

	de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind())
	de_ = de([100.0,200.0])

	@time sols = map(param_gen) do u
		de_ = de(u) 
		return solve(de_)
	end;

	@test length(sols) == length(param_gen)
	@test de_.u0 != de.u0
end

@info "Grid search: Multi-threading. With Number of threads = $(Threads.nthreads())"
@testset "Find steady state with given region: Multi-threading" begin

	param_gen = ParameterGrid([(0.1,5.,100), (0.1,5.,100)])

	de = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=Tsit5())

	@time sols = solve(de, param_gen)

	@test length(sols) == length(param_gen)

end


end 

