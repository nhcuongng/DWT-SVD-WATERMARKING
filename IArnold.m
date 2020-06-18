% function [iminverse] = IArnold (im, num)
% %     figure(2)
%     [irown,icoln]=size(im);
%     for inc=1:num
%         for irow=1:irown
%             for icol=1:icoln
% 
%             inrowp = irow;
%             incolp=icol;
%             for ite=1:inc
%                 inewcord =[2 -1;-1 1]*[inrowp incolp]';
%                 inrowp=inewcord(1);
%                 incolp=inewcord(2);
%             end
%             iminverse(irow,icol)=im((mod(inrowp,irown)+1),(mod(incolp,icoln)+1));
%             end
%         end
% %     imshow(iminverse)
%     end
% % end

% Inverse Arnold transform, v2, 2012-02-18
% Piotr Sklodowski, <piotr.sk@gmail.com>
%
% @in: two dimensional matrix
% @iter: number of iterations
%
function [ out ] = IArnold( in, iter )
    if (ndims(in) ~= 2)
        error('Oly two dimensions allowed');
    end
    [m n] = size(in);
    if (m ~= n)
        error(['Arnold Transform is defined only for squares. ' ...
        'Please complete empty rows or columns to make the square.']);
    end
    out = zeros(m);
    n = n - 1;
    for j=1:iter
        for y=0:n
            for x=0:n
                p = [ 2 -1 ; -1 1 ] * [ x ; y ];
                out(mod(p(2), m)+1, mod(p(1), m)+1) = in(y+1, x+1);
            end
        end
        in = out;
    end
end