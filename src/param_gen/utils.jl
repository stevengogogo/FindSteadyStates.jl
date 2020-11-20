"""
Convert AbstractRange to list of tuples (start, end, grid)
"""
function ranges2tuples(param_ranges)
    param_ranges_ = Array{Tuple{Number,Number,Integer},1}(undef,length(param_ranges))
    for (i, ran) in enumerate(param_ranges)
        par_rang = (ran[1], ran[end], length(ran))
        param_ranges_[i] = par_rang
    end
    return param_ranges_
end