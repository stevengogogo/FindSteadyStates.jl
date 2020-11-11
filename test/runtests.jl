using FindSteadyStates
using Test
using Parameters
using DifferentialEquations

@testset "FindSteadyStates.jl" begin

    @testset "Solve ODE" begin
        println("Solve ODE")
        @time include("solveODE.jl")
    end

    @testset "Multi-thread for steady states" begin
        println("Multi-thread for steady states")
        @time include("multithread_SteadyStateProblem.jl")
    end

    @testset "Sampling vector" begin
        println("Sampling vector")
        @time include("sampling_vector.jl")
    end

    @testset "Search functions" begin
        println("Search functions")
        @time include("search.jl")
    end

end
