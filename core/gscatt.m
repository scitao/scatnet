function [S, U] = gscatt(in, propagators)
% function [S, U] = gscatt(in, propagators)
% this function implements a generic scattering
% where propagators may be different from one layer to the next.
%
% intput :
% - in : <NxM double> input image
% - propagators : <1x1 struct> containing fields :
%   - U : <1xm cell> of <function_handle> to apply successively
%   - A : <1x(m+1) cell> of <function_handle> to apply after U
%
% output :
% - S
%
% NOTE : 
% propagators can be obtained with a variety of propagators_builder such as :
%   propagators_builder_2d.m			
%   propagators_builder_2d_plus_scale.m		
%   propagators_builder_3d.m			
%   propagators_builder_3d_plus_scale.m
%
% WARNING :
% this 'core' scattering function does not contain any 
% pre/post-processing and reformating.
% consider the use of wrappers in /scattlab2d/wrappers/ like
%   scatt_2d_wrapper
%   scatt_3d_wrapper
%   scatt_3d_ms_wrapper.m
%
% EXAMPLE :
% to compute the 2d scattering use the following two line:
%   propagators = propagators_builder_2d(size(in),options);
%   out = gscatt(in,propagators);

U{1} = in;

for m = 1:numel(propagators.U)
  % inside node : wavelet modulus operators
  U{m+1} = propagators.U{m}(U{m});
end

for m = 1:numel(propagators.A)
  % outside node : averaging
  S{m}  = propagators.A{m}(U{m});
end



end