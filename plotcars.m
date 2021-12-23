function plotcars

global nc onroad x y hcars ii gcf writerObj ;

if (nc>0 && sum(onroad)>0)
    set(hcars,'xdata',x(find(onroad)),'ydata',y(find(onroad)));
    drawnow
    Framevideo(ii) = getframe(gcf);
    writeVideo(writerObj,Framevideo(ii));
    pause(.001)
    shg

end
end
