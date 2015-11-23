

basedir = '/v/filer4b/v26q010/pset5data/';


actions = {'botharms', 'crouch', 'leftarmup', 'punch', 'rightkick'};

outind = 1;

% cycle through all 5 action categories
for actionnum=1:length(actions)

    subdirname = [basedir actions{actionnum} '/'];
    subdir = dir(subdirname);
    fprintf('\n\nprocessing dir %s\n', actions{actionnum});
    
    
    % cycle through all sequences for this action category
    for seqnum=3:length(subdir) % (starting at 3 because 1 and 2 are . and ..)

     
        % record the action category label for this example, as an integer
        labels(outind) = actionnum;

        
    
        depthfiles = dir([basedir actions{actionnum} '/' subdir(seqnum).name '/*.pgm']);
        
        fprintf('sequence %d of %d in %s: %s\n', seqnum-2, length(subdir)-2, subdirname, subdir(seqnum).name); 

        
        % cycle through first all frames in this sequence 
        for i=1:length(depthfiles)  

            % read in the next depth map
            depth = imread([basedir actions{actionnum} '/' subdir(seqnum).name '/' depthfiles(i).name]);

            % display
            imagesc(depth);
            title(['action ' int2str(actionnum) ', sequence ' int2str(seqnum-2) ', frame' int2str(i)]);
            
            pause;
            fprintf('any key to continue, control-C to stop.\n');
        end
      
        outind = outind + 1;
    end


end

