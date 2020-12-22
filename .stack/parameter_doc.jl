
"""
StabilityType 

Store the information about stability.
""" 
@with_kw struct   StabilityType
    stable ::Bool 
    unstable ::Bool 
    saddle  ::Bool 
    damping ::Bool 
end

"""
A representation of a chill number
"""
@with_kw  struct MyStruct
  "The absolute value"
  a::Float64 = 1.0
  "The cool number"
  cool::Int = 2
end

"""
effeef
"""
@with_kw mutable struct MT
    " break things now "
    r::Int=5
    a
end

