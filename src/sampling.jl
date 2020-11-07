export Uniform, Log_uniform, rand_vec, rand_vecU

## Type
abstract type Sampler end

## Uniform
"Sampler for uniform distribution"
@with_kw struct Uniform <: Sampler
    a::Number #lower bound
    b::Number # higher bound
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
    return rand() * (b - a) + a
end

function (par::Uniform)(len::Integer) :: Array
    @unpack a, b = par
    vec = rand(len)
    return vec .* (b - a) .+ a
end

## Log uniform
"Sampler for log uniform distribution. a,b ∈ (0,∞)"
@with_kw struct Log_uniform <: Sampler
    a :: Number
    b :: Number
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



## Sampling from de meta
"generate random vector with uniform distribution `rand()`"
function rand_vec(len::Integer, method::Sampler) :: Array{Float64,1}
    return method(len)
end

"Sampling a vector with a list of sampler

# REPL
```julia
unis = [Uniform(1,2) for i in 1:10]
vec = rand_vec(unis)
```
"
function rand_vec(samplers::AbstractArray{T,1}) :: Array{Float64,1} where T<:Sampler 
    return [samp() for samp in samplers]
end

"Uniform sampling of vector"
rand_vecU(len::Integer, domain::Domain) = Uniform(domain.low, domain.high)(len)

rand_vecU(demeta::DEmeta, domain::Domain) = rand_vecU(length(demeta.u0), domain)

rand_vecU(demeta::DEmeta, domains::Array{Domain, 1}) = rand_vecU(length(demeta.u0), domains)

function rand_vecU(len::Integer, domains::Array{Domain, 1})
    vec = zeros(len)
    for i in eachindex(vec)
        vec[i] = Uniform(domains[i].low, domains[i].high)()
    end
    return vec
end
