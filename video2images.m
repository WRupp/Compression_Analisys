% Aquisição de imagens- Le e adquire imagens do video
% Guilherme Tavares
%%%%%%%%%%%%%%%%%%%%%%%



function [NumFramesCam1] = video2images(VideoFileName,ImageBaseName)
    %% Converte video em imagens
    h = waitbar(0,'Processing Images from Video ');
    cam1 = VideoReader(VideoFileName);
    
    
    NumFramesCam1=cam1.NumberOfFrames;
    N_slots=num2str(NumFramesCam1);
    format_image = 'tif';
    filename = ImageBaseName;

    for j=1:NumFramesCam1
        number_ext = num2str(j);
        Image_name = [filename  number_ext '.' format_image];
        I = (read(cam1,j));
        J = I; 
        imwrite(J, ['Images\' Image_name ], 'Compression', 'None');
        waitbar(j /NumFramesCam1)
    end
    close(h)
end
