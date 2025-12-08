function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end


function count_movable_crates(map::Matrix{Char}, remove=false, target='@')
    crates = findall(f->f == target, map)
    res = 0
    height = last(axes(map, 1))
    width = last(axes(map, 2))
    for crate ∈ crates
        adjecent = 0
        for Δy ∈ range(-1, 1)
            for Δx ∈ range(-1, 1)
                y = crate[1] + Δy
                x = crate[2] + Δx
                ((y == crate[1] && x == crate[2]) || y < 1 || y > height || x < 1 || x > width) && continue
                (map[y, x] == target) && (adjecent += 1)
            end
        end
        if(adjecent < 4)
            res += 1
            remove && (map[crate[1], crate[2]] = '.')
        end
    end
    return (res, map)
end

function part_one(map::Matrix{Char})
    (res, map) = count_movable_crates(map)
    @assert(res == 1537)    
    println("Part One: $res")
end

function part_two(map::Matrix{Char})
    res = 0
    while ((removed, map) = count_movable_crates(map, true))[1] > 0
        res += removed
    end
    @assert(res == 8707)
    println("Part Two: $res")
end

data = read_data("./Day04 - Printing Department/data.txt")

part_one(data)
part_two(data)
