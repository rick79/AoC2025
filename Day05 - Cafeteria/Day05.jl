function read_data(path::String)
    data = split(read(path, String), "\n\n")
    return ([Tuple(parse.(Int, split(r, "-"))) for r ∈ eachsplit(data[1], "\n")], [parse(Int, x) for x ∈ split(data[2], "\n")])
end


function isfresh(ranges::Vector{Tuple{Int, Int}}, ingredient::Int)
    for r ∈ ranges
        (r[1] <= ingredient <= r[2]) && return true
    end
    return false
end


function count_ranges(ranges::Vector{Tuple{Int, Int}})
    for i1 ∈ 1:length(ranges)
        for i2 ∈ (i1+1):length(ranges)
            if( ranges[i1][2] >= ranges[i2][1] && ranges[i1][1] <= ranges[i2][2])
                ranges[i2] = (min(ranges[i1][1], ranges[i2][1]), max(ranges[i1][2], ranges[i2][2]))
                ranges[i1] = (0,0)
            end
        end
    end
    return sum([x[2]-x[1] + 1 for x ∈ ranges if x != (0,0)])
end


function part_one(data)
    res = sum([isfresh(data[1], i) for i ∈ data[2]])
    @assert(res == 661)
    println("Part One: $res")
end


function part_two(data)
    res = count_ranges(data[1])
    @assert(res == 359526404143208)
    println("Part Two: $res")
end


data = read_data("./Day05 - Cafeteria/data.txt")

part_one(data)
part_two(data)

