function varargout = emmbeding(varargin)
% EMMBEDING MATLAB code for emmbeding.fig
%      EMMBEDING, by itself, creates a new EMMBEDING or raises the existing
%      singleton*.
%
%      H = EMMBEDING returns the handle to a new EMMBEDING or the handle to
%      the existing singleton*.
%
%      EMMBEDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMMBEDING.M with the given input arguments.
%
%      EMMBEDING('Property','Value',...) creates a new EMMBEDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before emmbeding_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to emmbeding_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help emmbeding

% Last Modified by GUIDE v2.5 18-Jun-2020 22:37:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @emmbeding_OpeningFcn, ...
                   'gui_OutputFcn',  @emmbeding_OutputFcn, ...
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


% --- Executes just before emmbeding is made visible.
function emmbeding_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to emmbeding (see VARARGIN)

% Choose default command line output for emmbeding
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes emmbeding wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = emmbeding_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in chonAnhPhu.
function chonAnhPhu_Callback(hObject, eventdata, handles)
% hObject    handle to chonAnhPhu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon anh goc'); %select image
anhPhu=imread(strcat(anhmau,fname));

anhPhu = ChangeImageToGray(anhPhu);
axes(handles.hienThiAnhPhu)  %Fisso l'axes per il plot
imshow(anhPhu)

handles.anhPhu = anhPhu;
guidata(hObject, handles);



% --- Executes on button press in chonAnhBiMat.
function chonAnhBiMat_Callback(hObject, eventdata, handles)
% hObject    handle to chonAnhBiMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon anh bi mat'); %select image
anhBiMat=imread(strcat(anhmau,fname));
anhBiMat = ChangeImageToGray(anhBiMat);
% Hien thi
axes(handles.hienThiAnhBiMat)
imshow(anhBiMat);

% Bien doi Arnold
% key = str2num(get(handles.keyArnold, 'string'));
% anhBiMat = Arnold(anhBiMat, key);
% axes(handles.anhBiMatDaBienDoiArnold)  %Fisso l'axes per il plot
% imshow(anhBiMat);

handles.anhBiMat = anhBiMat;
guidata(hObject, handles);


% --- Executes on button press in batDauNhung.
function batDauNhung_Callback(hObject, eventdata, handles)
% hObject    handle to batDauNhung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% print_figures = false;
%watermarked_image = watermark_embedding(handles.cover_image, handles.watermark_logo_after_arnold, false);
% watermarked_image = dwt_svd_emmbed(handles.cover_image, handles.watermark_logo_after_arnold, handles.alpha);

%start
anhBiMat = handles.anhBiMat;
anhPhu= handles.anhPhu;

[anhphu_LL1,anhphu_LH1,anhphu_HL1,anhphu_HH1]=dwt2(anhPhu,'haar');
% thay doi kich thuoc anh thuy van = anhgoc_HH1
[r, c, p]=size(anhphu_HH1);
anhBiMat = imresize(anhBiMat,[r, c]);

% Nhung dung SVD
water_marked_HH1=mysvd(double(anhphu_HH1),double(anhBiMat));

%su  dung idwt2 
watermarked=idwt2(anhphu_LL1,anhphu_LH1,anhphu_HL1,water_marked_HH1,'haar');
anhDaThuyVan=uint8(watermarked); % ket qua

% nhung thanh cong và hiển thi kêt quả
axes(handles.anhDaNhung);
imshow(anhDaThuyVan);
handles.watermarked_image = anhDaThuyVan;

guidata(hObject, handles);



function keyArnold_Callback(hObject, eventdata, handles)
% hObject    handle to keyArnold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of keyArnold as text
%        str2double(get(hObject,'String')) returns contents of keyArnold as a double


% --- Executes during object creation, after setting all properties.
function keyArnold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyArnold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in luuAnh.
function luuAnh_Callback(hObject, eventdata, handles)
% hObject    handle to luuAnh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname,filterindex]=uiputfile({'*.jpg;*.jpeg;*.gif;*.tif;*.tiff;*.rgb;*.bmp;*.png',...
    'All support image files';'*.jpg;*.jpeg','JPEG files(*.jpg;*.jpeg)';'*.gif','GIF files (*.gif)';...
    '*.tif;*.tiff','TIFF files (*.tif;*.tiff)';'*.bmp','Bitmap files (*.bmp)';'*.png','PNG files (*.png)'},'Luu dang file anh');
imwrite(mat2gray(handles.watermarked_image), strcat(pathname,filename));



% --- Executes on button press in showHistogram.
function showHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to showHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
subplot(2,1,1)
histogram(handles.anhPhu);
xlabel('Anh phủ');
subplot(2,1,2)
histogram(handles.watermarked_image);
xlabel('Anh bí mật');


function rSVD=mysvd(img1,img2)
% img1 : Anh Goc
% img2 : Anh thuy van
alpha = 0.08;
    [Ui,Si,Vi]=svd((img1)); % anh goc
    [Uw,Sw,Vw]=svd((img2)); % anh thuy van
    save Uw.mat Uw
    save Vw.mat Vw
       Smark = Si + (alpha*Sw);
       rSVD =  Ui*Smark*Vi';
       
function outImage = ChangeImageToGray(img)
[r, c, p]=size(img);
if(p==3)
    outImage = rgb2gray(img);
else
    outImage = img;
end
