function varargout = Attacking(varargin)
% ATTACKING MATLAB code for Attacking.fig
%      ATTACKING, by itself, creates a new ATTACKING or raises the existing
%      singleton*.
%
%      H = ATTACKING returns the handle to a new ATTACKING or the handle to
%      the existing singleton*.
%
%      ATTACKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATTACKING.M with the given input arguments.
%
%      ATTACKING('Property','Value',...) creates a new ATTACKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Attacking_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Attacking_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Attacking

% Last Modified by GUIDE v2.5 21-Jun-2020 00:03:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Attacking_OpeningFcn, ...
                   'gui_OutputFcn',  @Attacking_OutputFcn, ...
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


% --- Executes just before Attacking is made visible.
function Attacking_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Attacking (see VARARGIN)

% Choose default command line output for Attacking
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Attacking wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Attacking_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in AttackNoise.

function AttackNoise_Callback(hObject, eventdata, handles)
%Tan cong lam nhieu anh
if(isfield(handles, 'anhGoc')==0 ||isfield(handles, 'anhThuyVan')==0 )
  msgbox('Bạn chưa chọn ảnh!!', 'Error','error');
else
anhGoc=handles.anhGoc;
anhThuyVan=handles.anhThuyVan;
var_=get(handles.edit1,'string');
var_ = str2double(var_);

TypeAttack = get(handles.AttackTypeNoise,'value');

if(TypeAttack==1)
    %Gaussian noise
    ImgAttacked = imnoise(anhThuyVan,'gaussian',0,var_);
elseif(TypeAttack==2)
    %Salt & Pepper
    ImgAttacked = imnoise(anhThuyVan,'salt & pepper', var_); 
elseif(TypeAttack==3)
    %Speckle noise
    ImgAttacked = imnoise(anhThuyVan,'speckle',var_);
elseif(TypeAttack==4)
    %AverageFilter
end

axes(handles.axes2);        
imshow(ImgAttacked);
[ncc, psnr, mse] = danhGiaChiTieu(anhGoc, ImgAttacked);
%NCC
set(handles.txt_ncc,'String',ncc);
% PSNR
set(handles.txt_psnr,'String',psnr);

end
guidata(hObject, handles);


% --- Executes on button press in btn_AnhGoc.
function btn_AnhGoc_Callback(hObject, eventdata, handles)
% hObject    handle to btn_AnhGoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    anhGoc=OpenImage();
    [r, c, p]=size(anhGoc);
    if( p==3 )
      anhGoc=rgb2gray(anhGoc);
   end
axes(handles.axes1)             %Fisso l'axes per il plot
imshow(anhGoc)
handles.anhGoc=anhGoc;
guidata(hObject, handles);


% --- Executes on button press in btn_chonAnhMangTin.
function btn_chonAnhMangTin_Callback(hObject, eventdata, handles)
% hObject    handle to btn_chonAnhMangTin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 anhThuyVan=OpenImage();
    [r, c, p]=size(anhThuyVan);
    if( p==3 )
      anhThuyVan=rgb2gray(anhThuyVan);
   end

axes(handles.axes2)             %Fisso l'axes per il plot
imshow(anhThuyVan)
handles.anhThuyVan=anhThuyVan;
guidata(hObject, handles);


% --- Executes on button press in btnClear.
function btnClear_Callback(hObject, eventdata, handles)
% Truoc tan cong
if(isfield(handles, 'anhGoc')==0 ||isfield(handles, 'anhThuyVan')==0 )
  msgbox('Bạn chưa chọn ảnh!!', 'Error','error');
else
anhGoc=handles.anhGoc;
anhThuyVan=handles.anhThuyVan;
axes(handles.axes2);        
imshow(anhThuyVan);

% danh gia chi tieu truoc tan cong
[ncc, psnr, mse] = danhGiaChiTieu(anhGoc, anhThuyVan);

set(handles.txt_ncc,'String',ncc);
set(handles.txt_psnr,'String',psnr);
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
value = get(hObject,'value');
set(handles.edit1,'string',num2str(value));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
edit =  get(hObject,'string');
set(handles.slider1,'value',str2num(edit));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AttackTypeNoise.
function AttackTypeNoise_Callback(hObject, eventdata, handles)
try
SetDefault(handles);
catch
end


% --- Executes during object creation, after setting all properties.
function AttackTypeNoise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AttackTypeNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function  Image=OpenImage()
[fname, anhmau]=uigetfile({'*.png;*.tif;*bmp'},'Chon anh '); %select image
Image=imread(strcat(anhmau,fname));
function SetDefault(handles)
axes(handles.axes1) 
imshow(handles.anhGoc);
axes(handles.axes2) 
imshow(handles.anhThuyVan);
set(handles.slider1,'value',0.01);
set(handles.edit1,'string','0.01');
set(handles.txt_ncc,'String','');
set(handles.txt_psnr,'String','');


% --- Executes on button press in saveImg.
function saveImg_Callback(hObject, eventdata, handles)
% hObject    handle to saveImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isfield(handles, 'ImgAttacked')==0 )
  msgbox('Invalid Value!', 'Error','error');
else
[filename,pathname]=uiputfile({'*.png','PNG files (*.png)';'*.bmp','Bitmap files (*.bmp)';'*.tif;*.tiff','TIFF files (*.tif;*.tiff)'},'Luu dang file anh');
var=strcat(pathname,filename);
    try
    imwrite(handles.ImgAttacked,var);
    msgbox('Save complete', 'Success');
    catch
        msgbox('Save error', 'Error','error');
    end
end


% --- Executes on selection change in AttackTypeOther.
function AttackTypeOther_Callback(hObject, eventdata, handles)
% hObject    handle to AttackTypeOther (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AttackTypeOther contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AttackTypeOther


% --- Executes during object creation, after setting all properties.
function AttackTypeOther_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AttackTypeOther (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AttackOther.
function AttackOther_Callback(hObject, eventdata, handles)
% hObject    handle to AttackOther (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Cac Loai tan cong khac
if(isfield(handles, 'anhGoc')==0 ||isfield(handles, 'anhThuyVan')==0 )
  msgbox('Bạn chưa chọn ảnh!!', 'Error','error');
else
anhGoc=handles.anhGoc;
anhThuyVan=handles.anhThuyVan;
var_=get(handles.edit1,'string');
var_ = str2double(var_);

TypeAttack = get(handles.AttackTypeOther,'value');

if(TypeAttack==1)
    % Rotation attack
    ImgAttacked = rotationAttack(anhThuyVan, 45);
elseif(TypeAttack==2)
    % Mean attack
    ImgAttacked = meanAttack(anhThuyVan); 
elseif(TypeAttack==3)
    % Median attack
    ImgAttacked = medianAttack(anhThuyVan);
elseif(TypeAttack==4)
    % Crop attack
    attackedImage = cropAttack(anhThuyVan);
    ImgAttacked = imresize(attackedImage, [512 512]);
elseif(TypeAttack==5)
    % Shear Attack
    attackedImage = shearAttack(anhThuyVan);
    ImgAttacked = imresize(attackedImage, [512 512]);
end

axes(handles.axes2);        
imshow(ImgAttacked);
[ncc, psnr, mse] = danhGiaChiTieu(anhGoc, ImgAttacked);
%NCC
set(handles.txt_ncc,'String',ncc);
% PSNR
set(handles.txt_psnr,'String',psnr);

end
guidata(hObject, handles);


% --- Executes on button press in btnKhuNhieu.
function btnKhuNhieu_Callback(hObject, eventdata, handles)
% hObject    handle to btnKhuNhieu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isfield(handles, 'anhGoc')==0 ||isfield(handles, 'anhThuyVan')==0 )
  msgbox('Bạn chưa chọn ảnh!!', 'Error','error');
else
    anhGoc=medfilt2(handles.anhGoc);

    axes(handles.axes1)             %Fisso l'axes per il plot
    imshow(anhGoc)
    handles.anhGoc=anhGoc;
    guidata(hObject, handles);
end