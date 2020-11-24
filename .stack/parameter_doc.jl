@with_kw struct """
    StabilityType 

Store the information about stability.
"""  StabilityType
    stable ::Bool 
    unstable ::Bool 
    saddle  ::Bool 
    damping ::Bool 
end


@with_kw """
A representation of a chill number
""" MyStruct
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