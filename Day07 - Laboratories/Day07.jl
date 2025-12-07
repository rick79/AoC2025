function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end


data = read_data("./Day07 - Laboratories/data.txt")


function traversetm(start::CartesianIndex, map::Matrix{Char}, splitter = '^')
    res = 0
    beams = Set{Int64}()
    push!(beams, start[2])
    for y ∈ range(start[1] + 1, last(axes(map, 1)))
        newbeams = Set{Int64}()
        for beam ∈ beams
            if(map[y, beam] == splitter)
                push!(newbeams, beam-1)
                push!(newbeams, beam+1)
                res += 1
            else
                push!(newbeams, beam)
            end
        end
        beams = newbeams
    end
    return res
end


function traverseqtm(pos::CartesianIndex, map::Matrix{Char}, splitter = '^')
    cache = Dict{CartesianIndex, Int}()
    function traverseqtm_inner(pos::CartesianIndex, map::Matrix{Char})
        haskey(cache, pos) && return cache[pos]
        pos[1] == last(axes(map, 1)) && return 1
        if(map[pos[1] + 1, pos[2]] == splitter)
            r = traverseqtm_inner(pos + CartesianIndex(1, -1), map) + traverseqtm_inner(pos + CartesianIndex(1, 1), map)
            cache[pos] = r
            return r
        end
        return traverseqtm_inner(pos + CartesianIndex(1, 0), map)
    end
    return traverseqtm_inner(pos, map)
end


function part_one(map::Matrix{Char})
    start = findfirst(f -> f == 'S', map)
    res = traversetm(start, map)
    @assert(res == 1675)
    println("Part One: $res")
end


function part_two(map::Matrix{Char})
    start = findfirst(f -> f == 'S', map)
    res = traverseqtm(start, map)
    @assert(res == 187987920774390)
    println("Part Two: $res")
end


part_one(data)
part_two(data)