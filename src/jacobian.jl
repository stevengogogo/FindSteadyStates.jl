export jacobian


@with_kw struct jacobian 
    ode
    jac_func
end

function jacobian(ode, u, p; t=nothing)
    prob = ODEProblem(ode, u, t, p)
    de =  ModelingToolkit.modelingtoolkitize(prob)
    jac_func =  eval(ModelingToolkit.generate_jacobian(de)[2])

    return jacobian(ode=ode, jac_func=jac_func)
end

function (self::jacobian)(u,p;t=nothing)
    l = length(u)
    j = zeros(l,l)
    self.jac_func(j, u, p, t)
    return j
end