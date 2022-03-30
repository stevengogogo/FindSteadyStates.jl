export jacobian, StabilityType


@with_kw struct jacobian
    ode
    jac_func
    u
    p
    t
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
    de = ModelingToolkit.modelingtoolkitize(prob)

    jac_func = ModelingToolkit.generate_jacobian(de, expression=Val{false})[2]
    return jacobian(ode=ode, jac_func=jac_func, u=u, p=p, t=t)
end

"""Use DEmeta for jacobian generation"""
function jacobian(de::T; t=nothing) where {T<:DEmeta}
    return jacobian(de.func, de.u0, de.p; t=t)
end

"""
Calculate the jacobian of given initial valuables and parameters.
"""
function (self::jacobian)(u, p; t=nothing)
    l = length(u)
    j = zeros(l, l)
    self.jac_func(j, u, p, t)
    return j
end


"""
Get jacobian from state variable with default parameter set
"""
function (self::jacobian)(u; t=nothing)
    return self(u, self.p; t=t)
end

"""
Get jacobian from the default state.
"""
function (self::jacobian)()
    return self(self.u, self.p; t=self.t)
end

"""
    StabilityType 

Store the information about stability.
"""
struct StabilityType
    stable::Bool
    unstable::Bool
    saddle::Bool
    damping::Bool

    function StabilityType(jac_matrix)
        es = eigvals(jac_matrix)
        realpart = real.(es)
        imagpart = imag.(es)
        is_stable = all(realpart .< zero(realpart))
        is_unstable = all(realpart .> zero(realpart))
        is_damping = all(imagpart .≈ zero(imagpart))
        is_saddle = !(is_stable || is_unstable)

        new(is_stable, is_unstable, is_saddle, is_damping)
    end
end