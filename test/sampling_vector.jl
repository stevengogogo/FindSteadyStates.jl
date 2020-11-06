@testset "1D array sampling" begin

d = FindSteadyStates.Domain(low=3.0, high=4.0)
length_of_vector = 1000

vec = rand_vec(length_of_vector, d.low, d.high)

@test length(vec) == length_of_vector
@test minimum(vec) >= d.low
@test maximum(vec) <= d.high

end
