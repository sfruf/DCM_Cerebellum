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
G=rmedge(G,zero_edge); %remove zero edges
for z=1:length(G.Edges.Weight)
    if G.Edges.Weight(z)<-10^-4
        neg_edge=[neg_edge,z];
    end
end
f=figure;
if lay
    h=plot(G,'NodeLabel',Node_labels,'EdgeLabel',round(G.Edges.Weight,2),'LineWidth',5*abs(round(G.Edges.Weight,2)),'Layout','auto','EdgeColor','r','ArrowSize',12);

else
    h=plot(G,'NodeLabel',Node_labels,'EdgeLabel',round(G.Edges.Weight,2),'LineWidth',1.5,'Layout','circle','EdgeColor','r','ArrowSize',12);
end
highlight(h,'Edges',neg_edge,'EdgeColor','b','Linestyle','--') %color negative edges
f.WindowState='maximized'; %this makes later printing work better
end

