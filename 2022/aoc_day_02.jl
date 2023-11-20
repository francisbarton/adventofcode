input_raw = readlines("2022/input/day_02");

function get_score(x)
  p1 = x[1]
  p2 = x[3]
  if p1 == 'A'
    if p2 == 'X' 4
    elseif p2 == 'Y' 8
    else 3
    end
  elseif p1 == 'B'
    if p2 == 'X' 1
    elseif p2 == 'Y' 5
    else 9
    end
  else 
    if p2 == 'X' 7
    elseif p2 == 'Y' 2
    else 6
    end
  end
end;

scores = map(get_score, input_raw);
reduce(+, scores)

function get_score2(x)
  p1 = x[1]
  p2 = x[3]
  if p1 == 'A'
    if p2 == 'X' 3
    elseif p2 == 'Y' 4
    else 8
    end
  elseif p1 == 'B'
    if p2 == 'X' 1
    elseif p2 == 'Y' 5
    else 9
    end
  else 
    if p2 == 'X' 2
    elseif p2 == 'Y' 6
    else 7
    end
  end
end;

scores = map(get_score2, input_raw);
reduce(+, scores)