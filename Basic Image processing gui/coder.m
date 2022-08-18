function varargout = coder(varargin)
% CODER MATLAB code for coder.fig
%      CODER, by itself, creates a new CODER or raises the existing
%      singleton*.
%
%      H = CODER returns the handle to a new CODER or the handle to
%      the existing singleton*.
%
%      CODER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CODER.M with the given input arguments.
%
%      CODER('Property','Value',...) creates a new CODER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coder

% Last Modified by GUIDE v2.5 11-Jul-2022 22:50:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coder_OpeningFcn, ...
                   'gui_OutputFcn',  @coder_OutputFcn, ...
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


% --- Executes just before coder is made visible.
function coder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coder (see VARARGIN)

% Choose default command line output for coder
handles.fileLoaded = 0;
handles.fileLoaded2 = 0;
set(handles.axes1,'Visible','off');
set(handles.axes2,'Visible','off');
set(handles.axes6,'Visible','off');
set(handles.axes5,'Visible','off');
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes coder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = coder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%# --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileLoaded==1)
        
    R = double(handles.RGB(:,:,1));
    G = double(handles.RGB(:,:,2));
    B = double(handles.RGB(:,:,3));
        
    handles.RGB2(:,:,1) = 256 - R;
    handles.RGB2(:,:,2) = 256 - G;
    handles.RGB2(:,:,3) = 256 - B;
    
    axes(handles.axes2); imshow(handles.RGB2);
    handles.fileLoaded2 = 1;
    handles = updateHistograms(handles);
    guidata(hObject, handles);    
else
    h = msgbox('No primary file has been loaded!','Error','error');
end



%# --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileLoaded==1)

    [M,N,ttt] = size(handles.RGB);

        M1 = 3/100;
        M2 = 3/100;

    M1 = round(M1 * M);
    M2 = round(M2 * N);

    w = waitbar(0, 'Median filtering ... Please wait ...');
    handles.RGB2(:,:,1) = medfilt2(handles.RGB(:,:,1),[M1 M2]);
    waitbar(1/3, w);
    handles.RGB2(:,:,2) = medfilt2(handles.RGB(:,:,2),[M1 M2]);
    waitbar(2/3, w);
    handles.RGB2(:,:,3) = medfilt2(handles.RGB(:,:,3),[M1 M2]);
    close(w);
    axes(handles.axes2); imshow(handles.RGB2);
    handles.fileLoaded2 = 1;
    handles = updateHistograms(handles);
    guidata(hObject, handles);
else
    h = msgbox('No primary file has been loaded!','Error','error');
end



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




%# --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to LoadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile({'*.*'},'Load Image File');

if (FileName==0) % cancel pressed
    return;
end


handles.fullPath = [PathName FileName];
[a, b, Ext] = fileparts(FileName);
availableExt = {'.bmp','.jpg','.jpeg','.tiff','.png','.gif'};
FOUND = 0;
for (i=1:length(availableExt))
    if (strcmpi(Ext, availableExt{i}))
        FOUND=1;
        break;
    end
end

if (FOUND==0)
    h = msgbox('File type not supported!','Error','error');
    return;
end
RGB = imread(handles.fullPath);

handles.RGB = RGB;
handles.RGB2 = RGB;
handles.fileLoaded = 1;
handles.fileLoaded2 = 0;

set(handles.axes1,'Visible','off'); set(handles.axes2,'Visible','off');
set(handles.axes6,'Visible','off'); set(handles.axes5,'Visible','off');
axes(handles.axes5); cla;
axes(handles.axes1); cla; imshow(RGB);
axes(handles.axes2); cla;
handles = updateHistograms(handles);

guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%#--- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileLoaded==1)
    Gray = rgb2gray(handles.RGB);
    handles.RGB2(:,:,1) = Gray;
    handles.RGB2(:,:,2) = Gray;
    handles.RGB2(:,:,3) = Gray;
    axes(handles.axes2); imshow(handles.RGB2);
    handles.fileLoaded2 = 1;
    guidata(hObject, handles);
else
    h = msgbox('No primary file has been loaded!','Error','error');
end

function handlesNew = updateHistograms(handles)
handlesNew = handles;
if (handles.fileLoaded == 1)
    %set(handles.textHist1, 'Visible', 'on');
    axes(handlesNew.axes6); 
    cla;
    ImageData1 = reshape(handlesNew.RGB(:,:,1), [size(handlesNew.RGB, 1) * size(handlesNew.RGB, 2) 1]);
    ImageData2 = reshape(handlesNew.RGB(:,:,2), [size(handlesNew.RGB, 1) * size(handlesNew.RGB, 2) 1]);
    ImageData3 = reshape(handlesNew.RGB(:,:,3), [size(handlesNew.RGB, 1) * size(handlesNew.RGB, 2) 1]);
    [H1, X1] = hist(ImageData1, 1:5:256);
    [H2, X2] = hist(ImageData2, 1:5:256);
    [H3, X3] = hist(ImageData3, 1:5:256);
    hold on;
    plot(X1, H1, 'r');
    plot(X2, H2, 'g');
    plot(X3, H3, 'b');    
    axis([0 256 0 max([H1 H2 H3])]);
end
if (handlesNew.fileLoaded2 == 1)
    %set(handles.text, 'Visible', 'on');
    axes(handlesNew.axes5); 
    cla;
    ImageData1 = reshape(handlesNew.RGB2(:,:,1), [size(handlesNew.RGB2, 1) * size(handlesNew.RGB2, 2) 1]);
    ImageData2 = reshape(handlesNew.RGB2(:,:,2), [size(handlesNew.RGB2, 1) * size(handlesNew.RGB2, 2) 1]);
    ImageData3 = reshape(handlesNew.RGB2(:,:,3), [size(handlesNew.RGB2, 1) * size(handlesNew.RGB2, 2) 1]);
    [H1, X1] = hist(ImageData1, 1:5:256);
    [H2, X2] = hist(ImageData2, 1:5:256);
    [H3, X3] = hist(ImageData3, 1:5:256);
    hold on;
    plot(X1, H1, 'r');
    plot(X2, H2, 'g');
    plot(X3, H3, 'b');    
    axis([0 256 0 max([H1 H2 H3])]);    
end


%#
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileLoaded==1)

    [M,N,ttt] = size(handles.RGB);

        prompt = {'Enter m Row Factor :','Enter n Column Factor :'};
        dlg_title = 'Enter Parameters:';
        num_lines = 1;
        def = {'0','0'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        if (isempty(answer))
            return;
        end

        M1 = str2num(answer{1})/100;
        M2 = str2num(answer{2})/100;
        M1 = round(M1 * M);
        M2 = round(M2 * N);

    w = waitbar(0, 'filtering ... Please wait ...');
    handles.RGB2(:,:,1) = medfilt2(handles.RGB(:,:,1),[M1 M2]);
    waitbar(1/3, w);
    handles.RGB2(:,:,2) = medfilt2(handles.RGB(:,:,2),[M1 M2]);
    waitbar(2/3, w);
    handles.RGB2(:,:,3) = medfilt2(handles.RGB(:,:,3),[M1 M2]);
    close(w);
    axes(handles.axes2); imshow(handles.RGB2);
    handles.fileLoaded2 = 1;
    handles = updateHistograms(handles);

    guidata(hObject, handles);
else
    h = msgbox('No primary file has been loaded!','Error','error');
end
