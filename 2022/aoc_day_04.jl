input_raw = readlines("2022/input/day_04");

function check_contains(x)
  l = split(x, ",")
  p = map(string, l)
  p1 = map(x -> parse(Int64, x), split(p[1], "-"))
  p2 = map(x -> parse(Int64, x), split(p[2], "-"))
  p1 = collect(p1[1]:p1[2])
  p2 = collect(p2[1]:p2[2])
  all(in.(p1, Ref(p2))) | all(in.(p2, Ref(p1)))
end;

out = map(check_contains, input_raw);
reduce(+, out)


function check_overlaps(x)
  l = split(x, ",")
  p = map(string, l)
  p1 = map(x -> parse(Int64, x), split(p[1], "-"))
  p2 = map(x -> parse(Int64, x), split(p[2], "-"))
  (p2[1] <= p1[1] <= p2[2]) | (p1[1] <= p2[1] <= p1[2])
end;

out2 = map(check_overlaps, input_raw);
reduce(+, out2)