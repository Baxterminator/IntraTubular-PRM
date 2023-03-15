ax = show_sparse(map);

for i=1:nb_node
    plot_robot(qSet(i,:)',L,ax);
end
plot_robot(start',L,ax,"b");
plot_robot(goal',L,ax,"k");
