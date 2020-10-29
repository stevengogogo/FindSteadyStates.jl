module Sampling

export universal

function uniform(a::Number, b::Number)::Number
    return rand() * (b-a) + a
end

function log_uniform(a::Number, b::Number; base= ℯ)::Number
    a_pow, b_pow = log.(base, [a, b])

    _pow = uniform(a_pow, b_pow)

    return base ^ _pow

end


end
