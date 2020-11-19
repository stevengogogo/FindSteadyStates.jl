export jacobian


@with_kw struct jacobian 
    ode
    jac_func
end

"""
Construct the jacobian struct type

Argument
--------
- `ode` {ODE function}: with the form `f(du,u,p,t)`
- `u` {Array}: initial values
- `p` {Array}: parameters

Return 
------
- `Jacobian` {struct}

Warning
-------
NameTuple definition of `ode` function is unrecommended. Due to the incompatibility with `ModelingToolkit.modelingtoolkitize`
"""
function jacobian(ode, u, p; t=nothing)
    prob = ODEProblem(ode, u, t, p)
    de =  ModelingToolkit.modelingtoolkitize(prob)
    jac_func =  eval(ModelingToolkit.generate_jacobian(de)[2])

    return jacobian(ode=ode, jac_func=jac_func)
end

"""Use DEmeta for jacobian generation"""
function jacobian(de::T; t= nothing) where T<:DEmeta
    return jacobian(de.func, de.u0, de.p; t=t)
end

"""
Calculate the jacobian of given initial valuables and parameters.
"""
function (self::jacobian)(u,p;t=nothing)
    l = length(u)
    j = zeros(l,l)
    self.jac_func(j, u, p, t)
    return j
end

