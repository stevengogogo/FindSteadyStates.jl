export Uniform, Log_uniform, rand_vec, rand_vecU


@with_kw struct ParameterRandom <: ParameterGenerator
    param_ranges # [(start,end),...]
    len  # Total number of simulation
    methods 
end

function (par::ParameterRandom)(param_ranges, len, dist::RandomSampler)
    methods = Array{RandomSampler}(undef, length(param_ranges))
    for i in eachindex(methods)
        param_range = param_ranges[i]
        methods[i] = dist(param_range[1], param_range[2])
    end
end

function (par::ParameterRandom)(index, dist::RandomSampler)
    methods = deepcopy(par.methods)
    methods[index] = dist
    return ParamRandom(par.param_ranges, par.len, methods)
end


## Uniform
"RandomSampler for uniform distribution"
@with_kw struct Uniform <: RandomSampler
    a=0.::Number #lower bound
    b=1.::Number # higher bound
    type= Float64
    function Uniform(a,b)
        if a>b
            @warn "b(=$b) should greater than a(=$a). Change to Uniform(a=$b,b=$a)"
            new(b,a)
        else
            new(a,b)
        end
    end
end


function (par::Uniform)() :: Number
    @unpack a, b = par
    num = rand() * (b - a) + a
    return convert(par.type, num)
end

function (par::Uniform)(len::Integer) :: Array
    @unpack a, b = par
    vec = rand(len)
    return vec .* (b - a) .+ a
end



function (par::Uniform)(param_range)
    return Uniform(param_range...)
end


## Log uniform
"RandomSampler for log uniform distribution. a,b ∈ (0,∞)"
@with_kw struct Log_uniform <: RandomSampler
    a = 0.:: Number
    b = 1.:: Number
    base :: Number = 10.
    function Log_uniform(a,b, base)
        @assert base > 0.
        @assert (a>0.) & (b > 0.)
        if a>b
            @warn "b(=$b) should greater than a(=$a). Change to Log_uniform(a=$b,b=$a)"
            new(b,a,base)
        else
            new(a,b,base)
        end
    end
end

function (par::Log_uniform)() :: Number
    @unpack a, b, base = par
    a_pow, b_pow = log.(base, [a, b])
    _pow = Uniform(a_pow, b_pow)()
    return base^_pow
end

function (par::Log_uniform)(len::Integer) :: Array
    @unpack a, b, base = par
    a_pow, b_pow = log.(base, [a, b])
    _pow = Uniform(a_pow,b_pow)(len)
    return base.^_pow
end

function (par::Log_uniform)(param_range)
    return Log_uniform(param_range[1], param_range[2], par.base)
end

## Sampling from de meta
"generate random vector with uniform distribution `rand()`"
function rand_vec(len::Integer, method::RandomSampler) :: Array{Float64,1}
    return method(len)
end

"Sampling a vector with a list of sampler

# REPL
```julia
unis = [Uniform(1,2) for i in 1:10]
vec = rand_vec(unis)
```
"
function rand_vec(samplers::AbstractArray{T,1}) :: Array{Float64,1} where T<:RandomSampler
    return [samp() for samp in samplers]
end

"General method for sampling a vector with individual samplers"
function rand_vec(samplers)
    return [samp() for samp in samplers]
end

"Uniform sampling of vector"
rand_vecU(len::Integer, domain::Domain) = Uniform(domain.low, domain.high)(len)

rand_vecU(demeta::DEmeta, domain::Domain) = rand_vecU(length(demeta.u0), domain)



function rand_vecU(domains::Array{Domain, 1})
    vec = zeros(length(domains))
    for i in eachindex(domains)
        vec[i] = Uniform(domains[i].low, domains[i].high)()
    end
    return vec
end

"General method. domains can be list of tuples"
function rand_vecU(domains)
    vec = zeros(length(domains))
    for i in eachindex(domains)
        vec[i] = Uniform(domains[i]...)()
    end
    return vec
end

## Grid search
