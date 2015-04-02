classdef axisAngleSections < ODFSections
  
  properties
    angles
    axesSectors    
    S2G
  end
  
  methods
    
    function oS = axisAngleSections(CS1,CS2,varargin)
      
      oS = oS@ODFSections(CS1,CS2);
      
      % get sections
      if check_option(varargin,{'omega','angles'})
        oS.angles = get_option(varargin,{'omega','angles'});
      else
        oS.angles = (5:10:180)*degree;
        oS.angles(oS.angles>maxAngle(oS.CS1,oS.CS2)) = [];
      end
      
    end
    
    
    function [sec] = project(oS)
    
    end
    
    function makeGrid(oS)
      S2G = plotS2Grid(oM.CS1.Laue.fundamentalSector('angle',omega(i)),varargin{:});
  
      mori = orientation('axis',S2G,'angle',omega(i));
      
      rgb = oM.orientation2color(mori);
    end
    
    function plot(oS,varargin)

      mtexFig = newMtexFigure(varargin{:});

      sR = oS.CS1.Laue.fundamentalSector;

      for i = 1:length(oS.angle)
  
        if i>1, mtexFig.nextAxis; end
        
        % plot boundary
        plot(sR,'parent',mtexFig.gca,'TR',[int2str(oS.angle(i)./degree),'^\circ'],...
          'color',[0.8 0.8 0.8],'doNotDraw');
        
        % rescale the figures according to actual volume
        x = get(mtexFig.gca,'xLim');
        y = get(mtexFig.gca,'yLim');
        x = x .* sin(oM.CS1.maxAngle/2) / sin(omega(i)/2);
        y = y .* sin(oM.CS1.maxAngle/2) / sin(omega(i)/2);
        xlim(mtexFig.gca,x);
        ylim(mtexFig.gca,y);
    
        hold on
        plot(oS.grid.S2G{i},data(),'parent',mtexFig.gca,varargin{:},'doNotDraw');
        hold off
      end      
    end        
  end
end