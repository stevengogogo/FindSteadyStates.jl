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
de = DEsteady(func=(x) -> x,p=0,u0=ones(len),method=Tsit5())
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

v_2 = rand_vecU(domains)
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


@testset "Sampling with domains. Input:ODEmeta" begin
    err = 0
    for i in eachindex(v_2)
        num = v_2[i]
        d = domains[i]
        if !(num >= d.low)
            err += 1
        elseif !(num <= d.high)
            err += 1
        else
            continue
        end
    end
    @test err == 0
end

end

@testset "Sampling with samplers" begin

samplers = [Uniform(1,2) for i in 1:100]
vec = rand_vec(samplers)

@test length(vec) == length(samplers)

end

@testset "General method" begin
    len = 10
    general_samplers = [rand for i in 1:len]

    ## Sampling
    v1 = rand_vec(general_samplers)

    v2 = rand_vecU([[1,2], [1,2], [1,2]])

    @test len == length(v1)
end

@testset "Random generator" begin 

ParameterGrid([[1,2,3],[1,3,4]])
param_ranges = [[1.,10.],[1.,20.]]
sam = Uniform(0,1, Int)
sam2  = Uniform(0,10)
l = Log_uniform(0.12,13, 10.0,Int)
l2 = Log_uniform(0.12,1,100., Float64)

len = 10

gen1 = ParameterRandom([sam, sam2, l, l2], 100000)

gen2 = ParameterRandom(param_ranges, sam,  len)
gen3 = ParameterRandom(param_ranges, l, len )

@test length(gen2) == length(gen3)
@test gen2.methods[1] == sam(param_ranges[1])


# Plotting
p1= Plots.histogram([i[1] for i in gen1], title="Uniform Integer"); # Uniform(0,1, Int)
p2 =Plots.histogram([i[2] for i in gen1], title="Uniform"); # Uniform(0,10)
p3 = Plots.histogram([i[3] for i in gen1], title="Log Integer"); # Log_uniform(0.12,13, 10.0,Int)
p4 = Plots.histogram([i[4] for i in gen1], title="Log"); # Log_uniform(0.12,1,100., Float64)

Plots.plot(p1,p2,p3,p4)

end
