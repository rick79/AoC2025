function read_data(path::String)
    data = split(read(path, String), "\n\n")
    shapes = Dict{Int64, Matrix}()
    for raw ∈ data[1:end-1]
        shape = split(raw, "\n")
        lines = shape[2:end]
        shapes[parse(Int64, shape[1][1:end-1])] = [lines[y][x] == '#' for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
    end
    regions = [([x for x ∈ parse.(Int64, match(r"(\d*)x(\d*)", line))], [parse(Int64, x[1]) for x ∈ eachmatch(r" ([0-9]+)", line)]) for line ∈ eachsplit(data[end], "\n")]
    return (shapes, regions)
end



function part_one(data)
    res = 0
    shapes = data[1]
    regions = data[2]
    swidth = last(axes(shapes[1], 2))
    sheight = last(axes(shapes[1], 1))
    for region ∈ regions
        width = region[1][1]
        height = region[1][2]
        s = sum(region[2])
        cap = (width ÷ swidth) * (height ÷ sheight)
        (cap >= s) && (res += 1)
    end
    println("Part One: $res")
end

data = read_data("./Day12 - Christmas Tree Farm/data.txt")

part_one(data)

