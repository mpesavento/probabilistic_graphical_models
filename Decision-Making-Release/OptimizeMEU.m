% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeMEU( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  
  % We assume I has a single decision node.
  % You may assume that there is a unique optimal decision.
  D = I.DecisionFactors(1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  % 
  % Some other information that might be useful for some implementations
  % (note that there are multiple ways to implement this):
  % 1.  It is probably easiest to think of two cases - D has parents and D 
  %     has no parents.
  % 2.  You may find the Matlab/Octave function setdiff useful.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
  MEU = 0;
  OptimalDecisionRule = I.DecisionFactors(1);
  Dzero = zeros(length(D.val), 1);


  euf = CalculateExpectedUtilityFactor(I);

  % for D with no parents
  if (length(D.var) == 1)
    eu = []
    for i=1:length(D.val)
      D.val = Dzero;
      D.val(i) = 1;
      eu = dot(euf.val, D.val);
    end
    [meu, ix] = max(eu);
    OptimalDecisionRule.val = Dzero;
    OptimalDecisionRule.val(ix) = 1;
  end

  % % iterate through possible decision rules
  % assignments = IndexToAssignment(1:length(D.val), D.card);
  % for i=1:size(assignments, 1)
  %   D.val = Dzero;
  %   D = SetValueOfAssignment(D, assignments(i, :), 1);
  %   D.val(assignments(i, :)) = 1;


  % end

  % [MEU, max_ix] = max(euf.val .* D.val);
  % OptimalDecisionRule.val(max_ix) = 1;

end
