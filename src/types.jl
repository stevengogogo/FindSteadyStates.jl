export Domain, ODEtime, DEsteady, solveSS


"""
    DEmeta

Meta inofmration of differential equation. The family of ['DEmeta'](@ref) 
"""
abstract type DEmeta end

"""
    ODEtime(func, u0, p, tspan)

Struct for solveing time-series of differential-equations. The data type of ode function is referenced to DifferentialEquations.jl.

Argument
--------
- `func`: ODE function. 
- `u0`: initial values
- `p`: parameters
- `tspan`: time span 

References
----------

1. [DifferentialEquations.jl](https://diffeq.sciml.ai/stable/tutorials/ode_example/)


Reset method
------------

Reset a field of `ODEtime` struct with broadcast method. 

Usage
-----
When using the `LabelledArray.jl` to define function and subtypes of `DEmeta`. Use this method to update the values of named arrays without changing the type of the field. 

Purpose
-------
This feature is to solve the LabelledArray problem. when using the field vector to define function, the initial values or parameters need to be Named vectors. However, the grid search iterator returns vector which gets error when apply with the funtion of name vector. 

!!! compat ModelingToolkit
    When using ['jacobian'](@ref), should not use `LabelledArray` or name tuples for model function.

Arguement
---------
- `u0`: should be vector or types that can be broadcast. The length of `u0` should be same as `ODEtime.u0`
- `key`: field name of the stuct (default: `:u0`). 

Example
-------
```julia-repl
julia> using LabelledArrays, DifferentialEqiations
julia> u = LVector(s1=1.0,s2=0.2)
2-element LArray{Float64,1,Array{Float64,1},(:s1, :s2)}:
 :s1 => 1.0
 :s2 => 0.2

julia> de = ODEtime(func=x->x, u0=u, p=1.0, tspan=(0.0,1.0))
ODEtime
  func: #9 (function of type var"#9#10")
  u0: LArray{Float64,1,Array{Float64,1},(:s1, :s2)}
  p: Float64 1.0
  tspan: Tuple{Float64,Float64}
  method: CompositeAlgorithm{Tuple{Tsit5,Rosenbrock23{0,true,DefaultLinSolve,DataType}},AutoSwitch{Tsit5,Rosenbrock23{0,true,DefaultLinSolve,DataType},Rational{Int64},Int64}}

julia> de_new = de([1.3,1.4];key=:u0)
ODEtime
  func: #9 (function of type var"#9#10")
  u0: LArray{Float64,1,Array{Float64,1},(:s1, :s2)}
  p: Float64 1.0
  tspan: Tuple{Float64,Float64}
  method: CompositeAlgorithm{Tuple{Tsit5,Rosenbrock23{0,true,DefaultLinSolve,DataType}},AutoSwitch{Tsit5,Rosenbrock23{0,true,DefaultLinSolve,DataType},Rational{Int64},Int64}}

julia> de_new.u0 # The updated u0 is the struct of LArray
2-element LArray{Float64,1,Array{Float64,1},(:s1, :s2)}:
 :s1 => 1.3
 :s2 => 1.4

julia> de.u0
2-element LArray{Float64,1,Array{Float64,1},(:s1, :s2)}:
 :s1 => 1.0
 :s2 => 0.2
```
"""
@with_kw struct ODEtime <: DEmeta
    func 
    u0
    p
    tspan
    method= AutoTsit5(Rosenbrock23()) # For autonomaous detecion for stiff and non-stiff problem
end


function (self::ODEtime)(u0; key=:u0)
    return update_struct_broadcast(self, u0, key)
end


"""
    DEsteady(func, p u0, method)
    (self::DEsteady)(u0; key=:u0)

- Struct for solving steady state of an differential equation model.

- Update steady state meta, and return another DEsteady object.

Argument
--------
- `func`: ODE function. 
- `u0`: initial values
- `p`: parameters
- `method`: Method for solving steady-states. (i.e. `DifferentialEqiations.Tsit5()`, `DifferentialEquations.AutoTsit5(Rosenbrock23())`) 


Reference
---------
1. [ODE solvers of DifferentialEquations.jl](https://diffeq.sciml.ai/stable/solvers/split_ode_solve/)


Example
-------


```julia-repl
julia> using LabelledArrays, DifferentialEqiations
julia> deS = DEsteady(func=x->x, u0= LVector(s1=1.0,s2=2.0), p=1.0)
DEsteady
  func: #17 (function of type var"#17#18")
  p: Float64 1.0
  u0: LArray{Float64,1,Array{Float64,1},(:s1, :s2)}
  method: Tsit5 Tsit5()

julia> deS_new = deS([1000.0,200.0];key=:u0)
DEsteady
  func: #17 (function of type var"#17#18")
  p: Float64 1.0
  u0: LArray{Float64,1,Array{Float64,1},(:s1, :s2)}
  method: Tsit5 Tsit5()

julia> deS_new.u0
2-element LArray{Float64,1,Array{Float64,1},(:s1, :s2)}:
 :s1 => 1000.0
 :s2 => 200.0
```
"""
@with_kw struct DEsteady <: DEmeta
    func 
    p
    u0
    method = SSRootfind()
end

function (self::DEsteady)(u0; key=:u0)
    return update_struct_broadcast(self, u0, key)
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


"""
    update_struct_broadcast(var_struc, vals, key)

Update a field of struct varibale by broadcasting.
    
Argument
--------
-  `var_struc`: A struct variable. 
- `vals`: A `Vector` which has the same length with `Base.getfield(var_struc, key)` for update the new struct variable.
- `key` : A `Symbol` which can apply `Base.getfield(var_struc, key)`

Return
------
- Struct variable similar to `var_struc` but with renew `vals` on `key` site.
"""
function update_struct_broadcast(var_struc, vals, key)
    vals_ = deepcopy(getfield(var_struc, key)) # derive the structure of `var_struc.key`
    vals_ .= vals #broadcast method 
    struc = typeof(var_struc) # type of the struct variable

    fnames = map(fieldnames(struc)) do n
        if n == key 
            v = vals_
        else
            v = getfield(var_struc, n)
        end

        return v
    end
    return typeof(var_struc)(fnames...) # use type of `var_struc` to create new struct variable
end