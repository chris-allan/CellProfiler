function SaveImageAs(handles)

% Help for the Save Image As tool:
% Category: Image Tools
%
% Any image that is displayed can be saved to the hard drive in any
% standard image file format using this tool.  Type 'imformats' in the
% command window to see a list of acceptable file formats. To
% routinely save images that result from running an image analysis
% pipeline, use the SaveImages module.
%
% See also <nothing relevant>.

% CellProfiler is distributed under the GNU General Public License.
% See the accompanying file LICENSE for details.
%
% Developed by the Whitehead Institute for Biomedical Research.
% Copyright 2003,2004,2005.
%
% Authors:
%   Anne Carpenter
%   Thouis Jones
%   In Han Kang
%   Ola Friman
%   Steve Lowe
%   Joo Han Chang
%   Colin Clarke
%   Mike Lamprecht
%   Susan Ma
%   Wyman Li
%
% Website: http://www.cellprofiler.org
%
% $Revision$

Image = getimage(gca);

ScreenSize = get(0,'ScreenSize');
ScreenWidth = ScreenSize(3);
ScreenHeight = ScreenSize(4);
GUIwidth = 410;
GUIheight = 310;
Left = 0.5*(ScreenWidth - GUIwidth);
Bottom = 0.5*(ScreenHeight - GUIheight);

MainWinPos = [Left Bottom GUIwidth GUIheight];

userData.Application = 'CellProfiler';
userData.MyHandles=handles;
userData.Image=Image;
SaveImageHandle = figure(...
    'Units','pixels',...
    'Color',[.7 .7 .9],...
    'DockControls','off',...
    'MenuBar','none',...
    'Name','Save Image',...
    'NumberTitle','off',...
    'Position',MainWinPos,...
    'Resize','off',...
    'HandleVisibility','on',...
    'Tag','SaveImageHandle',...
    'UserData',userData);

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[.7 .7 .9],...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'HorizontalAlignment','left',...
    'Position',[0.05 0.85 0.7 0.14],...
    'String',['   What would you like to call the file?    ' ;'(file extension will be added automatically)'],...
    'Style','text');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[1 1 1],...
    'Callback','string = get(findobj(''Tag'',''FileNameEditBox''),''String'');if(~ischar(string)||isempty(string)); warndlg(''That is not a valid entry'');end;clear string',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.05 0.79 0.7 0.07],...
    'String','',...
    'Style','edit',...
    'Tag','FileNameEditBox');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[.7 .7 .9],...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'HorizontalAlignment','left',...
    'Position',[0.05 0.69 0.6 0.07],...
    'String','Where would you like to save it?',...
    'Style','text');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[1 1 1],...
    'Callback','string = get(findobj(''Tag'',''FileDirEditBox''),''String'');if(~isdir(string)); warndlg(''That is not a valid entry'');end;clear string',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.05 0.63 0.7 0.07],...
    'String',handles.Current.DefaultOutputDirectory,...
    'Style','edit',...
    'Tag','FileDirEditBox');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'Callback','UserData = get(findobj(''Tag'',''SaveImageHandle''),''UserData'');directory = uigetdir(get(findobj(''Tag'',''FileDirEditBox''),''String'')); if directory ~= 0, set(findobj(''Tag'',''FileDirEditBox''),''String'',directory);end,pause(.1);figure(findobj(''Tag'',''SaveImageHandle''));clear UserData directory',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.83 0.63 0.15 0.07],...
    'String','Browse...',...
    'Tag','BrowseButton',...
    'BackgroundColor',[.7 .7 .9]);

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[.7 .7 .9],...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'HorizontalAlignment','left',...
    'Position',[0.05 0.53 0.7 0.07],...
    'String','Which file format would you like to use?',...
    'Style','text');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[1 1 1],...
    'Callback','',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.75 0.53 0.13 0.07],...
    'String',CPimread(),...
    'Style','popupmenu',...
    'Tag','ExtensionPopupMenu');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'Callback','CPtextdisplaybox(sprintf(''Some image formats do not support saving at a bit depth of 12 or 16. \n\n For grayscale images this can be 1, 2, 4, 8, or 16. \n For grayscale images with an alpha channel this can be 8 or 16.\n For indexed images this can be 1, 2, 4, or 8.\n For truecolor images with or without an alpha channel this can be 8 or 16.''),''Bit Depth Help'');',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[.01 .45 .03 .06],...
    'String','?',...
    'Tag','BitDepthHelpButton',...
    'BackgroundColor',[.7 .7 .9]);

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[.7 .7 .9],...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'HorizontalAlignment','left',...
    'Position',[0.05 0.43 0.7 0.07],...
    'String','At what bit depth would you like to save the file?',...
    'Style','text');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[1 1 1],...
    'Callback','',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.75 0.43 0.13 0.07],...
    'String',{'8' '12' '16'},...
    'Style','popupmenu',...
    'Tag','NumberBitsPopupMenu');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[.7 .7 .9],...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'HorizontalAlignment','left',...
    'Position',[0.05 0.33 0.6 0.07],...
    'String','Would you like to rescale?',...
    'Style','text');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[1 1 1],...
    'Callback','',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.75 0.33 0.13 0.07],...
    'String',{'yes' 'no'},...
    'Style','popupmenu',...
    'Tag','RescalePopupMenu',...
    'Value',2);

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[.7 .7 .9],...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'HorizontalAlignment','left',...
    'Position',[0.05 0.23 0.7 0.07],...
    'String','For grayscale images, specify the colormap to use',...
    'Style','text');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[1 1 1],...
    'Callback','',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.75 0.23 0.13 0.07],...
    'String',{'autumn' 'bone' 'colorcube' 'cool' 'copper' 'flag' 'gray' 'hot' 'hsv' 'jet' 'lines' 'pink' 'prism' 'spring' 'summer' 'white' 'winter'},...
    'Style','popupmenu',...
    'Tag','ColormapPopupMenu',...
    'Value',7);

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[.7 .7 .9],...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'HorizontalAlignment','left',...
    'Position',[0.05 0.13 0.7 0.07],...
    'String','Enter any optional parameters here',...
    'Style','text');

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'BackgroundColor',[1 1 1],...
    'Callback','',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.75 0.13 0.13 0.07],...
    'String','/',...
    'Style','edit',...
    'Tag','OptionsTag');

SaveFunction = ...
    ['filename = get(findobj(''Tag'',''FileNameEditBox''),''String'');'...
    'dirname = get(findobj(''Tag'',''FileDirEditBox''),''String'');'...
    'if isempty(filename)||~ischar(filename),'...
    'warndlg(''The filename is not valid'');'...
    'clear filename dirname;'...
    'elseif ~isdir(dirname),'...
    'warndlg(''The directory is not valid'');'...
    'clear filename dirname;'...
    'else,'...
    '[ignoreDir filename ignoreext] = fileparts(filename);'...
    'if ~isempty(ignoreDir) && ~strcmp(ignoreDir,dirname)&&isdir(ignoreDir),'...
    'warndlg([''The file path in the name, '' ignoreDir '' is not the same as the specified path, '' dirname ''.  So, we are using '' ignoreDir]);'...
    'dirname = ignoreDir;'...
    'end,'...
    'tempHandles.Current.CurrentModuleNumber = ''01'';'...
    'tempHandles.Settings.VariableValues{1,1}=''OrigBlue'';'...
    'tempHandles.Settings.VariableValues{1,2}=''OrigBlue'';'...
    'tempHandles.Settings.VariableValues{1,3}=[''\'' filename];'...
    'ListExtensions = get(findobj(''Tag'',''ExtensionPopupMenu''),''String'');'...
    'ext=ListExtensions(get(findobj(''Tag'',''ExtensionPopupMenu''),''Value''));'...
    'if ~isempty(ignoreext)&&~strcmp(ignoreext,ext),'...
    'warndlg([''The extension in the name, '' ignoreext '' is not the same as the extension that you entered, '' ext ''.  So, we are using '' tempext]);'...
    'ext = tempext;'...
    'end,'...
    'tempHandles.Settings.VariableValues{1,4}=ext;'...
    'tempHandles.Settings.VariableValues{1,5}=dirname;'...
    'BitDepths = get(findobj(''Tag'',''NumberBitsPopupMenu''),''String'');'...
    'tempHandles.Settings.VariableValues{1,6}=BitDepths(get(findobj(''Tag'',''NumberBitsPopupMenu''),''Value''));'...
    'tempHandles.Settings.VariableValues{1,7}=''Y'';'...
    'tempHandles.Settings.VariableValues{1,8}=''E'';'...
    'tempHandles.Settings.VariableValues{1,9}=''A'';'...
    'tempHandles.Settings.VariableValues{1,10}=''L'';'...
    'RescaleOptions = get(findobj(''Tag'',''RescalePopupMenu''),''String'');'...
    'tempHandles.Settings.VariableValues{1,11}=RescaleOptions(get(findobj(''Tag'',''RescalePopupMenu''),''Value''));'...
    'ColormapOptions = get(findobj(''Tag'',''ColormapPopupMenu''),''String'');'...
    'tempHandles.Settings.VariableValues{1,12}=ColormapOptions(get(findobj(''Tag'',''ColormapPopupMenu''),''Value''));'...
    'tempHandles.Settings.VariableValues{1,13}=''Yes'';'...
    'OptionValues = get(findobj(''Tag'',''OptionsTag''),''String'');'...
    'tempHandles.Settings.VariableValues{1,14}=OptionValues;'...
    'tempHandles.Current.CurrentModuleNumber=''01'';'...
    'tempHandles.Current.SetBeingAnalyzed=1;'...
    'tempHandles.Current.StartingImageSet=0;'...
    'tempHandles.Current.NumberImageSets=1;'...
    'UserData = get(findobj(''tag'',''SaveImageHandle''),''UserData'');'...
    'tempHandles.Pipeline.OrigBlue=UserData.Image;'...
    'try handles = guidata(findobj(''Tag'',''figure1''));'...
    'tempHandles.Current.DefaultImageDirectory = handles.Current.DefaultImageDirectory;'...
    'catch tempHandles.Current.DefaultImageDirectory = ''C:\Anything'';end;'...
    'tempHandles.Pipeline.FileListOrigBlue{1}{1}=filename;'...
    'tempHandles.Pipeline.FilenameOrigBlue = {filename};'...
    'try,'...
    'SaveImages(tempHandles);'...
    'try CPmsgbox(''The picture was sucessfully saved.'');'...
    'catch msgbox(''The picture was sucessfully saved.'');'...
    'end,'...
    'catch,'...
    'try CPmsgbox(''For some reason, the picure was unable to save.'');'...
    'catch msgbox(''For some reason, the picure was unable to save.'');'...
    'end,'...
    'end,'...
    'delete(findobj(''Tag'',''SaveImageHandle''));'...
    'clear filename dirname ListExtensions BitDepths RescaleOptions ColormapOptions tempHandles ListExtensions ext BitDepths RescaleOptions ColormapOptions UserData handles ignoreDir ignoreext;'...
    'end'];

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'Callback',SaveFunction,...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.68 0.03 0.18 0.07],...
    'String','Save',...
    'Tag','SaveImageButton',...
    'BackgroundColor',[.7 .7 .9]);

uicontrol(...
    'Parent',SaveImageHandle,...
    'Units','normalized',...
    'Callback','delete(findobj(''Tag'',''SaveImageHandle''));',...
    'FontName','Times',...
    'FontSize',handles.Preferences.FontSize,...
    'FontWeight','bold',...
    'Position',[0.14 0.03 0.18 0.07],...
    'String','Cancel',...
    'Tag','CancelSaveImageButton',...
    'BackgroundColor',[.7 .7 .9]);

return;

if isempty(Answers) ~= 1
    FileName = char(Answers{1});
    Extension = char(Answers{2});
    SixteenBit = char(Answers{3});
    if strcmp(SixteenBit,'yes') == 1
        Image = uint16(65535*Image);
    end
    CompleteFileName = [FileName,'.',Extension];
    %%% Checks whether the specified file name will overwrite an
    %%% existing file.
    ProposedFileAndPathname = fullfile(handles.Current.DefaultOutputDirectory,CompleteFileName);
    OutputFileOverwrite = exist(ProposedFileAndPathname,'file');
    [ignore,Attributes] = fileattrib(ProposedFileAndPathname);
    if Attributes.UserWrite == 0
        error(['You do not have permission to write ',ProposedFileAndPathname,'!']);
    else
        if OutputFileOverwrite ~= 0
            Answer = CPquestdlg(['A file with the name ', CompleteFileName, ' already exists at ', handles.Current.DefaultOutputDirectory,'. Do you want to overwrite it?'],'Confirm file overwrite','Yes','No','No');
            if strcmp(Answer,'Yes') == 1;
                if strcmpi(Extension,'mat')
                    save(ProposedFileAndPathname,'Image');
                else
                    imwrite(Image, ProposedFileAndPathname, Extension)
                end
                CPmsgbox(['The file ', CompleteFileName, ' has been saved to the default output directory.']);
            end
        else
            if strcmpi(Extension,'mat')
                save(ProposedFileAndPathname,'Image');
            else
                imwrite(Image, ProposedFileAndPathname, Extension)
            end
            CPmsgbox(['The file ', CompleteFileName, ' has been saved to the default output directory.']);
        end
    end
end