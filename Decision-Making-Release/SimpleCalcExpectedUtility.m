% Copyright (C) Daphne Koller, Stanford University, 2012

function EU = SimpleCalcExpectedUtility(I)

  % Inputs: An influence diagram, I (as described in the writeup).
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return Value: the expected utility of I
  % Given a fully instantiated influence diagram with a single utility node and decision node,
  % calculate and return the expected utility.  Note - assumes that the decision rule for the 
  % decision node is fully assigned.

  % In this function, we assume there is only one utility node.
  F = [I.RandomFactors I.DecisionFactors];
  D = I.DecisionFactors;
  U = I.UtilityFactors(1);
  EU = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % find the factor variables to remove
  all_random_vars = []
  for i=1:length(F)
    all_random_vars = union(all_random_vars, F(i).var);
  end
  all_random_vars;

  eliminate_vars = setdiff(all_random_vars, U.var);
  networkFactors = VariableElimination(F, eliminate_vars);
  if length(networkFactors) > 1
    N = FactorProduct(networkFactors(1), networkFactors(2));
  else
    N = networkFactors(1);
  end

  % make sure the variables are aligned
  assignmentsN = IndexToAssignment(1:length(N.val), N.card);
  assignmentsU = IndexToAssignment(1:length(U.val), U.card);
  indxN = AssignmentToIndex(assignmentsN, N.card);
  indxU = AssignmentToIndex(assignmentsU, U.card);

  % get the sum of the product, aka dot product
  EU = dot(N.val(indxN), U.val(indxU));

  % products = networkFactors.val(indxN) .* U.val(indxU)
  % EU = sum(products)

  % if length(networkFactors) > 1
  %   p = FactorProduct(networkFactors(1), networkFactors(2));
  % else
  %   p = networkFactors(1)
  % end
  % q = FactorProduct(p, I.DecisionFactors)

  % eliminate_vars = setdiff(all_random_vars, U.var);
  % parentFactors = VariableElimination(F, eliminate_vars);
  % if length(parentFactors) > 1
  %   p = FactorProduct(parentFactors(1), parentFactors(2));
  % else
  %   p = parentFactors(1)
  % end

  % do an assign by index to get the ordering correct here.
  % use index to assignment? need to reorder variables first
  % use assigment to index?
  % assignmentsP = IndexToAssignment(1:length(p.val), p.card)
  % assignmentsU = IndexToAssignment(1:length(U.val), U.card)
  % products = q.val .* U.val
  % EU = sum(products)

end
