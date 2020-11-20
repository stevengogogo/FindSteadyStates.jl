export jacobian,  StabilityType


@with_kw struct jacobian 
    ode
    jac_func
    u
    p
    t
end

@with_kw struct StabilityType
    stable ::Bool 
    unstable ::Bool 
    saddle  ::Bool 
    damping ::Bool 
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

    return jacobian(ode=ode, jac_func=jac_func, u=u, p=p, t=t)
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


"""
Get jacobian from state variable with default paramter set
"""
function (self::jacobian)(u;t=nothing)
    return self(u, self.p; t=t)
end

"""
Get jacobian from default state.
"""
function (self::jacobian)()
    return self(self.u, self.p; t=self.t)
end



function StabilityType(jac_matrix)
    es = eigvals(jac_matrix)

    return StabilityType(
    stable = is_stable(es),
    unstable = is_unstable(es),
    saddle = is_saddle(es),
    damping = is_damping(es)
    )
end


"""
Stability identification
"""
function is_stable(es) :: Bool
    method(e) = real(e) >= 0. ? true : false 
    return judge_jac(es, method, true)
end

"""
Unstability identification
"""
function is_unstable(es) :: Bool
    method(e) = real(e) >= 0. ? true : false 
    return judge_jac(es, method, false)
end

"""
Damping identification
"""
function is_damping(es) :: Bool
   method(e) = imag(e) != 0. ? true : false 
   return judge_jac(es, method, false)
end

"""
Saddle point identification
"""
function is_saddle(es) :: Bool 
    real_es = real.(es)
    if (maximum(real_es) > 0. ) & (minimum(real_es) < 0.)
        saddle = true
    else 
        saddle = false
    end
    return saddle
end

"""
General method for judging jacobian 
"""
function judge_jac(es, eigval_method, default_bool)
    feature = default_bool
    for e in es
        if eigval_method(e) 
            feature = !feature
            break 
        end
    end
    return feature
end