function analyze_rubix_period_results

load('results.mat','results')

%%

results.('Edge Only Flag') = false(height(results),1);
results.('Moves per Sequence') = NaN(height(results),1);
results.('Moves per Cycle') = NaN(height(results),1);
results.('Cycle Complete Flag') = false(height(results),1);
results.('Trivial Case Flag') = false(height(results),1);
results.('Duplicate Case Flag') = false(height(results),1);
results.('Include') = true(height(results),1);

h = waitbar(0,'analyzing');
numR = height(results);
for ir = 1:numR
    
    waitbar(ir/numR,h)
    
    move = split(results.('Move Sequence')(ir),', ');
    
    mt = regexp(move,'([h,v,d])(\d+)(c{1,2}w)','tokens');
    mt = vertcat(mt{:});
    mt = vertcat(mt{:});
    
    move = cell2table(mt,'VariableNames',{'hvd','idx','rtn'});
    move.idx = str2double(move.idx);
    
    results.('Moves per Sequence')(ir) = height(move);
    
    % deal with move reversal pairs (not possible unless more than 2 moves
    % in the sequence because these were eliminated before sims were run)
    
    % this algorithm needs more help
    if results.('Moves per Sequence')(ir) > 2
        while true
            diffcheck = diff(cellfun(@double,move.hvd)) == 0;
            if any(diffcheck)
                checkidx = find(diffcheck,1,'first');
                if move.idx(checkidx) == move.idx(checkidx+1)
                    if ~strcmp(move.rtn(checkidx),move.rtn(checkidx+1))
                        move(checkidx:checkidx+1,:) = [];
                        mt(checkidx:checkidx+1,:) = [];
                        
                        if ismember(join(join(mt,'')',', '),results.('Move Sequence'))
                            results.('Duplicate Case Flag')(ir) = true;
                        end
                    end
                end
            else
                break
            end
        end
    end
    
    if results.('Duplicate Case Flag')(ir)
        continue
    end
    
    results.('Moves per Sequence')(ir) = height(move);
    if results.('Moves per Sequence')(ir) <= 1
        results.('Trivial Case Flag')(ir) = true;
        continue
    end
    
    if isequal(mt{:,1})
        results.('Trivial Case Flag')(ir) = true;
        continue
    end
    
    if results.('Error'){ir}(end) == 0
        results.('Cycle Complete Flag')(ir) = true;
        results.('Moves per Cycle')(ir) = numel(results.('Error'){ir});
    end
    
    if results.('Moves per Cycle')(ir) <= 2
        results.('Trivial Case Flag')(ir) = true;
    end
    
    if all(move.idx == 1 | move.idx == results.('Rubix Size')(ir))
        results.('Edge Only Flag')(ir) = true;
    end
    
end
delete(h)

results.('Include') = ~results.('Trivial Case Flag') & results.('Cycle Complete Flag') & ~results.('Duplicate Case Flag');
resultsInclude = results(results.('Include'),:);
resultsExclude = results(~results.('Include'),:);
clearvars -except resultsInclude resultsExclude

%%

killithere

%%
figure;
histogram(resultsInclude.('Moves per Cycle'),100)

%%
figure;
scatter(resultsInclude.('Rubix Size'),resultsInclude.('Moves per Cycle'))

%%
[~,sI] = sort(resultsInclude.('Moves per Cycle'));
resultsInclude = resultsInclude(sI,:);


end
