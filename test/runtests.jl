using FindSteadyStates
using Test
using Parameters
using DifferentialEquations
using BenchmarkTools

@testset "FindSteadyStates.jl" begin

    @testset "Solve ODE" begin
        include("solveODE.jl")
    end

    @testset "Multi-thread for steady states" begin
        include("multithread_SteadyStateProblem.jl")
    end

    @testset "Sampling vector" begin
        include("sampling_vector.jl")
    end

end
