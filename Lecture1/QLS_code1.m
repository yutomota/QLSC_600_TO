%% identify the input and output folder
    ii =1;
    name_of_folder='/Users/oyamat/Downloads/choreography_result';
    outdir="/Users/oyamat/Documents/GitHub/lulumoonxyl/Choreography data analysis --PI, tracjectory plot, heatmap/output";
   
    %% load data
    %get raw choreography data (x,y,speed) from the .txt files
    [dat,uname]=get_data_from_dat_file(name_of_folder,ii);
    %concatenate all the data, which will be used for plotting trajectory
    %later
    [dat,xmax,ymax]=vertcat_all_data (dat);
    %grouped data based on their aninmal number (AN)
    dat_grouped=group_all_data_based_on_AN(dat);
    %add two new variables xcentered and ycentered which can be used for
    %the centered trajectory later (all trajectory will have a start point at [0,0])
    [dat,dat_grouped]=generate_centered_data(dat,dat_grouped);

%     %% remove both the first 120s and the edge from the data
%     if ~isempty(both_edge) && ~isempty(both_ns)
%         [dat_edge,dat_grouped_edge]=eliminate_edge(dat,dat_grouped,both_edge);
%         [dat_both,dat_grouped_both]=remove_the_first_ns(dat_edge,dat_grouped_edge,both_ns);
%         clear dat_edge dat_grouped_edge
%     end
% % 
%     %% eliminate the first 120s of the data
%     if ~isempty(ns)
%         [dat_ns,dat_grouped_ns]=remove_the_first_ns(dat,dat_grouped,ns);
%     end
%     %% remove the datapoints at the edge
%     if ~isempty(edge)
%         [dat_edge,dat_grouped_edge]=eliminate_edge(dat,dat_grouped,edge);
%     end
    %% plot
    % 1) the tracjectory
    color=[0.0353,0.2784,0.5020;0.051,0.4157,0.749; 0.4392,0.7333,1.0;0.8392,0.2706,0.3137;0,0,0];
    name={'10^-^1GA','10^-^2GA','10^-^3GA','10^-^5EA','H2O'};
    %row=2;col=3;num=1;str='';
    
    trafig=plot_trajectory_TO(dat,name,1,ii);
    % heatfig=plot_heatmap_TO(dat,name,ii,xmax,ymax,1,str,[],outdir);
    
%     %% 2)plot the centered trajectory (all the trajectories start from [0,0])
%     if plot_input(2)=='y'
%         ii=plot_centered_trajectory(dat,color,name,ii,ii_num,row,col,num,str,outdir);
%     end
%     % 3)plot heatmap (another representation of trajectory)
%     if plot_input(3)=='y'
%         if ii==1
%             lim=[];
%         end
%         lim=plot_heatmap(dat,name,ii,ii_num,row,col,xmax,ymax,num,str,lim,outdir);
%     end
%     % 4)calculate and plot the sum of tracking time at each x bins
%    
%         if ii==1
%         tt=[];
%         end
%         tt=calculate_tracking_time(tt,dat_grouped,xmax,ii,ii_num,name,num,row,col,color,str,outdir);
%    
%% Calculate the navigational index
%     if ii==1
%         PI_mean=[];PI_t_mean=[];PI_t_sem=[];PI_sem=[];PI_timeseries={};
%     end
%1)calculate the navigational index:v_x/speed for each timepoint
    t = [];
    [dat_grouped,PI_mean,PI_sem]=calculate_navigational_index_velocity_vs_speed(dat_grouped,ii,t)
    
    %% Calculate the navigational index based on location as function of time
    %((number of larvae close to the odor-number of larvae away from the odor)/total number of larvare)
    PI_timeseries={};
    time=0:10:900;
    [dat_grouped,PI_timeseries]=calculate_preferential_index_vs_time(dat_grouped,ii,time,xmax,PI_timeseries);
    % plot the navigational index
    str=''
      
    num=plot_PI_timeseries(PI_timeseries,name,color,time,1,outdir,str);
  
%% save the data file
file_dir=fullfile(outdir,'data');
if ~isdir(file_dir)
    mkdir(file_dir);
end
name_file={'10E-1GA','10E-2GA','10E-3GA','10E-5EA','H2O'};
filename=fullfile(file_dir,append(name_file(ii),'_data.mat'));
if isfile(filename)
    delete(filename);
end
    save( filename, 'dat*')


if ii==5
    %save the preferential index data
    filename=fullfile(file_dir,'_PI_data.mat');

    if isfile(filename)
        delete(filename);
    end
        save( filename, 'PI*')
   
end
clearvars -except PI* ii_num lim* ns edge both_edge both_ns plot_input tt*
