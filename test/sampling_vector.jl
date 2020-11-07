@testset "1D array sampling" begin

d = FindSteadyStates.Domain(low=3.0, high=4.0)
length_of_vector = 1000

vec = rand_vecU(length_of_vector, d)
vec2 = rand_vec(length_of_vector, Uniform(d.low, d.high))

@test length(vec) == length_of_vector
@test minimum(vec) >= d.low
@test maximum(vec) <= d.high

@test length(vec2) == length_of_vector
@test minimum(vec2) >= d.low
@test maximum(vec2) <= d.high

end

@testset "sampling in uniform and log_uniform" begin

mean(vec) = sum(vec) / length(vec)

## Parameters

down, up = 1.,100.
len = 1000
# de struct
de = DEsteady(func=(x) -> x,p=0,u0=ones(len),SteadyStateMethod=Tsit5())
domain = Domain(down, up)

domains = fill!(Array{Domain}(undef, len), Domain(down,up))
## Sampling

# Create sampler functor
uni_samp = Uniform(a=down, b=up)
log_samp = Log_uniform(a=down, b=up, base=10.)

# Sampling single value
n1 = uni_samp()
n2 = log_samp()

# Sampling a vector
v1 = uni_samp(len)
v2 = log_samp(len)

# sampling with domains
v_ = rand_vecU(length(domains), domains)
v_2 = rand_vecU(de, domains)
# Sampling a vector
println("Sampling a vector")
@time v3_1 = rand_vec(len, uni_samp)
@time v3_2 = rand_vec(len, log_samp)

# test uniform sampler with Demeta struct
@time v4 = rand_vecU(de, domain)

## Test
# v1 v2
@test mean(v1) >= mean(v2)

# v3
@test mean(v3_1) >= mean(v3_2)

@test mean(v1) >= mean(v2)
# v4
@test length(v4) == len
@test (maximum(v4) <= domain.high) & (minimum(v4) >= domain.low)

# v_
@testset "sampling with domains. Input:length" for i in eachindex(v_)
    num = v_[i]
    d = domains[i]
    @test num >= d.low
    @test num <= d.high
end

@testset "Sampling with domains. Input:ODEmeta" for i in eachindex(v_2)
    num = v_[i]
    d = domains[i]
    @test num >= d.low
    @test num <= d.high
end

end


@testset "Sampling with samplers" begin

samplers = [Uniform(1,2) for i in 1:100]
vec = rand_vec(samplers)

@test length(vec) == length(samplers)

end
