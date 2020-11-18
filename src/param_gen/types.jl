abstract type Sampler end 

abstract type RandomSampler <: Sampler end 
abstract type GridSampler <: Sampler end 

abstract type ParameterGenerator <: AbstractVector{Any} end 
