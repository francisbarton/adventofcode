input_raw = readlines("2022/input/day_03");

lets::String = *(join(map(string, 'a':'z')), join(map(string, 'A':'Z')));

function find_common(x)
  l::Int = length(x) / 2
  p1::SubString = x[begin:l]
  p2::SubString = x[(l+1):end]
  m::String = match(Regex("[$(p1)]"), p2).match
  c::Char = convert(Char, m[1])
  match(Regex("$(c)"), lets).offset
end;


priorities = map(find_common, input_raw);
reduce(+, priorities)


part2_vec = input_raw;

function find_badge(vec)
  s = Iterators.take(vec, 3)
  s = collect(s)
  m = map(x -> map(x -> convert(Char, x[1]), split(x, "")), s)
  l = reduce(intersect, m)
  match(Regex("$(l)"), lets).offset
end;

function iterative_find(vec)
  out = []
  while length(vec) >= 3
    push!(out, find_badge(vec))
    vec = vec[4:end]
  end
  out
end;


out = iterative_find(part2_vec);
reduce(+, out)