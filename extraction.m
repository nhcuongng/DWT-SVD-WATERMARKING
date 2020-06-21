function varargout = extraction(varargin)
% EXTRACTION MATLAB code for extraction.fig
%      EXTRACTION, by itself, creates a new EXTRACTION or raises the existing
%      singleton*.
%
%      H = EXTRACTION returns the handle to a new EXTRACTION or the handle to
%      the existing singleton*.
%
%      EXTRACTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACTION.M with the given input arguments.
%
%      EXTRACTION('Property','Value',...) creates a new EXTRACTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before extraction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to extraction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help extraction

% Last Modified by GUIDE v2.5 20-Jun-2020 22:51:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @extraction_OpeningFcn, ...
                   'gui_OutputFcn',  @extraction_OutputFcn, ...
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


% --- Executes just before extraction is made visible.
function extraction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to extraction (see VARARGIN)

% Choose default command line output for extraction
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes extraction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = extraction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in chonAnhDaNhung.
function chonAnhDaNhung_Callback(hObject, eventdata, handles)
% hObject    handle to chonAnhDaNhung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon anh y te goc'); %select image
watermarked_image=imread(strcat(anhmau,fname));

handles.AnhDaNhungThuyVan = watermarked_image;
axes(handles.anhDaNhung);
imshow(watermarked_image);
guidata(hObject, handles);



% --- Executes on button press in chonAnhGoc.
function chonAnhGoc_Callback(hObject, eventdata, handles)
% hObject    handle to chonAnhGoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon anh y te goc'); %select image
anhGoc=imread(strcat(anhmau,fname));

anhGoc = ChangeImageToGray(anhGoc);
axes(handles.hienThiAnhGocNhieu)  %Fisso l'axes per il plot
imshow(anhGoc)

anhGoc = medfilt2(anhGoc);
axes(handles.hienThiAnhKhuNhieu)  %Fisso l'axes per il plot
imshow(anhGoc)

handles.AnhGoc= anhGoc;
guidata(hObject, handles);


% --- Executes on button press in batDauTrichXuat.
function batDauTrichXuat_Callback(hObject, eventdata, handles)
% hObject    handle to batDauTrichXuat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% print_figures = false;
%watermark_logo_extracted = watermark_extraction(handles.watermarked_image, handles.watermark_logo, true);
% watermark_logo_extracted = dwt_svd_extract(handles.watermark_logo, handles.watermarked_image, 0.1);
if(isfield(handles, 'AnhDaNhungThuyVan')==0 ||isfield(handles, 'AnhGoc')==0 )
     msgbox('Bạn chưa chọn ảnh!!', 'Error','error');
else
    AnhDaNhungThuyVan = handles.AnhDaNhungThuyVan;
    AnhGoc=handles.AnhGoc;

    [anhgoc_LL1,anhgoc_LH1,anhgoc_HL1,anhgoc_HH1]=dwt2(AnhGoc,'haar');
    [wm_LL1,wm_LH1,wm_HL1,wm_HH1]=dwt2(AnhDaNhungThuyVan,'haar');

    % Trich xuat
    r_SVD=my_svd(double(wm_HH1),double(anhgoc_HH1));

    % Dao nguoc SVD va hien thi ket qua
    anhTachThuyVan =uint8(r_SVD);
    axes(handles.anhDuocTrichXuat);
    imshow(anhTachThuyVan);

    % Lay lai anh thuy van sau inerverse Arnold
    % key = str2num(get(handles.keyArnold, 'string'));
    % anhTachThuyVan = IArnold(anhTachThuyVan, key);
    % axes(handles.anhInverseArnold);
    % imshow(anhTachThuyVan);

    msgbox("Trích xuất thành công ảnh thuỷ vân")

    handles.anhTachThuyVan = anhTachThuyVan;
end
guidata(hObject, handles);


% --- Executes on button press in luuAnh.
function luuAnh_Callback(hObject, eventdata, handles)
% hObject    handle to luuAnh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global var;
if(isfield(handles, 'AnhDaNhungThuyVan')==0 ||isfield(handles, 'AnhGoc')==0 )
     msgbox('Bạn chưa chọn ảnh!!', 'Error','error');
else
    [filename,pathname,filterindex]=uiputfile({'*.jpg;*.jpeg;*.gif;*.tif;*.tiff;*.rgb;*.bmp;*.png',...
        'All support image files';'*.jpg;*.jpeg','JPEG files(*.jpg;*.jpeg)';'*.gif','GIF files (*.gif)';...
        '*.tif;*.tiff','TIFF files (*.tif;*.tiff)';'*.bmp','Bitmap files (*.bmp)';'*.png','PNG files (*.png)'},'Luu dang file anh');
    var=strcat(pathname,filename);
    imwrite(uint8(handles.anhTachThuyVan),var);
    msgbox("Lưu thành công ảnh thuỷ vân")
end



function rSVD=my_svd(out1,out2)
% img1 : Anh da thuy van
[Uew,Sew,Vew]=svd(out1); % anh da thuy van
[Ui,Si,Vi]=svd(out2); % anh y te goc
 alpha = 0.08;
 load Uw.mat Uw
 load Vw.mat Vw
  Smark = (Sew - Si)/alpha;

     rSVD =  Uw*Smark*Vw';

     function outImage = ChangeImageToGray(img)
[r, c, p]=size(img);
if(p==3)
    outImage = rgb2gray(img);
else
    outImage = img;
end
