export Domain, ODEtime, DEsteady, solveSS

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
    func :: Function 
    u0
    p
    tspan
    method= AutoTsit5(Rosenbrock23())
end

function (self::ODEtime)(u0; key=:u0)
    u_ = deepcopy(getfield(self, key))
    u_ .= u0 
    
    fnames = map(fieldnames(ODEtime)) do n
        if n == key
            val=  u0 
        else 
            val = getfield(self, n)
        end
        return val
    end

    return ODEtime(fnames...)
end


"""
Struct for solving steady state of an differential equation model.

Argument
--------
- `func`: ODE function. 
- `u0`: initial values
- `p`: parameters
- `method`: Method for solving steady-states. (i.e. `DifferentialEqiations.Tsit5()`, `DifferentialEquations.AutoTsit5(Rosenbrock23())`) 

Reference
---------
1. [ODE solvers of DifferentialEquations.jl](https://diffeq.sciml.ai/stable/solvers/split_ode_solve/)
"""
@with_kw struct DEsteady <: DEmeta
    func  :: Function
    p
    u0
    method = Tsit5()
end

"""
Update steady state meta, and return another DEsteady object
"""
function (self::DEsteady)(u0)
    u_ = deepcopy(self.u0)
    u_ .= u0 
    return DEsteady(func= self.func, p=self.p, u0=u_, method=self.method)
end



@with_kw struct Domain
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