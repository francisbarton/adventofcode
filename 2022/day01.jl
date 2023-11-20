input_raw = readlines("2022/input/day_01");

breaks = findall(x -> x == "", input_raw);
input_vec = map(x -> if x == "" 0 else parse(Int64, x) end, input_raw);

x = Iterators.take(breaks, length(breaks) - 1);
y = Iterators.drop(breaks, 1);

z = zip(x, y);

function pull_diff(x)
  sum(input_vec[1:x[2]]) - sum(input_vec[1:x[1]])
end;

calories_list = map(pull_diff, z);
maximum(collect(calories_list))
