function dollars = ValuePerfectInformation(TestI0, text_index)
    % we want to find the value of having the information of 
    % the test T influencing the decision D, versus if it has no influence
    % on the decision.
    %
    % To do this, we run one of the estimators and find the 
    % maximum expected utility over a network without the T->D edge,
    % and with the T->D edge
    % VPI = MEU[I_T->D] - MEU[I]
    %
    % the test random variable==11

    [base_MEU, optdr] = OptimizeWithJointUtility(TestI0);

    F = TestI0.RandomFactors;
    % find the test variable (11)
    ix = 0;
    for i=1:length(F)
        if(F(i).var(1) == 11)
            ix = i;
        end
    end

    % set the sensitivity P(t2|x2) and specificity P(t1|x1)
    switch(text_index)
    case 1
        % test1
        TestI0.RandomFactors(ix).val = [0.75, 0.25, 0.001, 0.999];
    case 2
        % test2
        TestI0.RandomFactors(ix).val = [0.999, 0.001, 0.25, 0.75];
    case 3
        % test3
        TestI0.RandomFactors(ix).val = [0.999, 0.001, 0.001, 0.999];
    end

    % make decision dependent on the test var
    D = TestI0.DecisionFactors;
    D.var = [D.var, 11];
    D.card = [D.card, 2];
    D.val = [1 0 0 1];
    TestI0.DecisionFactors = D;

    [MEU, optdr] = OptimizeWithJointUtility(TestI0);

    VPI = MEU - base_MEU;

    % utility of money scaling, from utility = 100 * log(d+1)
    dollars = exp(VPI / 100) - 1;

end