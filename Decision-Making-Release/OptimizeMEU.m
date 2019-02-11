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

  % see https://github.com/anhncs/Probabilistic-Graphical-Models/blob/master/6.Decision%20Making
  EUF = CalculateExpectedUtilityFactor(I);
  MEU = 0;
  D.val = D.val*0;
  ca=D.card(1);
  len = length(D.val)/ca;
  for i = 1:len
    start = i*ca-ca+1;
    endd = i*ca;
    [eu, ix] = max(EUF.val(start:endd));
    MEU += eu;
    D.val(start+ix-1) = 1;
  end
  OptimalDecisionRule = D;



  %%% my attempt
  % euf = CalculateExpectedUtilityFactor(I);
  % % for D with no parents
  % if(length(D.var) == 1)
  %   [_, ix] = max(euf.val)
  %   OptimalDecisionRule.val(ix) = 1;
  % else
  %   for i=1:length(D.var)
  %     map(i) = find(EUF.var == D.var(i));
  %     invMap(i) = find(D.var == EUF.var(i));
  %   end
  %   assignEUF = IndexToAssignment(1:length(EUF.val), EUF.card);
  %   assignD = assignEUF(:, map);
  %   PAs = AssignmentToIndex(1:prod(D.card(2:end)), D.card(2:end));
  %   for i=1:size(PAs,1)
  %       newAssigns = [[1:D.card(1)]', repmat(PAs(i,:), length([1:D.card(1)]),1)];
  %       ids = AssignmentToIndex(newAssigns(:,invMap), EUF.card);
  %       [_, id] = max(EUF.val(ids));
  %       OptimalDecisionRule.val(ids(id)) = 1;
  %   end
  % end
  % F = FactorProduct(OptimalDecisionRule, euf)


  % % iterate through possible decision rules
  % assignments = IndexToAssignment(1:length(D.val), D.card);
  % for i=1:size(assignments, 1)
  %   D.val = D.val * 0;
  %   D = SetValueOfAssignment(D, assignments(i, :), 1);
  %   D.val(assignments(i, :)) = 1;
  % end
  % [MEU, max_ix] = max(euf.val .* D.val);
  % OptimalDecisionRule.val(max_ix) = 1;

end
