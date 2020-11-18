using FindSteadyStates
using Test
using Parameters
using DifferentialEquations
using LabelledArrays
using Random
using Plots

@testset "FindSteadyStates.jl" begin

    @testset "Solve ODE" begin
        @info "Solve ODE"
        @time include("solveODE.jl")
    end

    @testset "Multi-thread for steady states" begin
        @info "Multi-thread for steady states"
        @time include("multithread_SteadyStateProblem.jl")
    end

    @testset "Sampling vector" begin
        @info "Sampling vector"
        @time include("sampling_vector.jl")
    end

    @testset "Search functions" begin
        @info "Search functions"
        @time include("search.jl")
    end

    @testset "Solve with grid search" begin
        @info "Solve with grid search"
        @time include("solve_with_grid_search.jl")        
    end 
end



