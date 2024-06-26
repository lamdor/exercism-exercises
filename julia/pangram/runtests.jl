using Test

include("pangram.jl")

@testset verbose = true "Pangram" begin
    @testset "empty sentence" begin
        @test !ispangram("")
    end

    @testset "perfect lower case" begin
        @test ispangram("abcdefghijklmnopqrstuvwxyz")
    end

    @testset "pangram with only lower case" begin
        @test ispangram("the quick brown fox jumps over the lazy dog")
    end

    @testset "missing character 'x'" begin
        @test !ispangram("a quick movement of the enemy will jeopardize five gunboats")
    end

    @testset "another missing character 'x'" begin
        @test !ispangram("the quick brown fish jumps over the lazy dog")
    end

    @testset "missing character 'h'" begin
        @test !ispangram("five boxing wizards jump quickly at it")
    end

    @testset "pangram with underscores" begin
        @test ispangram("the_quick_brown_fox_jumps_over_the_lazy_dog")
    end

    @testset "pangram with numbers" begin
        @test ispangram("the 1 quick brown fox jumps over the 2 lazy dogs")
    end

    @testset "missing letters replaced by numbers" begin
        @test !ispangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")
    end

    @testset "pangram with mixed case and punctuation" begin
        @test ispangram("\"Five quacking Zephyrs jolt my wax bed.\"")
    end

    @testset "upper and lower case versions of the same character should not be counted separately" begin
        @test !ispangram("the quick brown fox jumped over the lazy FOX")
    end

    @testset "a-m and A-M are 26 different letters but not a pangram" begin
        @test !ispangram("abcdefghijklm ABCDEFGHIJKLM")
    end

    @testset "pangram with more than 26 letters (if case sensitive)" begin
        @test ispangram("the 1 quick brown fox jumps Over the 2 lazy dogs")
    end

    @testset "An Arabic pangram is not an English pangram" begin
        @test !ispangram("The scholar and poet Al Farāhīdi wrote this Arabic pangram: صِف خَلقَ خَودِ كَمِثلِ الشَمسِ إِذ بَزَغَت — يَحظى الضَجيعُ بِها نَجلاءَ مِعطارِ")
    end
end
