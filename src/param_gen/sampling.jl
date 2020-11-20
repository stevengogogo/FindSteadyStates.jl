export Uniform, Log_uniform, rand_vec, rand_vecU, ParameterRandom   


@with_kw struct ParameterRandom <: ParameterGenerator
    methods # Array of sampling generator. method should be callable
    len  # Total number of simulation
end


"""
Set all the variables with same method with defined ranges
"""
function ParameterRandom(param_ranges, method::RandomSampler, len) 

    methods = map(x-> method(x), param_ranges)
   
    return ParameterRandom(methods=methods, len=len)
end

"""
Parameter Random sampling with `range`.
"""
function ParameterRandom(param_ranges::AbstractArray{T,1};method=Uniform()::RandomSampler, len=nothing) where T<:AbstractRange

    param_ranges_ = Array{Tuple{Number,Number},1}(undef,length(param_ranges)) # [(start,end),...]

    len_ = 1

    for (i, ran) in enumerate(param_ranges)
        par_rang = (ran[1], ran[end])
        len_ = len_ * length(ran)
        param_ranges_[i] = par_rang
    end

    len_ = isnothing(len) ? len_ : len # if user-defined len_

    return ParameterRandom(param_ranges_, method, len_)
end

"""
Reset one specified method
"""
function (par::ParameterRandom)(index::Integer, new_method::RandomSampler)
    methods = deepcopy(par.methods)
    methods[index] = new_method
    return ParamRandom(methods, par.len)
end

"""Length of random sampler"""
Base.length(self::ParameterRandom) = self.len 

Base.size(self::ParameterRandom) = (self.len,)


## Iterator 
"""Get the parameters that would be `ind` th in iteration

The total sample number is # to do 

Paremeters 
----------
- `ind` {int}: The iteration index

Returns
-------
- `params`: list of numbers in the range of `ParameterGrid.param_ranges`
"""
function Base.getindex(self::ParameterRandom, ind::Int)

    params = map(v-> v() ,self.methods )
    
    return params
end 

## Uniform
"""RandomSampler for uniform distribution"""
@with_kw struct Uniform <: RandomSampler
    a=0.::Number #lower bound
    b=1.::Number # higher bound
    type= Float64
    function Uniform(a,b, type)
        if a>b
            @warn "b(=$b) should greater than a(=$a). Change to Uniform(a=$b,b=$a)"
            new(b,a, type)
        else
            new(a,b, type)
        end
    end
end

function Uniform(a, b;type=Float64)
    return Uniform(a=a,b=b, type=type)
end

function (par::Uniform)() :: Number
    @unpack a, b, type = par
    num = rand() * (b - a) + a

    if type <: Integer
        samp = round(num) # convert to integer
    else
        samp =  num
    end

    return samp
end

function (par::Uniform)(len::Integer) :: Array
    @unpack a, b, type = par
    vec = rand(len)
    return vec .* (b - a) .+ a
end


"""Reset parameter range but fixed the rest."""
function (par::Uniform)(param_range)

    return Uniform(param_range[1], param_range[2], par.type)
end


## Log uniform
"""RandomSampler for log uniform distribution. a,b ∈ (0,∞)"""
@with_kw struct Log_uniform <: RandomSampler
    a = 1e-6:: Number # can not be zero
    b = 1. :: Number
    base = 10. :: Number 
    type = Float64
    function Log_uniform(a,b, base, type)
        @assert base > 0.
        @assert (a>0.) & (b > 0.)
        if a>b
            @warn "b(=$b) should greater than a(=$a). Change to Log_uniform(a=$b,b=$a)"
            new(b,a,base, type)
        else
            new(a,b,base, type)
        end
    end
end

function Log_uniform(a,b;base=10., type=Float64)
    return Log_uniform(a=a, b=b, base=base, type=type)
end

function (par::Log_uniform)() :: Number
    @unpack a, b, base, type = par
    a_pow, b_pow = log.(base, [a, b])
    _pow = Uniform(a_pow, b_pow, type)()

    num = base^_pow

    if type <: Integer
        samp = round(num) # convert to integer
    else
        samp =  num
    end
    
    return samp
    
end

"""Generate a vector with same range."""
function (par::Log_uniform)(len::Integer) :: Array
    samp = Log_uniform(a=par.a, b=par.b, base=par.base, type=par.type)
    return [samp() for i in 1:1:len]
end

"""Renew the range and keep the rest."""
function (par::Log_uniform)(param_range)
    return Log_uniform(param_range[1], param_range[2], par.base, par.type)
end

## Sampling from de meta
"""generate random vector with uniform distribution `rand()`"""
function rand_vec(len::Integer, method::RandomSampler) :: Array{Float64,1}
    return method(len)
end

"""Sampling a vector with a list of sampler

REPL
----
```julia
unis = [Uniform(1,2) for i in 1:10]
vec = rand_vec(unis)
```
"""
function rand_vec(samplers::AbstractArray{T,1}) :: Array{Float64,1} where T<:RandomSampler
    return [samp() for samp in samplers]
end

"""General method for sampling a vector with individual samplers"""
function rand_vec(samplers)
    return [samp() for samp in samplers]
end

"""Uniform sampling of vector"""
rand_vecU(len::Integer, domain::Domain) = Uniform(domain.low, domain.high)(len)

rand_vecU(demeta::DEmeta, domain::Domain) = rand_vecU(length(demeta.u0), domain)



function rand_vecU(domains::Array{Domain, 1})
    vec = zeros(length(domains))
    for i in eachindex(domains)
        vec[i] = Uniform(domains[i].low, domains[i].high)()
    end
    return vec
end

"""General method. domains can be list of tuples"""
function rand_vecU(domains)
    vec = zeros(length(domains))
    for i in eachindex(domains)
        vec[i] = Uniform(domains[i]...)()
    end
    return vec
end

## Grid search
