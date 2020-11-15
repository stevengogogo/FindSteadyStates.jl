"""



"""

using DifferentialEquations
using Plots 
using ModelingToolkit
## Build model
function rober(du, u, p, t)
    y1, y2, y3 = u
    k1, k2, k3 = p

    du[1] = -k1*y1 + k3*y2*y3 
    du[2] = k1*y1 - k2*y2^2. - k3*y2*y3 
    du[3] = k2*y2^2.

end 




## Solve without jacobian
prob = ODEProblem(rober,[1.0,0.0,0.0],(0.0,1e5),(0.04,3e7,1e4))
sol = solve(prob)




## Plotting
plot(sol,tspan=(1e-2,1e5),xscale=:log10)