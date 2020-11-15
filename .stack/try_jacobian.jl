"""



"""

using DifferentialEquations
using FindSteadyStates
using Plots 
using ModelingToolkit
using LabelledArrays
using Parameters
## Build model
function rober(du, u, p, t)
    y1, y2, y3 = u
    k1, k2, k3 = p

    du[1] = -k1*y1 + k3*y2*y3 
    du[2] = k1*y1 - k2*y2^2. - k3*y2*y3 
    du[3] = k2*y2^2.

end 

function rober_jac(J,u,p,t)
    y₁,y₂,y₃ = u
    k₁,k₂,k₃ = p
    J[1,1] = k₁ * -1
    J[2,1] = k₁
    J[3,1] = 0
    J[1,2] = y₃ * k₃
    J[2,2] = y₂ * k₂ * -2 + y₃ * k₃ * -1
    J[3,2] = y₂ * 2 * k₂
    J[1,3] = k₃ * y₂
    J[2,3] = k₃ * y₂ * -1
    J[3,3] = 0
    nothing
  end



## Solve without jacobian
prob = ODEProblem(rober,[1.0,0.0,0.0],(0.0,1e5),(0.04,3e7,1e4))
sol = solve(prob)


## SOlve with jacobian
de = modelingtoolkitize(prob)

jac = eval(ModelingToolkit.generate_jacobian(de)[2])



f = ODEFunction(rober, jac=jac)
prob_jac = ODEProblem(f,[1.0,0.0,0.0],(0.0,1e5),(0.04,3e7,1e4))

@show prob_jac

sol = solve(prob_jac)

@show rober_jac(zeros(3,3), [0.0184367966813563, 7.51141018910664e-8, 0.9815631282045398],(0.04,3.,10.),(0.0,10.))

jac(zeros(3,3),[0.0184367966813563, 7.51141018910664e-8, 0.9815631282045398],(0.0,1e5),(0.04,0.,0.) )
## Plotting
#plot(sol,tspan=(1e-2,1e5),xscale=:log10)

## 

using ForwardDiff
using LinearAlgebra

function d(x)
    return -exp.(x) 
end

jac = ForwardDiff.jacobian(d, [0.5])

eigvals(jac)



## 

@with_kw struct input_func
    func 
    p 
end

function (self::input_func)(x)
    return self.func(x, x, self.p, (0.0,1.0))
end

function get_jac(de_func, u)
    dj = input_func(de_func.func, de_func.p)
    return ForwardDiff.jacobian(dj, convert(Vector,u))
end


function get_jac2(de_func, u)

    return ForwardDiff.jacobian!(u->de_func(u,u,de_func.p, (0.0,1.0)), u)
end

function bistable_ode!(du, u, p ,t)
	s1, s2 = u
	K1, K2, k1, k2, k3, k4, n1 , n2  = p
	du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
	du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 
end

p_ = convert(Vector, LVector(K1=1., K2=1., k1=20., k2=20., k3=5., k4=5., n1= 4., n2=4.))

u_1 = convert(Vector, LVector(s1=3., s2=1.) )
u_2 = convert(Vector, LVector(s1=1., s2=3.) )

dss = DEsteady(func=bistable_ode!, u0=u_1, p=p_, method=Tsit5())

sol = solve(dss)

get_jac2(dss, sol.u)

## 

function bistable_ode!(du, u, p ,t)
	s1, s2 = u.s1, u.s2
	K1, K2, k1, k2, k3, k4, n1 , n2  = p.K1, p.K2, p.k1, p.k2, p.k3, p.k4, p.n1 , p.n2 
	du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
	du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 
end

p_ = LVector(K1=1., K2=1., k1=20., k2=20., k3=5., k4=5., n1= 4., n2=4.)

u_1 = LVector(s1=3., s2=1.)
u_2 = LVector(s1=1., s2=3.)


## 

function bistable_ode!(du, u, p ,t)
	s1, s2 = u
	K1, K2, k1, k2, k3, k4, n1 , n2  = p
	du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
	du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 
end

p_ = convert(Vector, LVector(K1=1., K2=1., k1=20., k2=20., k3=5., k4=5., n1= 4., n2=4.))

u_1 = convert(Vector, LVector(s1=3., s2=1.) )
u_2 = convert(Vector, LVector(s1=1., s2=3.) )


prob = SteadyStateProblem(bistable_ode!, u_1, p_)
de = modelingtoolkitize(prob)
jac = eval(ModelingToolkit.generate_jacobian(de)[2])
f = ODEFunction(bistable_ode!, jac=jac)
prob_jac_ = SteadyStateProblem(bistable_ode!, u_1 ,p_)

sol = solve(prob)

## 
prob = SteadyStateProblem(bistable_ode!, [1.2,1.2], p_)
sol = solve(prob, SSRootfind())
jac_init = zeros(2,2 ) 
jac(jac_init, sol.u, p_, (1.0,23.5))

@show jac_init
@show eigvals(jac_init)