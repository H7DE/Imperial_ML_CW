%
% Implements fa measure as described in the specification document in
% section 4.f
%
%                   precision_rate * recall_rate
% fa = (1 + a) * ----------------------------------
%                (a * precision_rate) + recall_rate
%
function fa = f_alpha_measure(alpha, precision_rate, recall_rate)

    fa = (1 + alpha) * ( ...
            (precision_rate * recall_rate) / ...
            ( ( alpha * precision_rate ) + recall_rate ) ...
          );

end