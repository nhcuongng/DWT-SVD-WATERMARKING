function varargout = danhGia(varargin)
% DANHGIA MATLAB code for danhGia.fig
%      DANHGIA, by itself, creates a new DANHGIA or raises the existing
%      singleton*.
%
%      H = DANHGIA returns the handle to a new DANHGIA or the handle to
%      the existing singleton*.
%
%      DANHGIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DANHGIA.M with the given input arguments.
%
%      DANHGIA('Property','Value',...) creates a new DANHGIA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before danhGia_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to danhGia_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help danhGia

% Last Modified by GUIDE v2.5 20-Jun-2020 23:48:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @danhGia_OpeningFcn, ...
                   'gui_OutputFcn',  @danhGia_OutputFcn, ...
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


% --- Executes just before danhGia is made visible.
function danhGia_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to danhGia (see VARARGIN)

% Choose default command line output for danhGia
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes danhGia wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = danhGia_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in btnDanhGia.
function btnDanhGia_Callback(hObject, eventdata, handles)
% Truoc tan cong
if(isfield(handles, 'anhGoc')==0 ||isfield(handles, 'anhThuyVan')==0 )
  msgbox('Bạn chưa chọn ảnh!!', 'Error','error');
  return;
end
anhGoc=handles.anhGoc;
anhThuyVan=handles.anhThuyVan;
axes(handles.axes2);        
imshow(anhThuyVan);

% danh gia chi tieu
[ncc, psnr, mse] = danhGiaChiTieu(anhGoc, anhThuyVan);

set(handles.txt_ncc,'String',ncc);
set(handles.txt_psnr,'String',psnr);
set(handles.txt_mse,'String',mse);

function  Image=OpenImage()
[fname, anhmau]=uigetfile({'*.png;*.tif;*bmp'},'Chon anh '); %select image
Image=imread(strcat(anhmau,fname));


% --- Executes on button press in showHistogram.
function showHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to showHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
subplot(2,1,1)
histogram(handles.anhGoc);
xlabel('Anh phủ');
subplot(2,1,2)
histogram(handles.anhThuyVan);
xlabel('Anh thuỷ vân');


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
