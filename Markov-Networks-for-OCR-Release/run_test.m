function run_test


load_data

% test part 1
% output = ComputeSingletonFactors(Part1SampleImagesInput, imageModel);
% for i=1:length(Part1SampleImagesInput)
%     assert(output(i).var == Part1SampleFactorsOutput(i).var);
%     assert(output(i).card == Part1SampleFactorsOutput(i).card);

%     u = output(i).val;
%     v = Part1SampleFactorsOutput(i).val;
%     e=0.0001;
%     is_appx_equal = u<=v+e & u>=v-e;
%     assert(sum(is_appx_equal) == length(u));

% end


% Confirm the network can be created for a single word
% This is the first test of the inference engine, if it passes
imageModel.ignoreSimilarity = true;

singletonFactors = BuildOCRNetwork(allWords{1}, imageModel, [], []);

%% part 2
% run the equal pairwise model(s)
% comment out the appropriate line in BuildOCRNetwork (line 53/54 switch) for equal and pairwise
imageModel.ignoreSimilarity = true;
% [charAcc, wordAcc] = ScoreModel(allWords, imageModel, [], []);

% test part 2
output = ComputePairwiseFactors(Part2SampleImagesInput, pairwiseModel, imageModel.K)
% for i=1:length(Part2SampleImagesInput(1))
%     assert(output(i).var == Part2SampleFactorsOutput(i).var);
%     assert(output(i).card == Part2SampleFactorsOutput(i).card);

%     u = output(i).val;
%     v = Part2SampleFactorsOutput(i).val;
%     e=0.0001;
%     is_appx_equal = u<=v+e & u>=v-e;
%     assert(sum(is_appx_equal) == length(u));

% end

predictions = ComputeWordPredictions(allWords, imageModel, pairwiseModel, []);
% [charAcc, wordAcc] = ScoreModel(allWords, imageModel, pairwiseModel, []);

%% part 3





