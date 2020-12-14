function display_DCM(A,Node_labels,lay)
%Makes a figure of the supplied DCM A matrix
if isstruct(A)
    G=digraph(A.Ep.A);
else
    G=digraph(A);
end

neg_edge=[];
zero_edge=[];
for z=1:length(G.Edges.Weight)
    if G.Edges.Weight(z)<10^-4&&G.Edges.Weight(z)>-10^-4
        zero_edge=[zero_edge,z];
    end
end
G=rmedge(G,zero_edge);
for z=1:length(G.Edges.Weight)
    if G.Edges.Weight(z)<-10^-4
        neg_edge=[neg_edge,z];
    end
end

figure
if lay
    h=plot(G,'NodeLabel',Node_labels,'EdgeLabel',round(G.Edges.Weight,2),'LineWidth',1.5,'Layout','circle');
else
    h=plot(G,'NodeLabel',Node_labels,'EdgeLabel',round(G.Edges.Weight,2),'LineWidth',1.5,'Layout','layered');
end
highlight(h,'Edges',neg_edge,'EdgeColor','r','Linestyle','--')

end

