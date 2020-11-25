function varargout = pagina_principal1(varargin)
% PAGINA_PRINCIPAL1 MATLAB code for pagina_principal1.fig
%      PAGINA_PRINCIPAL1, by itself, creates a new PAGINA_PRINCIPAL1 or raises the existing
%      singleton*.
%
%      H = PAGINA_PRINCIPAL1 returns the handle to a new PAGINA_PRINCIPAL1 or the handle to
%      the existing singleton*.
%
%      PAGINA_PRINCIPAL1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAGINA_PRINCIPAL1.M with the given input arguments.
%
%      PAGINA_PRINCIPAL1('Property','Value',...) creates a new PAGINA_PRINCIPAL1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pagina_principal1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pagina_principal1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pagina_principal1

% Last Modified by GUIDE v2.5 18-Aug-2020 07:31:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pagina_principal1_OpeningFcn, ...
                   'gui_OutputFcn',  @pagina_principal1_OutputFcn, ...
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


% --- Executes just before pagina_principal1 is made visible.
function pagina_principal1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pagina_principal1 (see VARARGIN)

% Choose default command line output for pagina_principal1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.Logo);
[x, mapa] = imread('logoU.jpg');
image(x);
colormap(mapa);
axis off;
hold on;
axes(handles.LogoEmpr);
[y, mapa2] = imread('LogoVc.jpeg');
image(y);
colormap(mapa2);
axis off;
hold on;

% UIWAIT makes pagina_principal1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pagina_principal1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in enviar.
function enviar_Callback(hObject, eventdata, handles)
% hObject    handle to enviar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(pagina_principal1);
Pagina_resultados;

% --- Agregar imagenes a axis
