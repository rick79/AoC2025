function read_data(path::String)
    return [CartesianIndex(reverse(parse.(Int64, split(line, ",")))...) for line ∈ eachline(path)]
end


function calculate_areas(corners::Vector{CartesianIndex{2}})
    return sort([Pair((corners[i], corners[ii]), (abs(corners[i][1] - corners[ii][1]) + 1) * (abs(corners[i][2] - corners[ii][2]) + 1)) for i ∈ range(1, length(corners)) for ii ∈ range(i + 1, length(corners))], by = f -> f[2])
end


function create_bounds(corners::Vector{CartesianIndex{2}})
    bounds = Vector{Tuple{CartesianIndex{2}, CartesianIndex{2}}}()
    push!(bounds, (corners[end], corners[1]))
    previous = corners[1]
    for corner ∈ corners[2:end]
        push!(bounds, (previous, corner))
        previous = corner
    end
    return bounds
end


function check(rect::Tuple{CartesianIndex{2}, CartesianIndex{2}}, bounds::Vector{Tuple{CartesianIndex{2}, CartesianIndex{2}}})
    for bound ∈ bounds
        if(bound[1][2] == bound[2][2])
            for y ∈ range(min(bound[1][1], bound[2][1]), max(bound[1][1], bound[2][1]))
                (y > min(rect[1][1], rect[2][1]) && y < max(rect[1][1], rect[2][1]) && bound[1][2] > min(rect[1][2], rect[2][2]) && bound[1][2] < max(rect[1][2], rect[2][2]) ) && return false
            end
        else
            for x ∈ range(min(bound[1][2], bound[2][2]), max(bound[1][2], bound[2][2]))
                (bound[1][1] > min(rect[1][1], rect[2][1]) && bound[1][1] < max(rect[1][1], rect[2][1]) && x > min(rect[1][2], rect[2][2]) && x < max(rect[1][2], rect[2][2])) && return false
            end
        end
    end
    return true
end


function part_one(data)
    areas = calculate_areas(data)
    res = areas[end][2]
    println("Part One: $res")
end


function part_two(corners)
    bounds = create_bounds(corners)
    areas = calculate_areas(data)
    res = 0
    for area ∈ areas
        (check(area[1], bounds) && area[2] > res) && (res = area[2])
    end
    @assert(res == 1476550548)
    println("Part Two: $res")
end


data = read_data("./Day09 - Movie Theater/data.txt")
using BenchmarkTools

# part_one(data)
@benchmark part_two(data)

