function A = mat2strcell(A,varargin)
%In order to generate an input format that conforms to ticklabels()

A = mat2cell(A,1,ones(1,length(A)));
if nargin > 1
    for n=1:length(A)
        A{n}=num2str(A{n},varargin{1});
    end
else
    for n=1:length(A)
        A{n}=num2str(A{n});
    end
end

end