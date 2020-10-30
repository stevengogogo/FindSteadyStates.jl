export domain, ODEfunc

using Parameters

@with_kw struct domain
    low::Number
    high::Number
end

@with_kw struct ODEfunc
    func
    p
    tspan = nothing
    SteadyStateMethod=nothing

end
