%% Round Spiral Layer
% X = round_layer_spiral(N,r0,d,phi0,RES,layers,h,x0,y0,z0,phix,phiy,phiz,view)
%
% This function generates a flat circular multilayer spiral - PCB Inductor
% geometry to be used as a coil. The coil will be generated with center
% in (0,0,0) in XY plane. It can be moved using the x0,..,phix... parameters
%
%% Parameters
% * @param 	*N*		Number of Turns
%
% * @param 	*r0*	External radius of the coil
%
% * @param 	*d*		Distane bewtween turns
%
% * @param 	*phi0*	Angle at which the turns start
%
% * @param 	*RES*	Number of  nodes of the Geometry (Discretization)
%
% * @param 	*layer*	Number of  layers of the Geometry 
%
% * @param 	*h*		Distance between layers of the Coil
%
% * @param 	*x0*	Center position X
%
% * @param 	*y0*	Center position Y
%
% * @param 	*z0*	Center position Z
%
% * @param 	*phix*	Turn respect X axis 
%
% * @param 	*phiy*	Turn respect Y axis
%
% * @param 	*phiz*	Turn respect Z axis
%
% * @param 	*view*	Optional parameter, if true generates figure with geometry
%
% * @retval	*X* 		Geometry nodes
%% Code	
function X = round_layer_spiral(N,r0,d,phi0,RES,layers,h,x0,y0,z0,phix,phiy,phiz,view)
	Rx=[1,0,0;0,cos(phix),-sin(phix);0,sin(phix),cos(phix)];
	Ry=[cos(phiy),0,sin(phiy);0,1,0;-sin(phiy),0,cos(phiy)];
	Rz=[cos(phiz),-sin(phiz),0;sin(phiz),cos(phiz),0;0,0,1];	
	X=[];
	for i=1:1:layers
		if mod(i,2)==1 %Assures the correct direction of the turns
			X=[X,round_spiral(N, r0, d, phi0, RES, 0, 0, -h*(i-1), 0, 0, 0, false)];
		else
			X=[X,fliplr(round_spiral(N, r0, d, phi0, RES, 0, 0, -h*(i-1), pi, 0, 0, false))];
		end
	end
	for i=1:size(X,2)
		X(:,i)=transpose(Rx*[X(1,i);X(2,i);X(3,i)]);		
		X(:,i)=transpose(Ry*[X(1,i);X(2,i);X(3,i)]);
		X(:,i)=transpose(Rz*[X(1,i);X(2,i);X(3,i)]);
		X(:,i)=X(:,i)+[x0;y0;z0];
	end
	if nargin>13
		if view
			plot3(X(1,:),X(2,:),X(3,:))
			grid on
			xlabel('X')
			ylabel('Y')
			zlabel('Z')
			title('Round Layer Spiral');
		end
	end
end
%% Geometry
% 
% <<..\..\doc\functions\res\round_layer.PNG>>
% 





