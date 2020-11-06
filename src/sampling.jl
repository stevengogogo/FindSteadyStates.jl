export uniform, log_uniform, rand_vec

function uniform(a::Number, b::Number)::Number
    return rand() * (b - a) + a
end

function log_uniform(a::Number, b::Number; base = ℯ)::Number
    a_pow, b_pow = log.(base, [a, b])
    _pow = uniform(a_pow, b_pow)
    return base^_pow
end

"generate random vector with uniform distribution `rand()`"
function rand_vec(len::Integer, low_bound, high_bound) :: Array{Float64,1}
    vec = rand(len) .* (high_bound-low_bound) .+ low_bound
    return vec
end

function rand_vec(len::Integer, domain::Domain)
    vec = rand_vec(len, Domain.low, Domain.high)
end

function rand_vec(demeta::DEmeta)
    vec = rand_vec()
end
