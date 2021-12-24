function varargout = klasifikasi_tanah(varargin)
% KLASIFIKASI_TANAH MATLAB code for klasifikasi_tanah.fig
%      KLASIFIKASI_TANAH, by itself, creates a new KLASIFIKASI_TANAH or raises the existing
%      singleton*.
%
%      H = KLASIFIKASI_TANAH returns the handle to a new KLASIFIKASI_TANAH or the handle to
%      the existing singleton*.
%
%      KLASIFIKASI_TANAH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KLASIFIKASI_TANAH.M with the given input arguments.
%
%      KLASIFIKASI_TANAH('Property','Value',...) creates a new KLASIFIKASI_TANAH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before klasifikasi_tanah_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to klasifikasi_tanah_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help klasifikasi_tanah

% Last Modified by GUIDE v2.5 22-Dec-2021 14:40:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @klasifikasi_tanah_OpeningFcn, ...
                   'gui_OutputFcn',  @klasifikasi_tanah_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before klasifikasi_tanah is made visible.
function klasifikasi_tanah_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to klasifikasi_tanah (see VARARGIN)

% Choose default command line output for klasifikasi_tanah
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes klasifikasi_tanah wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = klasifikasi_tanah_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function home_Callback(hObject, eventdata, handles)
% hObject    handle to home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_judul, 'visible','on');
set(handles.panel_deskripsi, 'visible','off');
set(handles.panel_klasifikasi, 'visible','off');
set(handles.panel_Data_latih, 'visible','off');

% --------------------------------------------------------------------
function deskripsi_Callback(hObject, eventdata, handles)
% hObject    handle to deskripsi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_judul, 'visible','off');
set(handles.panel_deskripsi, 'visible','on');
set(handles.panel_klasifikasi, 'visible','off');
set(handles.panel_Data_latih, 'visible','off');


% --------------------------------------------------------------------
function klasifikasi_Callback(hObject, eventdata, handles)
% hObject    handle to klasifikasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_judul, 'visible','off');
set(handles.panel_deskripsi, 'visible','off');
set(handles.panel_klasifikasi, 'visible','on');
set(handles.panel_Data_latih, 'visible','off');

% --- Executes on button press in button_file.
function button_file_Callback(hObject, eventdata, handles)
% hObject    handle to button_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_browse.
function button_browse_Callback(hObject, eventdata, handles)
% hObject    handle to button_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile({'*.*'});
if ~isequal (filename,0)
    Info = imfinfo(fullfile(pathname,filename));
    img_Gray = "";
    
    %Memastikan format citra adalah RGB atau Grayscale
    if Info.BitDepth == 1
        msgbox('citra masukan harus citra RGB atau Grayscale');
        return
        
    %Masukkan citra ke Img_Gray jika citra sudah grayscale
    %Grayscale terdiri dari 0-255, jumlah 255
    %Total 8 bit adalah 256
    %BithDept = 9
    elseif Info.BitDepth == 8
        Img_Gray = imread(fullfile(pathname,filename));
        
    else 
        Img_Gray = imread(fullfile(pathname,filename));
        
    end
     
    %tampilkan gambar
    set(handles.url,'String',[pathname,filename]);
    axes(handles.axes3)
    cla('reset')
    imshow(Img_Gray)
    
    
else
    return
end

handles.Img_Gray = Img_Gray;
%handles.Img_Gray2 = Img_Gray2;
guidata(hObject,handles);

% --- Executes on button press in button_proses.
function button_proses_Callback(hObject, eventdata, handles)
% hObject    handle to button_proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 Img_Gray = handles.Img_Gray;
 Img_Gray2 = rgb2gray(Img_Gray);
 
 axes(handles.axes4)
      cla('reset')
      imshow(Img_Gray2)

[G0, G45, G90, G135] = glcm(handles.Img_Gray2);
fitur = [G0.asm G45.asm G90.asm G135.asm G0.kontras G45.kontras G90.kontras G135.kontras G0.idm G45.idm G90.idm G135.idm G0.entropi G45.entropi G90.entropi G135.entropi G0.korelasi G45.korelasi G90.korelasi G135.korelasi];

%Hasil fitur 
statasm = [G0.asm G45.asm G90.asm G135.asm];
statkontras = [G0.kontras G45.kontras G90.kontras G135.kontras];
statidm = [G0.idm G45.idm G90.idm G135.idm];
statentropi = [G0.entropi G45.entropi G90.entropi G135.entropi];
statkorelasi = [G0.korelasi G45.korelasi G90.korelasi G135.korelasi];
%statmean = [mean.kontras];

asm = statasm;
kontras = statkontras;
idm = statidm;
entropi = statentropi;
korelasi = statkorelasi;
%mean = statmean;


data = get(handles.uitable1,'Data');
data{1,1} = num2str(asm(1));
data{1,2} = num2str(asm(2));
data{1,3} = num2str(asm(3));
data{1,4} = num2str(asm(4));
data{1,5} = num2str(mean(asm));

data{2,1} = num2str(kontras(1));
data{2,2} = num2str(kontras(2));
data{2,3} = num2str(kontras(3));
data{2,4} = num2str(kontras(4));
data{2,5} = num2str(mean(kontras));

data{3,1} = num2str(idm(1));
data{3,2} = num2str(idm(2));
data{3,3} = num2str(idm(3));
data{3,4} = num2str(idm(4));
data{3,5} = num2str(mean(idm));

data{4,1} = num2str(entropi(1));
data{4,2} = num2str(entropi(2));
data{4,3} = num2str(entropi(3));
data{4,4} = num2str(entropi(4));
data{4,5} = num2str(mean(entropi));

data{5,1} = num2str(korelasi(1));
data{5,2} = num2str(korelasi(2));
data{5,3} = num2str(korelasi(3));
data{5,4} = num2str(korelasi(4));
data{5,5} = num2str(mean(korelasi));

set(handles.uitable1, 'Data',data)
handles.fitur = fitur;
guidata(hObject,handles)
% --- Executes on butt  on press in button_reset.
function button_reset_Callback(hObject, eventdata, handles)
% hObject    handle to button_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try 
    delete(handles.vidObj)
catch
end

axes(handles.axes3)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes4)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.url,'String',[]);
set(handles.edit_hasil,'String',[]);
set(handles.uitable1,'Data',[]);


function url_Callback(hObject, eventdata, handles)
% hObject    handle to url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of url as text
%        str2double(get(hObject,'String')) returns contents of url as a double


% --- Executes during object creation, after setting all properties.
function url_CreateFcn(hObject, eventdata, handles)
% hObject    handle to url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hasil_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hasil as text
%        str2double(get(hObject,'String')) returns contents of edit_hasil as a double


% --- Executes during object creation, after setting all properties.
function edit_hasil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myFolder = uigetdir('E:\');
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
    uiwait(warndlg(errorMessage));
    myFolder = uigetdir(); % Ask for a new one.
    if myFolder == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.jpeg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

handles.theFiles = theFiles;
handles.theFiles2 = theFiles;


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[G0, G45, G90, G135] = glcm(handles.Img_Gray);

%Hasil fitur 
fitur=[G0.asm G0.kontras G0.idm G0.entropi G0.korelasi G45.asm G45.kontras G45.idm G45.entropi G45.korelasi G90.asm G90.kontras G90.idm G90.entropi G90.korelasi G135.asm G135.kontras G135.idm G135.entropi G135.korelasi];
xlswrite('fiturtekstur.xls',fitur);
axes(handles.axes5)
cla('reset')
imshow(fitur)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myFolder = uigetdir('E:\Proyek Matlab\Projek Jenis tanah\Tanah');
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
    uiwait(warndlg(errorMessage));
    myFolder = uigetdir(); % Ask for a new one.
    if myFolder == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.jpg','*.png'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

handles.theFiles = theFiles;
handles.theFiles2 = theFiles;


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton22 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% dt_hasil=xlsread('hasil.xls');
% x1=dt_hasil(:,1:20);
% t1=dt_hasil(:,21);
% dt_uji=xlsread('data uji.xls');
% x1_uji=dt_uji(:,1:20);
% y1_uji=dt_uji(:,21);
% for 
%     
% 
% m=size(y1_uji);
% ttl1=0;
% for i=1:m
%     if(kls1(i)==y1_uji(1))
%         ttl1=ttl1+1;
%     end
% end
% akurasi_knn=ttl1/m*100;

% [ num_hasil, txt_hasil, raw_hasil ] = xlsread('hasil.xls');
% x1=raw_hasil(:,1:20);
% [a b] = size(x1);
% t1=raw_hasil(:,21);
% fitur = handles.fitur;
% 
% arrData = [];
% arrLabel = t1;
% for j=1:a
%   res = 0;
%   for k=1:b
%     n1 = x1(j,k);
%     n1 = str2double(n1);
%     n2 = fitur(k);
%     res = res + (n1 - n2).^2;
%   end
%   res = sqrt(res);
%   arrData = [arrData res];
% end
% [values,isort]=sort(arrData);
% names=arrLabel(isort);
% names(1)


hasil = xlsread('hasil.xls');
x1=hasil(:,1:20);
t1=hasil(:,21);
fitur = handles.fitur;

c1 = fitcknn(x1,t1,'NumNeighbors',3);
hasil1 = predict(c1,fitur);

if hasil1==1
    klasifikasi='Tanah Kapur';
    elseif hasil1==2
        klasifikasi='Tanah Laterit';
    elseif hasil1==3
        klasifikasi='Tanah Pasir';
end

set(handles.edit_hasil,'string',klasifikasi);


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% folder = ["Data Uji/1" "Data Uji/2" "Data Uji/3"]
% namaFolder = ["1" "2" "3"];

% folder = ["Tanah/1" "Tanah/2" "Tanah/3"]
% namaFolder = ["1" "2" "3"];

% folder = ["tes/1" "tes/2" "tes/3" "tes/4"]
% namaFolder = ["1" "2" "3" "4"];

folder = ["train/1" "train/2" "train/3" "train/4"]
namaFolder = ["1" "2" "3" "4"];
fitur = [];
p = numel(folder)
for h = 1:p
    fn = [ dir(fullfile(folder(h), '*.jpg')) ; dir(fullfile(folder(h), '*.png'))];
    total = numel(fn);
    for i = 1:total
        r = fullfile(folder(h), fn(i).name);
        a = imread(r);
        c = rgb2gray(a);
        [G0, G45, G90, G135] = glcm(c);
        fitur = [fitur;[G0.asm G45.asm G90.asm G135.asm G0.kontras G45.kontras G90.kontras G135.kontras G0.idm G45.idm G90.idm G135.idm G0.entropi G45.entropi G90.entropi G135.entropi G0.korelasi G45.korelasi G90.korelasi G135.korelasi namaFolder(h)]];
    end
end
% save Mdl fitur
xlswrite('hasil.xls',fitur);



% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myFolder = uigetdir('E:\Proyek Matlab\Projek Jenis tanah');
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
    uiwait(warndlg(errorMessage));
    myFolder = uigetdir(); % Ask for a new one.
    if myFolder == 0
         % User clicked Cancel
         return;
    end
end

handles.folder = myFolder;
guidata(hObject,handles);
% --------------------------------------------------------------------
function Data_latih_Callback(hObject, eventdata, handles)
% hObject    handle to Data_latih (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_judul, 'visible','off');
set(handles.panel_deskripsi, 'visible','off');
set(handles.panel_klasifikasi, 'visible','off');
set(handles.panel_Data_latih, 'visible','on');


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img_Gray2 = rgb2gray(handles.Img_Gray);
axes(handles.axes4)
cla('reset')
imshow(Img_Gray2)
handles.Img_Gray2 = Img_Gray2;
guidata(hObject,handles);

% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
