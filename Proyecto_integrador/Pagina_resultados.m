function varargout = Pagina_resultados(varargin)
% PAGINA_RESULTADOS MATLAB code for Pagina_resultados.fig
%      PAGINA_RESULTADOS, by itself, creates a new PAGINA_RESULTADOS or raises the existing
%      singleton*.
%
%      H = PAGINA_RESULTADOS returns the handle to a new PAGINA_RESULTADOS or the handle to
%      the existing singleton*.
%
%      PAGINA_RESULTADOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAGINA_RESULTADOS.M with the given input arguments.
%
%      PAGINA_RESULTADOS('Property','Value',...) creates a new PAGINA_RESULTADOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pagina_resultados_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pagina_resultados_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pagina_resultados

% Last Modified by GUIDE v2.5 24-Nov-2020 16:25:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pagina_resultados_OpeningFcn, ...
                   'gui_OutputFcn',  @Pagina_resultados_OutputFcn, ...
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


% --- Executes just before Pagina_resultados is made visible.
function Pagina_resultados_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pagina_resultados (see VARARGIN)

% Choose default command line output for Pagina_resultados
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.diagramab);
[x, mapa] = imread('Diagram_bl.png');
image(x);
colormap(mapa);
axis off;
hold on;
axes(handles.modeloA);
[y, mod] = imread('avion.png');
image(y);
colormap(mod);
axis off;
hold on;
load_system('Simulacion_integrador');
find_system('Name','Simulacion_integrador');
open_system('Simulacion_integrador');

% UIWAIT makes Pagina_resultados wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pagina_resultados_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%------------------------------------------------------
% Modificamos cada parametro en la simulacion de simulink
global Proceso Act1 sens1 pla1 cont;
clc;
format compact
format short e;
%format long;
a = get(handles.numA,'string');
b = get(handles.denA,'string');
c = get(handles.numP,'string');
d = get(handles.denP,'string');
e = get(handles.numS,'string');
f = get(handles.denS,'string');
Kp = get(handles.Kcontr,'string');
T = get(handles.Tcontrolador,'string');
comprobp = get(handles.ControlProp,'Value');
comprobi = get(handles.Controlinte,'Value');
comprobd = get(handles.ControlDeriv,'Value');

comproid = get(handles.intdev,'Value');
compeade = get(handles.comde,'Value');
compeatr = get(handles.comret,'Value');
compeadeatr = get(handles.aderet,'Value');


g = str2num(e)*str2num(c);
ple = mat2str([g]);

% if (comprobp == 1)
%     % Controlador proporcional
%     der = 0;
%     int = 0;
%     cont = tf(str2num(Kp),1);
% end
% 
% if (comprobi == 1)
%     % Controlador Integral
%     der = 0;
%     int = str2num(Kp)/(str2num(T));
%     cont = tf([str2num(Kp)*str2num(T) str2num(Kp)],[str2num(T) 0]);
% end
% 
% 
% if (comprobd == 1)
%     % Controlador derivativo
%     int = 0;
%     der = str2num(Kp)*str2num(T);
%     cont = tf ([str2num(Kp)*str2num(T) 1],1); %tf([str2num(Kp)*str2num(T) str2num(Kp)],[str2num(T) 0]);
% end
% 
%
% 
% % if (comprobd == 1)
% %     % Controlador derivativo
% %     int = 0;
% %     der = str2num(Kp)*str2num(T);
% %     cont = tf ([str2num(Kp)*str2num(T) 1],1);
% % end
if (comprobp == 1)
    % Controlador proporcional
    der = 0;
    int = 0;
    cont = tf(str2num(Kp),1);
    compensad=1;
end

if (comprobi == 1)
    % Controlador Integral
    der = 0;
    int = str2num(Kp)/(str2num(T));
    cont = tf([str2num(Kp)*str2num(T) str2num(Kp)],[str2num(T) 0]);
    compensad=1;
end

if (comprobd == 1)
    % Controlador derivativo
    int = 0;
    der = str2num(Kp)*str2num(T);
    cont = tf ([str2num(Kp)*str2num(T) 1],1);
    compensad=1;
end
 if (compeade == 1)
        %%Controlador derivativo
        int = 0;
        der=0;
        g1=str2num(Kp);
        g2=str2num(T);
        %alpha = linspace(0,1,0.1);
        alpha = 0.4;
        compensad = tf ((g1*alpha)*[g2 1],[(g2*alpha) 1]);
        numcompe1 = (g1*alpha)*[g2 1];
        DenCompe1 = [(g2*alpha) 1];
        numcompe2 = ["[", numcompe1,"]"];
        Dencompe2 = ["[",DenCompe1,"]"];
        numcompe = join(numcompe2);
        Dencompe = join(Dencompe2);
        
        set_param('Simulacion_integrador/Compensador','Numerator',numcompe);
        set_param('Simulacion_integrador/Compensador','Denominator',Dencompe);
 end



set_param('Simulacion_integrador/actuador','Numerator',a);
set_param('Simulacion_integrador/actuador','Denominator',b);
set_param('Simulacion_integrador/planta','Numerator',ple);
set_param('Simulacion_integrador/planta','Denominator',d);
set_param('Simulacion_integrador/sensor','Denominator',e);
set_param('Simulacion_integrador/sensor','Numerator',f);
set_param('Simulacion_integrador/Controlador','P',Kp);
set_param('Simulacion_integrador/Controlador','D',num2str(der));
set_param('Simulacion_integrador/Controlador','I',num2str(int));
% Ahora definiremos cada bloque para mostrar la respectiva funcion de
% transferencia
kpc = str2num(Kp);
syms s;
Act1 = tf(str2num(a),str2num(b));
pla1 = tf(str2num(c),str2num(d));
sens1 = tf(str2num(e),str2num(f));
Proceso = (((Act1*pla1*cont*compensad))/(1+Act1*pla1*sens1*cont*compensad));
opt = balredOptions('Offset',.001,'StateElimMethod','Truncate');
transf = zpk(Proceso);
%%FuncionTransfer = balred(transf,4,opt);
[numTF,denTF] = tfdata(Proceso);
%%[numrot,denrot] = tfdata(FuncionTransfer,'v');
x = cell2mat(numTF);
y = cell2mat(denTF);
[A, B, C, D] = tf2ss(x, y)
Apri = double(A);
Bpri = num2str(B);
Cpri = num2str(C);
Dpri = num2str(D);

syms K EPSILON Z 
V1 = sym(y);
[ROUTH TT] = ROUTHF(V1,EPSILON);
ROUTH= eval(ROUTH)
 
%Realizar calculos de criterio de routh
axes(handles.Polos);
    cla reset;
   
    rlocus(Proceso);
    hold on;
    syms k;
    syms ti;
    syms td;
    respuesta = "";
    
    if(comprobp == 1)
    dentf2prub = [1 11.4 14 7.98*k 7.98*k] %% Para criterio de K
    [salida,pantalla,rang] = RouthSolver(dentf2prub);%% Para cuando tengo proporcional
    end
    if (comprobi == 1)
        teqw = 7.98*kpc;
        double(teqw);
        dentf2int = [1 11.4 (14+teqw) teqw*(1+1/ti) teqw/ti];
        [salida,pantalla,rang] = RouthSolver(dentf2int); %% Para controlador integrador.
        
    end
    if (comprobd == 1)
        dent2der = [1 (11.4+7.98*kpc*td) (14+7.98*kpc*td) 7.98*kpc];
        [salida, pantalla,rang] = RouthSolver(dent2der);
        
    end
    
    if (compeade == 1)
    dentf2prub = [1 2 25.4 14 0 7.98*k 11.967*k  3.99*k]; %% Para criterio de K
    [salida,pantalla,rang] = RouthSolver(dentf2prub); %% Para cuando tengo proporcional
    end
    
    pre1 = salida;
    pre2 = pantalla;
    %rot = double(arreglo);
    inter = vpa(rang,4);
    
    set(handles.IntervaloEsta,'string',evalc('inter'));
    
   

%Obtener la función de transferencia simplificada de orden 2
FuncionTransSimpl = balred(transf,2);
[numsim,densim]= tfdata(FuncionTransSimpl);
xa = cell2mat(numsim);
ya = cell2mat(densim);
numtemp1 = num2str(xa);
dentemp1 = num2str(ya);
numerads = ["[", numtemp1,"]"];
denoms = ["[",dentemp1,"]"];
numesimp = join(numerads);
densimp = join(denoms);
%set_param('Simulacion_integrador/SegundoOrden','Numerator',numesimp);
%set_param('Simulacion_integrador/SegundoOrden','Denominator',densimp);

%Graficar funcion en guide
simout = sim('Simulacion_integrador');
t1 = Real.Time;
y1 = Real.Data;
y2 = Reducida.Data;
Rs = Entrada.Data; 


%Calculo del error en estado estacionario:
temporalerro = get(handles.identip,'Value');
if (temporalerro == 1)
    errE = 0;
else
    errE = ((abs(Rs(end)-y1(end)))/(Rs(end)))*100;
end


%Obtener caracteristicas de cada función


parametros = stepinfo(transf);
RT = parametros.RiseTime; %Tiempo de subida
ST = parametros.SettlingTime; % Tiempo de establecimiento
TP = parametros.PeakTime; % Tiempo pico
SE = parametros.Overshoot; % Sobre elongación
ConstP = parametros.Peak; % Constante de proporcionalidad


% Graficar valores para cada parametro cambiando los valores de k:
bool = get(handles.Opc1,'Value');
% Comprobación de si opción de graficar varias tf con diferentes k esta
% activa

if (bool == 1)
    valores = get(handles.ValoresK,'String');
    ks = str2num(valores);
    n = length(ks);
    RTm = zeros(n);
    STm = zeros(n);
    TPm = zeros(n);
    SEm = zeros(n);
    t = 1:1:n;
    constPm = zeros(n);
    axes(handles.Graficas);
    cla reset;
    for i=1:n
        nuevproc = (((Act1*pla1*ks(i)))/(1+Act1*pla1*sens1*ks(i)));
        step(nuevproc);
        paramN = stepinfo(nuevproc);
        hold on;
        RTm(i) = paramN.RiseTime;
        STm(i) = paramN.SettlingTime; % Tiempo de establecimiento
        TPm(i) = paramN.PeakTime; % Tiempo pico
        SEm(i) = paramN.Overshoot; % Sobre elongación
        constPm(i) = paramN.Peak;
    end
else
    t = 0.1:0.1:10;
    RTm = zeros(100);
    STm = zeros(100);
    TPm = zeros(100);
    SEm = zeros(100);
    constPm = zeros (100);
    axes(handles.Graficas);
    cla reset;
    plot(t1,y1,t1,y2,t1,Rs);
    hold on
    contad = 0;
    for i=0.1:0.1:10
    nuevK = i; 
    contad = contad+1;
    nuevproc = (((Act1*pla1*cont*nuevK))/(1+Act1*pla1*sens1*cont*nuevK));
    paramN = stepinfo(nuevproc);
    RTm(contad) = paramN.RiseTime;
    STm(contad) = paramN.SettlingTime; % Tiempo de establecimiento
    TPm(contad) = paramN.PeakTime; % Tiempo pico
    SEm(contad) = paramN.Overshoot; % Sobre elongación
    constPm(contad) = paramN.Peak;
    end
end
temporal = getframe(handles.Graficas);
Imagen = frame2im(temporal);
imwrite(Imagen, 'axis.png');


xlabel ('t','color','b');
ylabel('Amplitud','color','b');
axis on;
grid on;
hold on;

axes(handles.axeTR);
cla reset;
plot(t,RTm);
grid on;
hold on;

axes(handles.axeTS);
cla reset;

plot(t,STm);
grid on;
hold on;


axes(handles.axeTP);
cla reset;
plot(TPm);
grid on;
hold on;

axes(handles.axeMP);
cla reset;
plot(SEm);
grid on;
hold on;

axes(handles.axeConstP);
cla reset;
plot(constPm);
grid on;
hold on;

set(handles.FunComple,'string',evalc('transf'));
set(handles.Transreducida,'string',evalc('FuncionTransSimpl'));
%axes(handles.Resultados);
%cla;
%text('Interpreter','latex','string','A=','position',[.02 .9],'fontSize',8);
%text('Interpreter','latex','string',Apri,'position',[.15 .8],'fontSize',7);
set(handles.ValorA,'string',evalc('A'));
set(handles.ValorB,'string',evalc('B'));
set(handles.ValorC,'string',evalc('C'));
set(handles.ValorD,'string',evalc('D'));
% text('Interpreter','latex','string','B=','position',[.02 .7],'fontSize',8);
% text('Interpreter','latex','string',Bpri,'position',[.15 .6],'fontSize',7);
% text('Interpreter','latex','string','C= ','position',[.4 .8],'fontSize',8);
% text('Interpreter','latex','string',Cpri,'position',[.5 .8],'fontSize',7);
% text('Interpreter','latex','string','D= ','position',[.5 .6],'fontSize',8);
% text('Interpreter','latex','string',Dpri,'position',[.6 .6],'fontSize',7);

% me faltan estos valores.


% text('Interpreter','latex','string','Tr = ','position',[.03 .34],'fontSize',10);
%set(handles.Tr,'string',evalc('RT'));
% text('Interpreter','latex','string',RT,'position',[.15 .34],'fontSize',10);
% text('Interpreter','latex','string','ts = ','position',[.03 .28],'fontSize',10);
%set(handles.Ts,'string',evalc('ST'));
% text('Interpreter','latex','string',ST,'position',[.15 .28],'fontSize',10);

% text('Interpreter','latex','string','Tp = ','position',[.03 .22],'fontSize',10);
% text('Interpreter','latex','string',TP,'position',[.15 .22],'fontSize',10);
% text('Interpreter','latex','string','MP = ','position',[.03 .16],'fontSize',10);
% text('Interpreter','latex','string',SE,'position',[.2 .16],'fontSize',10);
% text('Interpreter','latex','string','ConsP =','position',[.03 .10],'fontSize',10);
% text('Interpreter','latex','string',ConstP,'position',[.25 .10],'fontSize',10);
% text('Interpreter','latex','string','Error estac = ','position',[.35 .50],'fontSize',10);
% text('Interpreter','latex','string',errE,'position',[.65 .50],'fontSize',10);
set(handles.Error,'string',evalc('errE'));
% axis off;
% hold on;


% Realizar diagrama de boode
axes(handles.Bode);
cla(handles.Bode);
%Calculamos G(s)*H(s) para calcular la FT de lazo abierto como se establece en la teoria, en este caso seria C(s)*A(s)*P(s)*S(s)
FTLA = cont*Act1*pla1*sens1
bode(FTLA);
hold on;
%Calculo de margen de fase (Mfase) y margen de ganancia(Mgan)
[Mgan,Mfase,Wgm,Wpm] = margin(FTLA);
%Calculamos la ganancia pico
%Primero determinemos los valores de la ganancia para cada frecuencia.
[mag,phase,w]=bode(FTLA);
% Ahora calculamos el valor maximo de la variable mag.
[Max,k] = max(mag);
% Pasamos el valor obtenido a db.
valorPico = mag2db(Max); % Ganancia pico del sistema.
frecpico = w(k); % Frecuencia de ganancia pico.
% Calculamos el ancho de banda del sistema.
% La describimos como la frecuencia en la que al ganancia cae 3 db. (Para los 3 controladores la ganancia maxima es de 0 db) 
n = 1;
while 20*log10(mag(n)) > 1
      n = n+1;
end
wc=w(n);
% Calculo de errores estacionarios:
%Generamos una variable simbolica w.
w = sym('w');
%Convertimos la funcion de lazo abierto a su forma matricial.
[numab,denab] = tfdata(FTLA);
%Obtenemos la funcion simbolica en funcion de w.
numsim = poly2sym(numab,w);
densim = poly2sym(denab,w);
Simbolic = numsim/densim;
%Realizamos los respectivos calculos de constantes de acuerdo a la teoria.
kp=double(limit(Simbolic,w,0));
if(isnan(kp))
    newnum = diff(numsim,w);
    newden = diff(densim,w);
    newsimbolic = newnum/newden;
    kp = double(limit(newsimbolic,w,0));
end
kv=double(limit(w*Simbolic,w,0));
if(isnan(kv))
    newnum = diff(numsim,w);
    newden = diff(densim,w);
    newsimbolic = newnum/newden;
    kv = double(limit(w*newsimbolic,w,0));
end
ka=double(limit((w^2)*Simbolic,w,0));
if(isnan(ka))
    newnum = diff(numsim,w);
    newden = diff(densim,w);
    newsimbolic = newnum/newden;
    ka = double(limit((w^2)*newsimbolic,w,0));
end
AnchoBanda= [0 wc]; %Ancho de banda.
set(handles.AnchoB,'String',['[' num2str(AnchoBanda) ']']);
set(handles.MargenFase,'String',Mfase);
set(handles.MargenGanancia,'String',mag2db(Mgan));
set(handles.GanPico,'String',valorPico);
set(handles.FreResonan,'String',frecpico);
set(handles.Kp,'String',kp);
set(handles.Kv,'String',kv);
set(handles.Ka,'String',ka);

%Realizamos calculos Si se digita varios valores de K
compvariosk = get(handles.ConfirmaFrec,'value');
if(compvariosk == 1)
    
    valoresKdif = get(handles.ValoresK,'String');
    Kdif = str2num(valoresKdif);
    m = length(Kdif);
    funciAbierta = zeros(m);
    axes(handles.Bode);
    for i=1:m
        if (comprobp == 1)
        % Controlador proporcional
        der = 0;
        int = 0;
        contn = tf(Kdif(i),1);
        end

        if (comprobi == 1)
        % Controlador Integral
        der = 0;
        int = str2num(Kp)/(str2num(T));
        contn = tf([Kdif(i)*str2num(T) Kdif(i)],[str2num(T) 0]);
        end

        if (comprobd == 1)
        % Controlador derivativo
        int = 0;
        der = str2num(Kp)*str2num(T);
        contn = tf ([Kdif(i)*str2num(T) 1],1);
        end
        funciAbierta = contn*Act1*pla1*sens1;
        bode(funciAbierta);
%         if(i==1)
%             str = funciAbierta;
%         end
%         if(i>1)
%             %str = str +","+funciAbierta;
%         end
    end
   
    
end

marg = 80;
rect = [-marg+30, -marg-30, 5*marg, 4*marg];
F = getframe(handles.Bode,rect);
Imagen2 = frame2im(F);
imwrite(Imagen2, 'bode.png');



function numA_Callback(hObject, eventdata, handles)
% hObject    handle to numA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numA as text
%        str2double(get(hObject,'String')) returns contents of numA as a double


% --- Executes during object creation, after setting all properties.
function numA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function denA_Callback(hObject, eventdata, handles)
% hObject    handle to denA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of denA as text
%        str2double(get(hObject,'String')) returns contents of denA as a double


% --- Executes during object creation, after setting all properties.
function denA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to denA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numP_Callback(hObject, eventdata, handles)
% hObject    handle to numP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numP as text
%        str2double(get(hObject,'String')) returns contents of numP as a double


% --- Executes during object creation, after setting all properties.
function numP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function denP_Callback(hObject, eventdata, handles)
% hObject    handle to denP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of denP as text
%        str2double(get(hObject,'String')) returns contents of denP as a double


% --- Executes during object creation, after setting all properties.
function denP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to denP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numS_Callback(hObject, eventdata, handles)
% hObject    handle to numS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numS as text
%        str2double(get(hObject,'String')) returns contents of numS as a double


% --- Executes during object creation, after setting all properties.
function numS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function denS_Callback(hObject, eventdata, handles)
% hObject    handle to denS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of denS as text
%        str2double(get(hObject,'String')) returns contents of denS as a double


% --- Executes during object creation, after setting all properties.
function denS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to denS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numact = get_param('Simulacion_integrador/actuador','numerator');
denact = get_param('Simulacion_integrador/actuador','denominator');
numpla = get_param('Simulacion_integrador/planta','numerator');
denpla = get_param('Simulacion_integrador/planta','denominator');
numsen = get_param('Simulacion_integrador/sensor','denominator');
densen = get_param('Simulacion_integrador/sensor','numerator');
kc = get_param('Simulacion_integrador/Controlador','P');
nump = str2num(numpla)/str2num(numsen);
set(handles.numA,'string',numact);
set(handles.denA,'string',denact);
set(handles.numP,'string',nump);
set(handles.denP,'string',denpla);
set(handles.numS,'string',numsen);
set(handles.denS,'string',densen);
set(handles.Kcontr,'string',kc);



function Kcontr_Callback(hObject, eventdata, handles)
% hObject    handle to Kcontr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kcontr as text
%        str2double(get(hObject,'String')) returns contents of Kcontr as a double


% --- Executes during object creation, after setting all properties.
function Kcontr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kcontr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in identip.
function identip_Callback(hObject, eventdata, handles)
% hObject    handle to identip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns identip contents as cell array
%        contents{get(hObject,'Value')} returns selected item from identip
se = get(handles.identip,'Value');
se1 = num2str(se);
set_param('Simulacion_integrador/selectortp','Value',se1);



% --- Executes during object creation, after setting all properties.
function identip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to identip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Opc1.
function Opc1_Callback(hObject, eventdata, handles)
% hObject    handle to Opc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Opc1



function ValoresK_Callback(hObject, eventdata, handles)
% hObject    handle to ValoresK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValoresK as text
%        str2double(get(hObject,'String')) returns contents of ValoresK as a double


% --- Executes during object creation, after setting all properties.
function ValoresK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValoresK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ControlProp.
function ControlProp_Callback(hObject, eventdata, handles)
% hObject    handle to ControlProp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ControlProp


% --- Executes on button press in Controlinte.
function Controlinte_Callback(hObject, eventdata, handles)
% hObject    handle to Controlinte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Controlinte


% --- Executes on button press in ControlDeriv.
function ControlDeriv_Callback(hObject, eventdata, handles)
% hObject    handle to ControlDeriv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ControlDeriv



function Tcontrolador_Callback(hObject, eventdata, handles)
% hObject    handle to Tcontrolador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tcontrolador as text
%        str2double(get(hObject,'String')) returns contents of Tcontrolador as a double


% --- Executes during object creation, after setting all properties.
function Tcontrolador_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tcontrolador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.RespuestaFrec,'visible','on');
set(handles.uipanel3,'visible','off');
set(handles.volver,'visible','on');
set(handles.pushbutton3,'visible','off');
set(handles.pushbutton7,'visible','off');
set(handles.uipanel4,'visible','off');
set(handles.uipanel10,'visible','on');
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.RespuestaFrec,'visible','off');
set(handles.uipanel3,'visible','off');  
set(handles.volver,'visible','on');
set(handles.pushbutton3,'visible','off');
set(handles.uipanel4,'visible','on');
set(handles.uipanel10,'visible','on');

% --- Executes on button press in volver.
function volver_Callback(hObject, eventdata, handles)
% hObject    handle to volver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.RespuestaFrec,'visible','off');
set(handles.uipanel3,'visible','on');
set(handles.volver,'visible','off');
set(handles.pushbutton3,'visible','on');
set(handles.pushbutton7,'visible','on');
set(handles.uipanel4,'visible','on');
set(handles.uipanel10,'visible','off');


% --- Executes on button press in ConfirmaFrec.
function ConfirmaFrec_Callback(hObject, eventdata, handles)
% hObject    handle to ConfirmaFrec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ConfirmaFrec


% --- Executes on selection change in MenuK.
function MenuK_Callback(hObject, eventdata, handles)
% hObject    handle to MenuK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MenuK contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MenuK


% --- Executes during object creation, after setting all properties.
function MenuK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MenuK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GraficaDeResonancias.
function GraficaDeResonancias_Callback(hObject, eventdata, handles)
% hObject    handle to GraficaDeResonancias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GraficarFrecK.
function GraficarFrecK_Callback(hObject, eventdata, handles)
% hObject    handle to GraficarFrecK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Realizemos los calculos para k, en caso de que tengamos un controlador
%proporcional, y para K y T en caso de un controlador
%derivativo-integrador.
%Realizamos las verificaciones
global Act1 sens1 pla1;
comprobp = get(handles.ControlProp,'Value');
comprobi = get(handles.Controlinte,'Value');
comprobd = get(handles.ControlDeriv,'Value');

sincontro = Act1*sens1*pla1;
[numk,denk] = tfdata(sincontro);

if(comprobp == 1)
   conta = 1;
   Gm = zeros(39);
   Pm = zeros(39);
   Wgm = zeros(39);
   Wpm = zeros(39);
   wr = zeros(39);
   pico = zeros(39);
   Wc = zeros(39);
   wgrafica = 1:0.5:20;
   KP = zeros(39);
   KV = zeros(39);
   KA = zeros(39);
   for i=1:0.5:20
       funcAbi = i*sincontro;
       [num,den] = tfdata(funcAbi);
       [gm,pm,wgm,wpm] = margin(funcAbi);
       Gm(conta) = gm;
       Pm(conta) = pm;
       Wgm(conta) = wgm;
       Wpm(conta) = wpm;
       [mag,phase,w]=bode(num,den);
       [mp,k]=max(mag);
       pico(conta)=mag2db(mp);
       maxi = pico(conta);
       wr(conta)=w(k);
       n = 1;
       while 20*log10(mag(n))>maxi-3
            n = n+1;
       end
       Wc(conta)=w(n);
       %Calculo de constantes de error estacionario.
        y=sym('y');
       [numab1,denab1] = tfdata(funcAbi);
        %Obtenemos la funcion simbolica en funcion de w.
        numaabisym = poly2sym(numab1,y);
        densabisym = poly2sym(denab1,y);
        AbiSimbolic = numaabisym/densabisym;
        %Realizamos los respectivos calculos de constantes de acuerdo a la teoria.
        kp=double(limit(AbiSimbolic,y,0));
        if(isnan(kp))
            newnum = diff(numaabisym,y);
            newden = diff(densabisym,y);
            newsimbolic = newnum/newden;
            kp = double(limit(newsimbolic,y,0));
        end
        KP(conta) = kp;
        kv=double(limit(y*AbiSimbolic,y,0));
        if(isnan(kv))
            newnum = diff(numaabisym,y);
            newden = diff(densabisym,y);
            newsimbolic = newnum/newden;
            kv = double(limit(y*newsimbolic,y,0));
        end
        KV(conta) = kv;
        ka=double(limit((y^2)*AbiSimbolic,y,0));
            if(isnan(ka))
                newnum = diff(numaabisym,y);
                newden = diff(densabisym,y);
                newsimbolic = newnum/newden;
                ka = double(limit((y^2)*newsimbolic,y,0));
            end
       KA(conta) = ka;
       %Aca termina calculo de error estacionario
       
       conta = conta+1;
   end
   %Prueba de seleccion
   grafic = get(handles.popupmenu3,'Value');
   axes(handles.GraficasK);
   cla reset;
   if(grafic == 8) %Este es frecuencia de resonancia.
      plot(wgrafica,wr); 
   end
   if(grafic == 2)
       plot(wgrafica,Wc);
   end
   if(grafic == 3)
       plot(wgrafica,KP);
   end
   if(grafic == 4)
       plot(wgrafica,KV);
   end
   if(grafic == 5)
       plot(wgrafica,KA);
   end
   if(grafic == 6)
       plot(wgrafica,Pm);
   end
   if(grafic == 1)
       plot(wgrafica,Gm);
   end
   if(grafic == 7)
       plot(wgrafica,pico);
   end
end
if(comprobi == 1)
   % Realizamos calculos para graficas 3D.
   T = 1:0.5:20;
   Kpro = 1:0.5:20;
   Gm = zeros(39);
   Pm = zeros(39);
   Wgm = zeros(39);
   Wpm = zeros(39);
   wr = zeros(39);
   pico = zeros(39);
   Wc = zeros(39);
   wgrafica = 1:0.5:20;
   KP = zeros(39);
   KV = zeros(39);
   KA = zeros(39);
   for i=1:1:39 
       %tf([str2num(Kp)*str2num(T) str2num(Kp)],[str2num(T) 0])
       control = tf([Kpro(i)*T(i) Kpro(i)],[T(i) 0]);
       funcAbi = control*sincontro;
       [num,den] = tfdata(funcAbi);
       [gm,pm,wgm,wpm] = margin(funcAbi);
       Gm(i) = gm;
       Pm(i) = pm;
       Wgm(i) = wgm;
       Wpm(i) = wpm;
       [mag,phase,w]=bode(num,den);
       [mp,k]=max(mag);
       pico(i)=mag2db(mp);
       maxi = pico(i);
       wr(i)=w(k);
       n = 1;
       while 20*log10(mag(n))>maxi-3
            n = n+1;
       end
       Wc(i)=w(n);
       %Calculo de constantes de error estacionario.
        y=sym('y');
       [numab1,denab1] = tfdata(funcAbi);
        %Obtenemos la funcion simbolica en funcion de w.
        numaabisym = poly2sym(numab1,y);
        densabisym = poly2sym(denab1,y);
        AbiSimbolic = numaabisym/densabisym;
        %Realizamos los respectivos calculos de constantes de acuerdo a la teoria.
        kp=double(limit(AbiSimbolic,y,0));
        if(isnan(kp))
            newnum = diff(numaabisym,y);
            newden = diff(densabisym,y);
            newsimbolic = newnum/newden;
            kp = double(limit(newsimbolic,y,0));
        end
        KP(i) = kp;
        kv=double(limit(y*AbiSimbolic,y,0));
        if(isnan(kv))
            newnum = diff(numaabisym,y);
            newden = diff(densabisym,y);
            newsimbolic = newnum/newden;
            kv = double(limit(y*newsimbolic,y,0));
        end
        KV(i) = kv;
        ka=double(limit((y^2)*AbiSimbolic,y,0));
            if(isnan(ka))
                newnum = diff(numaabisym,y);
                newden = diff(densabisym,y);
                newsimbolic = newnum/newden;
                ka = double(limit((y^2)*newsimbolic,y,0));
            end
       KA(i) = ka;
       %Aca termina calculo de error estacionario
   end
      %Procedemos a realizar las respectivas graficas en 3D.
       grafic = get(handles.popupmenu3,'Value');
   axes(handles.GraficasK);
   cla reset;
   if(grafic == 8) %Este es frecuencia de resonancia.
      comet3(Kpro,wr,T); 
   end
   if(grafic == 2)
       comet3(Kpro,Wc,T);
   end
   if(grafic == 3)
       comet3(Kpro,KP,T);
   end
   if(grafic == 4)
       comet3(Kpro,KV,T);
   end
   if(grafic == 5)
       comet3(Kpro,KA,T);
   end
   if(grafic == 6)
       comet3(Kpro,Pm,T);
   end
   if(grafic == 1)
       comet3(Kpro,Gm,T);
   end
   if(grafic == 7)
       comet3(Kpro,pico,T);
   end
end
if(comprobd == 1)
    % Realizamos calculos para graficas 3D.
   T = 1:0.5:20;
   Kpro = 1:0.5:20;
   Gm = zeros(39);
   Pm = zeros(39);
   Wgm = zeros(39);
   Wpm = zeros(39);
   wr = zeros(39);
   pico = zeros(39);
   Wc = zeros(39);
   wgrafica = 1:0.5:20;
   KP = zeros(39);
   KV = zeros(39);
   KA = zeros(39);
   for i=1:1:39 
       %tf([str2num(Kp)*str2num(T) str2num(Kp)],[str2num(T) 0])
       control = tf ([(Kpro(i)*T(i)) 1],1);
       funcAbi = control*sincontro;
       [num,den] = tfdata(funcAbi);
       [gm,pm,wgm,wpm] = margin(funcAbi);
       Gm(i) = gm;
       Pm(i) = pm;
       Wgm(i) = wgm;
       Wpm(i) = wpm;
       [mag,phase,w]=bode(num,den);
       [mp,k]=max(mag);
       pico(i)=mag2db(mp);
       maxi = pico(i);
       wr(i)=w(k);
       n = 1;
       while 20*log10(mag(n))>maxi-3
            n = n+1;
       end
       Wc(i)=w(n);
       %Calculo de constantes de error estacionario.
        y=sym('y');
       [numab1,denab1] = tfdata(funcAbi);
        %Obtenemos la funcion simbolica en funcion de w.
        numaabisym = poly2sym(numab1,y);
        densabisym = poly2sym(denab1,y);
        AbiSimbolic = numaabisym/densabisym;
        %Realizamos los respectivos calculos de constantes de acuerdo a la teoria.
        kp=double(limit(AbiSimbolic,y,0));
        if(isnan(kp))
            newnum = diff(numaabisym,y);
            newden = diff(densabisym,y);
            newsimbolic = newnum/newden;
            kp = double(limit(newsimbolic,y,0));
        end
        KP(i) = kp;
        kv=double(limit(y*AbiSimbolic,y,0));
        if(isnan(kv))
            newnum = diff(numaabisym,y);
            newden = diff(densabisym,y);
            newsimbolic = newnum/newden;
            kv = double(limit(y*newsimbolic,y,0));
        end
        KV(i) = kv;
        ka=double(limit((y^2)*AbiSimbolic,y,0));
            if(isnan(ka))
                newnum = diff(numaabisym,y);
                newden = diff(densabisym,y);
                newsimbolic = newnum/newden;
                ka = double(limit((y^2)*newsimbolic,y,0));
            end
       KA(i) = ka;
       %Aca termina calculo de error estacionario
   end
      %Procedemos a realizar las respectivas graficas en 3D.
       grafic = get(handles.popupmenu3,'Value');
   axes(handles.GraficasK);
   cla reset;
   if(grafic == 8) %Este es frecuencia de resonancia.
      comet3(Kpro,wr,T); 
   end
   if(grafic == 2)
       comet3(Kpro,Wc,T);
   end
   if(grafic == 3)
       comet3(Kpro,KP,T);
   end
   if(grafic == 4)
       comet3(Kpro,KV,T);
   end
   if(grafic == 5)
       comet3(Kpro,KA,T);
   end
   if(grafic == 6)
       comet3(Kpro,Pm,T);
   end
   if(grafic == 1)
       comet3(Kpro,Gm,T);
   end
   if(grafic == 7)
       comet3(Kpro,pico,T);
   end
end


% --- Executes on button press in intdev.
function intdev_Callback(hObject, eventdata, handles)
% hObject    handle to intdev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of intdev


% --- Executes on button press in comde.
function comde_Callback(hObject, eventdata, handles)
% hObject    handle to comde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of comde


% --- Executes on button press in comret.
function comret_Callback(hObject, eventdata, handles)
% hObject    handle to comret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of comret


% --- Executes on button press in aderet.
function aderet_Callback(hObject, eventdata, handles)
% hObject    handle to aderet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of aderet


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
