
@testset "Base Extension of Grid-search Struct" begin
    ranges = [[1.,2.,10], [3.,4.,10], [5.,6.,10]]
    param_ranges = ParameterGrid(ranges)

    @testset "Constuctor of ParameterGrid" begin
        @test param_ranges.len == FindSteadyStates.mul(Integer,[i[end] for i in ranges])
        @test length(param_ranges.indexes) == param_ranges.len 
    end

    @testset "Length & size" begin
        #Base.length
        @test Base.length(param_ranges) == (FindSteadyStates.mul(Integer,[i[end] for i in ranges]))
        #Base.size
        @test Base.size(param_ranges) == ((FindSteadyStates.mul(Integer,[i[end] for i in ranges])),)
    end
end

@testset "Recursive index" begin 

    ranges = [ (1,4,4), (2,8,4), (1,2,2) ]
    ind_max = FindSteadyStates.mul([i[end] for i in ranges])

    # first index vector
    vec_one = [1 for i in ranges]
    # last index vector 
    vec_end = [i[end] for i in ranges]

    param_ranges = ParameterGrid(ranges)

    @test vec_one == recursive_index(param_ranges, 1)
    @test vec_end == recursive_index(param_ranges, ind_max) 
    @test [4,1,1] == recursive_index(param_ranges, 4)
    @test [1,2,1] == recursive_index(param_ranges, 5)

end

## Indexing 
@testset "get index for parameter generation" begin
    # Ranges 
    ranges = [ (1.,4.,4), (2.,8.,4), (1.,2.,2) ]
    total_is = FindSteadyStates.mul([i[end] for i in ranges])

    # Grid search samplers 
    para1 = ParameterGrid(ranges; grid_dist=UniformGrid())
    para2 = ParameterGrid(ranges; grid_dist=LogGrid(decay=10.))
    

    # number of index should equal to total grids.
    @test length(para1) == total_is
    @test length(para2) == total_is

    # Sampling: para 1
    println("Sample the range: $ranges")
    println("Print grid vecs: uniform distributed")
    for i in 1:1:length(para1)
        println(para1[i])
    end

    # Sampling Para 2
    println("Print grid vecs: log distributed")
    for i in 1:1:length(para2)
        println(para2[i])
    end
    println("DONE")
end
