%% identify the input and output folder
% name of holder need to set depending on your location of data
% outdir please set the location of your 

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
