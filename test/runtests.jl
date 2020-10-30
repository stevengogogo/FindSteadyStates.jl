using FindSteadyStates
using Test
using Parameters
using DifferentialEquations
@testset "FindSteadyStates.jl" begin
    @test include("solveODE.jl")
end
