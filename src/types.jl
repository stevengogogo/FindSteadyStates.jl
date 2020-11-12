export Domain, ODEtime, DEsteady

abstract type DEmeta end

"""
Struct for solveing time-series of differential-equations. The data type of ode function is referenced to DifferentialEquations.jl.

Argument
--------
- `func`: ODE function. 
- `u0`: initial values
- `p`: parameters
- `tspan`: time span 

References
1. [DifferentialEquations.jl](https://diffeq.sciml.ai/stable/tutorials/ode_example/)
"""
@with_kw struct ODEtime <: DEmeta
    func
    u0
    p
    tspan
end

"""
Struct for solving steady state of an differential equation model.

Argument
--------
- `func`: ODE function. 
- `u0`: initial values
- `p`: parameters
- `SteadyStateMethod`: Method for solving steady-states. (i.e. `DifferentialEqiations.Tsit5()`, `DifferentialEquations.AutoTsit5(Rosenbrock23())`) 

Reference
---------
1. [ODE solvers of DifferentialEquations.jl](https://diffeq.sciml.ai/stable/solvers/split_ode_solve/)
"""
@with_kw struct DEsteady <: DEmeta
    func
    p
    u0
    SteadyStateMethod
end


@kwdef struct Domain
    low::Number
    high::Number
    function Domain(low, high)
        if low > high
            @warn("Domain.low should <= Domain.high. Reset to Domain($low, $high)")
            new(high, low)
        else
            new(low, high)
        end
    end
end