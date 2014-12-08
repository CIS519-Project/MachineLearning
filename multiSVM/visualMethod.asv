%% Method 1
% % Ball_idx = find( Labels ~= 5 );
% Ball_Scores=scores(:,1:4);
% [topScores, SortIdx] = sort( Ball_Scores(:), 'descend');
% % BallNum = length( Ball_idx );
% % topIdx = SortIdx( 1: K );
% % [M, N] = ind2sub( size(Ball_Scores), topIdx);
% % neighbour_threshold = 10;
% ratio=topScores(2:end)./topScores(1:end-1);
% ratioThres = 0.01;
% K = 1;
% while ratio(K) < ratioThres
%     K = K + 1;
% end
% topIdx = SortIdx( 1: K );
% [M, N] = ind2sub( size(Ball_Scores), topIdx);
% % maxScore = max( max( Ball_Scores) );
% % scoreThreshold = 0.1 * maxScore;
% % [M, N] = find( Ball_Scores > scoreThreshold);
% % K = length ( M );



% for i = 1:K
%     switch N(i)
%         case 1 
%             rectangle('position', RECT(M(i),:), 'EdgeColor', 'b', 'LineWidth', 1.5);
%             text(RECT(M(i),1)+2,RECT(M(i),2)+5,'Bowling','color', 'b')
%         case 2
%             rectangle('position', RECT(M(i),:), 'EdgeColor', 'g', 'LineWidth', 1.5);
%             text(RECT(M(i),1)+2,RECT(M(i),2)+5,'Golf','color', 'g')
%         case 3
%             rectangle('position', RECT(M(i),:), 'EdgeColor', 'r', 'LineWidth', 1.5);
%             text(RECT(M(i),1)+2,RECT(M(i),2)+5,'Soccer','color', 'r')
%         case 4
%             rectangle('position', RECT(M(i),:), 'EdgeColor', 'c', 'LineWidth', 1.5);
%             text(RECT(M(i),1)+2,RECT(M(i),2)+5,'Tennis','color', 'c')
%     end
% end


%%  Method 2
% overlap_thres = 0.5;
% Near = cell(1,4);
% display = [];
% K = zeros(1,4);
% Ballidx = cell(1,4);
% Scores = cell(1,4);
% Scores_Sort = cell(1,4);
% sortIdx = cell(1,4);
% 
% for t = 1:4
%     % Bowling: 1     Golf: 2     Soccer: 3    Tennis: 4
%     Ballidx{t} = find( Labels == t );
%     Scores{t}=scores(Ballidx{t},t);
%     [Scores_Sort{t}, sortIdx{t}] = sort( Scores{t}, 'descend');
% 
%     %overlap elimination
%     while K(t) < length(sortIdx{t})
%         K(t) = K(t) + 1;
%         Ia = Ballidx{t}(sortIdx{t}(K(t)));
%         A = RECT(Ia, :);
%         Aarea = A(3) * A(4);
%         near = 0;
%         remove_id = [];
%         for i = (K(t)+1) : length(sortIdx{t})
%             Ib = Ballidx{t}(sortIdx{t}(i));
%             B = RECT(Ib,:);
%             Barea = B(3) * B(4);
%             overlap = rectint(A,B) / max(Aarea,Barea);
%             if overlap > overlap_thres
%                 near = near +1;
%                 remove_id = [ remove_id; i];
%             end
%         end
%         Near{t} = [Near{t}; near];
%         sortIdx{t}(remove_id)= [];
%         Scores_Sort{t}(remove_id)= [];
%         display = [display; Ia, t, near];
%     end
% end
% 
% 
% NearThres = 0.5 * max(display(:,3));
% 
% for i = 1:size(display,1)
%     if display(i,3) > NearThres
%         switch display(i,2)
%             case 1 
%                 rectangle('position', RECT(display(i,1),:), 'EdgeColor', 'b', 'LineWidth', 1.5);
%                 text(RECT(display(i,1),1)+2,RECT(display(i,1),2)+5,'Bowling','color', 'b')
%             case 2
%                 rectangle('position', RECT(display(i,1),:), 'EdgeColor', 'g', 'LineWidth', 1.5);
%                 text(RECT(display(i,1),1)+2,RECT(display(i,1),2)+5,'Golf','color', 'g')
%             case 3
%                 rectangle('position', RECT(display(i,1),:), 'EdgeColor', 'r', 'LineWidth', 1.5);
%                 text(RECT(display(i,1),1)+2,RECT(display(i,1),2)+5,'Soccer','color', 'r')
%             case 4
%                 rectangle('position', RECT(display(i,1),:), 'EdgeColor', 'c', 'LineWidth', 1.5);
%                 text(RECT(display(i,1),1)+2,RECT(display(i,1),2)+5,'Tennis','color', 'c')
%         end
%     end
% end

% Method 3
overlap_thres = 0.7;
Near = cell(1,4);
display = [];
K = zeros(1,4);
Ballidx = cell(1,4);
Scores = cell(1,4);
Scores_Sort = cell(1,4);
sortIdx = cell(1,4);
max_p = zeros(1,4);

for t = 1:4
    % Bowling: 1     Golf: 2     Soccer: 3    Tennis: 4
    Ballidx{t} = find( Labels == t );
    Scores{t}=scores(Ballidx{t},t);
    [Scores_Sort{t}, sortIdx{t}] = sort( Scores{t}, 'descend');
    max_p(t) = max(Scores_Sort{t});
end

[~,t] = max(max_p);

%overlap elimination
while K(t) < length(sortIdx{t})
    K(t) = K(t) + 1;
    Ia = Ballidx{t}(sortIdx{t}(K(t)));
    A = RECT(Ia, :);
    Aarea = A(3) * A(4);
    near = 0;
    remove_id = [];
    for i = (K(t)+1) : length(sortIdx{t})
        Ib = Ballidx{t}(sortIdx{t}(i));
        B = RECT(Ib,:);
        Barea = B(3) * B(4);
        overlap = rectint(A,B) / min(Aarea,Barea);
        if overlap > overlap_thres
            near = near +1;
            remove_id = [ remove_id; i];
        end
    end
    Near{t} = [Near{t}; near];
    sortIdx{t}(remove_id)= [];
    Scores_Sort{t}(remove_id)= [];
    display = [display; Ia, t, near];
end



NearThres = max(display(:,3))/2;

for i = 1:size(display,1)
    if display(i,3) > NearThres
        switch display(i,2)
            case 1 
                rectangle('position', RECT(display(i,1),:), 'EdgeColor', 'b', 'LineWidth', 1.5);
                text(RECT(display(i,1),1)+2,RECT(display(i,1),2)+5,'Bowling','color', 'b')
            case 2
                rectangle('position', RECT(display(i,1),:), 'EdgeColor', 'g', 'LineWidth', 1.5);
                text(RECT(display(i,1),1)+2,RECT(display(i,1),2)+5,'Golf','color', 'g')
            case 3
                rectangle('position', RECT(display(i,1),:), 'EdgeColor', 'r', 'LineWidth', 1.5);
                text(RECT(display(i,1),1)+2,RECT(display(i,1),2)+5,'Soccer','color', 'r')
            case 4
                rectangle('position', RECT(display(i,1),:), 'EdgeColor', 'c', 'LineWidth', 1.5);
                text(RECT(display(i,1),1)+2,RECT(display(i,1),2)+5,'Tennis','color', 'c')
        end
    end
end