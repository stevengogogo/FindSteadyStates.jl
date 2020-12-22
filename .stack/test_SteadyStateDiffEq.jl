using DifferentialEquations
using NLsolve 

function f(du, u, p,t )
    du[1] = 2- 2u[1]
    du[2] = u[1] - 4u[2]
end

u0 = zeros(2)

# Build problem
prob = SteadyStateProblem(f,u0)
sol = solve(prob,SSRootfind())

sol = solve(prob,SSRootfind(nlsolve = (f,u0,abstol) -> (res=NLsolve.nlsolve(f,u0,autodiff=:forward,method=:newton,iterations=Int(1e6),ftol=abstol);res.zero) ))

