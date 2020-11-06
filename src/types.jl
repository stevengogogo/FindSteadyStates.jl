export Domain, ODEtime, DEsteady

abstract type DEmeta end

@kwdef struct ODEtime <: DEmeta
    func
    u0
    p
    tspan
end

@kwdef struct DEsteady <: DEmeta
    func
    p
    u0
    SteadyStateMethod
end


@kwdef struct Domain
    low::Number
    high::Number
end
