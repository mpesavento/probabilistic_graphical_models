% Copyright (C) Daphne Koller, Stanford University, 2012

function EUF = CalculateExpectedUtilityFactor( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: A factor over the scope of the decision rule D from I that
  % gives the conditional utility given each assignment for D.var
  %
  % Note - We assume I has a single decision node and utility node.
  EUF = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  %CalculateExpectedUtilityFactor, for one utility function it's 
  %actually very short, you first figure out which variables to 
  %eliminate (bulk of my code, like 5 lines), and then call VariableElimination
  D = I.DecisionFactors;
  U = I.UtilityFactors;

  F = [I.RandomFactors I.UtilityFactors];
  all_random_vars = unique(horzcat(F(:).var));
  eliminate_vars = setdiff(all_random_vars, D.var);
  EUF = VariableElimination(F, eliminate_vars);

end
