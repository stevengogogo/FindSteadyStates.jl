
using DifferentialEquations
using ModelingToolkit

function rober(du, u, p, t)
    y1, y2, y3 = u
    k1, k2, k3 = p

    du[1] = -k1*y1 + k3*y2*y3 
    du[2] = k1*y1 - k2*y2^2. - k3*y2*y3 
    du[3] = k2*y2^2.

end 


prob = ODEProblem(rober,[1.0,0.0,0.0],(0.0,1e2),(0.04,3e2,1e4))
de = modelingtoolkitize(prob)

jac = eval(ModelingToolkit.generate_jacobian(de)[2])

jac(zeros(3,3),[0.0184367966813563, 7.51141018910664e-8, 0.9815631282045398],(0.04,0.,0.), (0.0,1e5) )


function jacobian(u, p, jac)
    len = length(u)
    j = zeros(len, len)
    jac(j, u, p, nothing)
    return j
end

jacobian([0.,1.,2.], [0.33,0.3,0.1], jac)