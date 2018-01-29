function y = opcion(cat,ops,def)
  [a,b] = ismember(cat,ops);
  if a == 1
      y = eval(ops{b+1});
  else
      y = def;
  end
