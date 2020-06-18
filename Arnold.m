% %Written by Dr. Prashan Premaratne - University of Wollongong - 1 May 2006
% %num specifies the number of Iterations for the Arnold Transform
% function [newim] = Arnold(im,num)
%     [rown,coln]=size(im);
% %     figure(1)
%     for inc=1:num
%         for row=1:rown
%             for col=1:coln
%                 nrowp = row;
%                 ncolp=col;
%                 for ite=1:inc
%                     newcord =[1 1;1 2]*[nrowp ncolp]';
%                     nrowp=newcord(1);
%                     ncolp=newcord(2);
%                 end
%                 newim(row,col)=im((mod(nrowp,rown)+1),(mod(ncolp,coln)+1));
%             end
%         end
% 
%     end
% %     imshow(newim)
% end
% %out=iminverse;

% Arnold transform, v2, 2012-02-18
% Piotr Sklodowski, <piotr.sk@gmail.com>
%
% @in: two dimensional matrix
% @iter: number of iterations
%
function [ out ] = Arnold( in, iter )
%     figure(1);
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
                p = [ 1 1 ; 1 2 ] * [ x ; y ];
                out(mod(p(2), m)+1, mod(p(1), m)+1) = in(y+1, x+1);
            end
        end
        in = out;
    end
end
