function phenotypeFactor = constructSigmoidPhenotypeFactor(alleleWeights, geneCopyVarOneList, geneCopyVarTwoList, phenotypeVar)
% This function takes a cell array of alleles' weights and constructs a 
% factor expressing a sigmoid CPD.
%
% You can assume that there are only 2 genes involved in the CPD.
%
% In the factor, for each gene, each allele assignment maps to the allele
% whose weight is at the corresponding location.  For example, for gene 1,
% allele assignment 1 maps to the allele whose weight is at
% alleleWeights{1}(1) (same as w_1^1), allele assignment 2 maps to the
% allele whose weight is at alleleWeights{1}(2) (same as w_2^1),....  
% 
% You may assume that there are 2 possible phenotypes.
% For the phenotypes, assignment 1 maps to having the physical trait, and
% assignment 2 maps to not having the physical trait.
%
% THE VARIABLE TO THE LEFT OF THE CONDITIONING BAR MUST BE THE FIRST
% VARIABLE IN THE .var FIELD FOR GRADING PURPOSES
%
% Input:
%   alleleWeights: Cell array of weights, where each entry is an 1 x n 
%   of weights for the alleles for a gene (n is the number of alleles for
%   the gene)
%   geneCopyVarOneList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the first parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor)
%   geneCopyVarTwoList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the second parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor) -- Note that both copies of each gene are from the same person,
%   but each copy originally came from a different parent
%   phenotypeVar: Variable number corresponding to the variable for the 
%   phenotype (goes in the .var part of the factor)
%
% Output:
%   phenotypeFactor: Factor in which the values are the probabilities of 
%   having each phenotype for each allele combination (note that this is 
%   the FULL CPD with no evidence observed)

phenotypeFactor = struct('var', [], 'card', [], 'val', []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INSERT YOUR CODE HERE
% Note that computeSigmoid.m will be useful for this function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% Fill in phenotypeFactor.var.  This should be a 1-D row vector.
% Fill in phenotypeFactor.card.  This should be a 1-D row vector.
phenotypeFactor.var = [phenotypeVar, geneCopyVarOneList', geneCopyVarTwoList'];
phenotypeFactor.card = ones(1, 5) * 2;

phenotypeFactor.val = zeros(1, prod(phenotypeFactor.card));
% Replace the zeros in phentoypeFactor.val with the correct values.

assignments = IndexToAssignment(1:length(phenotypeFactor.val), phenotypeFactor.card);
% assignments = assignments - 1;  % reset to zero index
phenotypeZero = assignments(find(assignments(:, 1)==1), 2:end);

n_alleles = length(alleleWeights{1});
n_genes = length(geneCopyVarOneList);

for pheno=1:size(phenotypeZero, 1)
    a = phenotypeZero(pheno, :);

    z = 0;
    for j=1:n_genes
        for i=1:n_alleles
            z = z + alleleWeights{j}(i) * sum(a(j:n_genes:end)==i);
        end
    end

    % z = sum(a(1:n_genes:end)) * alleleWeights{1}(1) + ...
    %     sum(a(2:n_genes:end)) * alleleWeights{1}(2) + ...
    %     sum(a(2:n_genes:end)) * alleleWeights{2}(1) + ...
    %     sum(a(1:n_genes:end)) * alleleWeights{2}(2)
    z2 = computeSigmoid(z);

    phenotypeFactor.val(pheno*n_genes - 1) = z2;
    phenotypeFactor.val(pheno*n_genes) = 1 - z2;

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%