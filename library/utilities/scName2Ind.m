function ind = scName2Ind(sc_names,name)

ind = find(strcmp(sc_names,name));
if isempty(ind)
    error('Invalid spacecraft name');
end

end

