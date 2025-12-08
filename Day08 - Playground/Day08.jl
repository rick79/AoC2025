function read_data(path::String)
    return [CartesianIndex(parse.(Int64, split(line, ","))...) for line ∈ eachline(path)]
end

function calculate_distances(nodes::Vector{CartesianIndex{3}})
    return sort([Pair((nodes[i], nodes[ii]), sum(Tuple(nodes[ii]-nodes[i]) .^ 2)) for i ∈ range(1, length(nodes)) for ii ∈ range(i + 1, length(nodes))], by=f->f[2])
end


function part_one(boxes::Vector{CartesianIndex{3}})
    distances = calculate_distances(data)
    circuits = [Set([b]) for b ∈ boxes]
    for closest ∈ distances[1:1000]
        c1 = findfirst(f->closest[1][1] ∈ f, circuits)
        c2 = findfirst(f->closest[1][2] ∈ f, circuits)
        (c1 == c2) && continue
        union!(circuits[c1], circuits[c2])
        deleteat!(circuits, c2)
    end
    res = prod([length(x) for x ∈ sort(circuits, rev=true, by=f->length(f))[1:3]])
    @assert(res == 163548)
    println("Part One: $res")
end

function part_two(boxes::Vector{CartesianIndex{3}})
    distances = calculate_distances(data)
    circuits = [Set([b]) for b ∈ boxes]
    res = 0
    for closest ∈ distances
        c1 = findfirst(f->closest[1][1] ∈ f, circuits)
        c2 = findfirst(f->closest[1][2] ∈ f, circuits)
        (c1 == c2) && continue
        union!(circuits[c1], circuits[c2])
        deleteat!(circuits, c2)
        if(length(circuits) == 1)
            res = closest[1][1][1]*closest[1][2][1]
            break
        end
    end
    @assert(res == 772452514)
    println("Part Two: $res")
end


data = read_data("./Day08 - Playground/data.txt")

part_one(data)
part_two(data)