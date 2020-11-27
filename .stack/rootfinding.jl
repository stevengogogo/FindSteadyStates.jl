using NLsolve


function f!(F, x)
    F[1]=3*x[1]^2+2*x[1]*x[2]+2*x[2]^2+x[3]+3*x[4]-6
    F[2]=2*x[1]^2+x[1]+x[2]^2+3*x[3]+2*x[4]-2
    F[3]=3*x[1]^2+x[1]*x[2]+2*x[2]^2+2*x[3]+3*x[4]-1
    F[4]=x[1]^2+3*x[2]^2+2*x[3]+3*x[4]-3
end

r = mcpsolve(f!, [0., 0., 0., 0.], [Inf, Inf, Inf, Inf],[1.25, 0., 0., 0.5], reformulation = :smooth, autodiff = :forward)


## fef


using SteadyStateDiffEq, DiffEqBase, NLsolve

# `t` is ignored and set to zero
function f(t,u,du)
  du[1] = 2 - 2u[1]
  du[2] = u[1] - 4u[2]
end
u0 = zeros(2)

# Build it directly
prob = SteadyStateProblem(f,u0)
sol = solve(prob,SSRootfind())

# Or just use an existing ODEProblem
prob = ODEProblem(f,u0,(0.0,1.0))
prob = SteadyStateProblem(prob)

# You can pass in an NLsolve function. Needs to be generalized a bit.
sol = solve(prob,SSRootfind(nlsolve = (f,u0) -> NLsolve.nlsolve(f,u0,autodiff=true,method=:newton,iterations=Int(1e6))))