/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	config.toolbarGroups = [
	                		{ name: 'clipboard',   groups: [ 'clipboard', 'undo','list', 'indent', 'blocks', 'align' ] },
	                		{ name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
	                		{ name: 'links' },
	                		{ name: 'forms' },
	                		{ name: 'tools' },
	                		{ name: 'document',	   groups: [ 'mode', 'document', 'doctools','cleanup','basicstyles','-','paragraph','about'  ] },
	                		{ name: 'others' },
	                		'/',
	                	  { name: 'insert' },
	                		//{ name: 'styles' },
	                		//{ name: 'colors' },
	                		{ name: 'about' }
	                	];

	                	// Remove some buttons, provided by the standard plugins, which we don't
	                	// need to have in the Standard(s) toolbar.
	                	config.removeButtons = 'Underline,Subscript,Superscript,SpecialChar';
	                	config.extraPlugins = 'jme';
	config.language = 'zh-cn';
	// config.uiColor = '#AADC6E';

    config.toolbar_Minimal = [
        { items: [ 'Bold', 'Italic', 'Underline', 'TextColor', '-', 'RemoveFormat', 'PasteText', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink', '-', 'Source', 'uploadpictures', 'CodeSnippet', 'jme'] }
    ];

    config.toolbar_editVip = [
        { items: [ 'Bold', 'Italic', 'Underline', 'TextColor', '-', 'RemoveFormat', 'PasteText', '-', 'NumberedList', 'BulletedList'] }
    ];

    config.toolbar_Simple = [
        { items: [ 'Bold', 'Italic', 'Underline', 'TextColor', '-', 'RemoveFormat', 'PasteText', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink', 'uploadpictures', 'CodeSnippet', '-', 'Source'] }
    ];

    config.toolbar_Thread = [
        { items: [ 'Bold', 'Italic', 'Underline', 'TextColor', '-', 'RemoveFormat', 'PasteText', '-', 'Smiley', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink', 'uploadpictures', 'CodeSnippet', '-', 'Source', 'kityformula'] }
    ];

    config.toolbar_Question = [
        { items: [ 'Bold', 'Italic', 'Underline', 'TextColor', '-', 'RemoveFormat', 'PasteText', '-', 'QuestionBlank', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink', '-', 'Source', 'uploadpictures', 'CodeSnippet', 'kityformula'] }
    ];

    config.toolbar_Group = [
        { items: [ 'Bold', 'Italic', 'Underline', 'TextColor', '-', 'RemoveFormat', 'PasteText', '-', 'Smiley', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink', 'uploadpictures', 'CodeSnippet', '-', 'Source'] }
    ];

    config.toolbar_Detail = [
        { items: [ 'FontSize', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
        { items: [ 'Bold', 'Italic', 'Underline', 'TextColor', '-', 'RemoveFormat', 'PasteText', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink', 'uploadpictures', 'CodeSnippet', '-', 'Source'] }
    ];

    config.toolbar_Full = [
        { items: [ 'Bold', 'Italic', 'Underline', 'Strike', '-', 'RemoveFormat', 'Format' ] },
        { items: [ 'Link', 'Unlink' ] },
        { items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
        { items: [ 'FontSize', 'TextColor', 'BGColor' ] },
        { items: [ 'uploadpictures', 'CodeSnippet', 'Flash', 'Table', 'HorizontalRule', 'SpecialChar', 'Iframe', 'kityformula' ] },
        { items: [ 'PasteText', 'PasteFromWord'] },
        { items: [ 'Find', '-', 'Source', '-', 'Maximize'] }
    ];

    config.toolbar_Admin = [
        { items: [ 'Bold', 'Italic', 'Underline', 'Strike', '-', 'RemoveFormat', 'Format' ] },
        { items: [ 'Link', 'Unlink' ] },
        { items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
        { items: [ 'FontSize', 'TextColor', 'BGColor' ] },
        { items: [ 'uploadpictures', 'CodeSnippet', 'Flash', 'Table', 'HorizontalRule', 'SpecialChar', 'Iframe' ] },
        { items: [ 'PasteText', 'PasteFromWord'] },
        { items: [ 'Find', '-', 'Source', '-', 'Maximize'] }
    ];

    config.resize_enabled = false;
    config.title = false;

    config.extraAllowedContent = 'img[src,width,height,alt,title]';

    //config.extraPlugins = 'kityformula';
    
    // config.stylesSet = 'my_styles';
    config.codeSnippet_theme = 'zenburn';

    
};
