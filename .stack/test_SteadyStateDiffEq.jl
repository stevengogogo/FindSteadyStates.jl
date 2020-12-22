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

# Solve 
sol = solve(prob,SSRootfind(nlsolve = (f,u0) -> NLsolve.nlsolve(f,u0,autodiff=true,method=:newton,iterations=Int(1e6))))