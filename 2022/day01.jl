input_raw = readlines("2022/input/day_01");

function conv_int(x)
  if x == "" missing
  else parse(Int64,x)
  end
end;

input_vec = map(x -> conv_int(x), input_raw);
breaks = findall(ismissing, input_vec);
input_vec = map(x -> if ismissing(x) 0 else x end, input_vec);

function pull_diff(x, vec1, vec2)
  total1 = sum(vec2[1:vec1[x]])
  if x > 1
    total2 = sum(vec2[1:vec1[x-1]])
  elseif x == 1
    total2 = 0
  end
  total1 - total2
end;

calories_list = map(x -> pull_diff(x, breaks, input_vec), range(1, length(breaks)));
maximum(calories_list)
reduce(max, calories_list)