function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.
% param_grad.b = zeros(size(param.b));
% param_grad.w = zeros(size(param.w));
dl_dh = output.diff;
dl_dw = input.data * dl_dh';
dl_db = sum(dl_dh, 2)';
param_grad.w = dl_dw;
param_grad.b = dl_db;
input_od = param.w * dl_dh;
end