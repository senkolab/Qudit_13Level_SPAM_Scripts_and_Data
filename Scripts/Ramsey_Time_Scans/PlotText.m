function texthandle = PlotText(x_pos,y_pos,string)

Ax = axis;
texthandle = text((x_pos/100)*(Ax(2) - Ax(1)) + Ax(1),(y_pos/100)*(Ax(4) - Ax(3)) + Ax(3),...
    string,'Interpreter','latex','fontsize',18);