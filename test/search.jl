
@testset "Base Extension of Grid-search Struct" begin
    ranges = [[1.,2.,10], [3.,4.,10], [5.,6.,10]]
    param_ranges = ParameterGrid(ranges)

    @testset "Constuctor of ParameterGrid" begin
        @test param_ranges.len == sum(Integer,[i[end] for i in ranges])
        @test length(param_ranges.indexes) == param_ranges.len 
    end

    @testset "Length & size" begin
        #Base.length
        @test Base.length(param_ranges) == (sum(Integer,[i[end] for i in ranges]))
        #Base.size
        @test Base.size(param_ranges) == ((sum(Integer,[i[end] for i in ranges])),)
    end
end

