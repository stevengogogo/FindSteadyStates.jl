using FindSteadyStates
using Test
using Parameters
using DifferentialEquations

@testset "FindSteadyStates.jl" begin
    @testset "Solve ODE" begin
        include("solveODE.jl")
    end

    @testset "Multi-thread for steady states" begin
        include("multithread_SteadyStateProblem.jl")
    end
end
