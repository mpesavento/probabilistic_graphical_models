function output = run_test


load_data

% test part 1
output = ComputeSingletonFactors(Part1SampleImagesInput, imageModel);
for i=1:length(Part1SampleImagesInput)
    assert(output(i).var == Part1SampleFactorsOutput(i).var);
    assert(output(i).card == Part1SampleFactorsOutput(i).card);

    u = output(i).val;
    v = Part1SampleFactorsOutput(i).val;
    e=0.001;
    is_appx_equal = u<=v+e & u>=v-e;
    assert(sum(is_appx_equal) == length(u));

end


