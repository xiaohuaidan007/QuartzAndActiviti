$(function() {
	InitLeftMenu();
	tabClose();
	tabCloseEven();
	openPwd();
	$('#editpass').click(function() {
		$('#w').window('open');
	});
	$('#btnEp').click(function() {
		serverLogin();
	});
	$('#btnCancel').click(function() {
		closePwd();
	});
});

// ��ʼ�����
function InitLeftMenu() {
	/*var $div = $('div .leftmenuTitTwo');
	$div.hide();
    $("div .leftmenuTitOne").click(function(){
        $(this).next(".leftmenuTitTwo").slideToggle().siblings(".leftmenuTitTwo").hide();
    });*/
	$("#nav").accordion({
		animate : true
	});
	getMenuSources();

/*	$.each(_menus.menus, function(i, n) {
		var menulist = '';
		menulist += '<ul>';

		$.each(n.menus, function(j, o) {
			menulist += '<li><div><a ref="' + o.menuid + '" href="#" rel="'
					+ o.url + '" ><span class="icon ' + o.icon
					+ '" >&nbsp;</span><span class="nav">' + o.menuname
					+ '</span></a></div></li> ';
		});
		menulist += '</ul>';
		$('#nav').accordion('add', {
			title : n.menuname,
			animate : true,
			content : menulist,
			selected : false,
			iconCls : 'icon ' + n.icon
		});
	});*/
	

	$('.easyui-accordion li a').click(function() {
		var tabTitle = $(this).children('.nav').text();

		var url = $(this).attr("rel");
		var menuid = $(this).attr("ref");
		var icon = "";

		addTab(tabTitle, url, icon);
		$('.easyui-accordion li div').removeClass("selected");
		$(this).parent().addClass("selected");
	}).hover(function() {
		$(this).parent().addClass("hover");
	}, function() {
		$(this).parent().removeClass("hover");
	});
}

function getMenuSources(){
	debugger;		
	var juserid = $('#juserid').val();
    var dataInfo=new Object();
	$.ajax({
        type: 'POST',
        data: {},
        dataType: "json",
        url:mvcCtx+'/lpt/jmenu/'+juserid,
        //async:true,
        success: function(data){
        	dataInfo = data;
        	$.each(dataInfo.children,function(i,n){
        		var menulist = '';
        		menulist += '<ul>';
        		var titleIcon;
        		var titleName;
            		$.each(n.children,function(o,p){
            			menulist += '<li><div><a name="menu_a_" ref="' + p.id + '" href="#" rel="'
        				+ (mvcCtx+p.attributes.url) + '" ><span class="icon ' + ''
        				+ '" >&nbsp;</span><span class="nav">' + p.text
        				+ '</span></a></div></li> ';
            		});
                	titleName = n.text;
                	titleIcon = n.iconCls;
                    menulist += '</ul>';
//             		alert(menulist);
                    $('#nav').accordion('add',{
              			title : titleName,
              			animate : true,
              			content : menulist,
              			selected : false,
              			iconCls : 'icon ' + titleIcon
                    });
            });
        	
        	$('.easyui-accordion li a').click(function() {
        		var tabTitle = $(this).children('.nav').text();

        		var url = $(this).attr("rel");
//        		var menuid = $(this).attr("ref");
        		var icon = "";

        		addTab(tabTitle, url, icon);
        		$('.easyui-accordion li div').removeClass("selected");
        		$(this).parent().addClass("selected");
        	}).hover(function() {
        		$(this).parent().addClass("hover");
        	}, function() {
        		$(this).parent().removeClass("hover");
        	});
        }
    }); 
    var modle = $('#modle').val();
//    if(modle=='mac'){
//    	dataInfo = {'id':'1','text':'����','attributes':{'url':''},'children':[
//                     {'id':'2','text':'������','attributes':{'url':''},'children':[
//   	                    {'id':'3','text':'����������','attributes':{'url':activitiCtx+'/workflow/processinstance/running'},'children':[]},
//                        {'id':'4','text':'�ѽ�������','attributes':{'url':activitiCtx+'/workflow/processinstance/end'},'children':[]},
//                        {'id':'5','text':'���̼��','attributes':{'url':activitiCtx+'/monitor/main'},'children':[]},
//                        {'id':'6','text':'�ڵ�ʱ�䴰��','attributes':{'url':activitiCtx+'/timewindow/manage'},'children':[]},
//                        {'id':'7','text':'���̶����б�','attributes':{'url':activitiCtx+'/form/dynamic/process-list'},'children':[]},
//                        {'id':'8','text':'������������','attributes':{'url':activitiCtx+'/form/dynamic/batch-process-list'},'children':[]}
//                     ]}
//                  ]};
//    }else{
//    	dataInfo = {'id':'1','text':'����','attributes':{'url':''},'children':[
//                     {'id':'2','text':'������','attributes':{'url':''},'children':[
//   	                    {'id':'3','text':'����������','attributes':{'url':activitiCtx+'/workflow/processinstance/running'},'children':[]},
//                        {'id':'4','text':'�ѽ�������','attributes':{'url':activitiCtx+'/workflow/processinstance/end'},'children':[]},   
//                        {'id':'5','text':'���̼��','attributes':{'url':activitiCtx+'/monitor/main'},'children':[]},
//                        {'id':'6','text':'�ڵ�ʱ�䴰��','attributes':{'url':activitiCtx+'/timewindow/manage'},'children':[]},
//                        {'id':'7','text':'���̶����б�','attributes':{'url':activitiCtx+'/form/dynamic/process-list'},'children':[]},
//                        {'id':'8','text':'������������','attributes':{'url':activitiCtx+'/form/dynamic/batch-process-list'},'children':[]},
//                        {'id':'9','text':'���̲������','attributes':{'url':activitiCtx+'/workflow/process-list'},'children':[]},
//                        {'id':'10','text':'����ģ�������','attributes':{'url':activitiCtx+'/workflow/model/list'},'children':[]},
//                        {'id':'11','text':'�û�����','attributes':{'url':activitiCtx+'/management/identity/user/list'},'children':[]},
//                        {'id':'12','text':'����ͬ��','attributes':{'url':mvcCtx+'/datasync/monitor/main'},'children':[]}
//                     ]},
//                     {'id':'13','text':'��ʱ����','attributes':{'url':''},'children':[
//   	                    {'id':'14','text':'�����б�','attributes':{'url':mvcCtx+'/job/initTask'},'children':[]},
//                        {'id':'15','text':'�������','attributes':{'url':mvcCtx+'/job/showAddTask'},'children':[]},
//                        {'id':'16','text':'����������','attributes':{'url':mvcCtx+'/job/getAllRunSchedJobs'},'children':[]},
//                        {'id':'17','text':'������־','attributes':{'url':mvcCtx+'/job/showHisTask'},'children':[]}
//                     ]}
//                  ]};
//    }
//    
//    $.each(dataInfo.children,function(i,n){
//		var menulist = '';
//		menulist += '<ul>';
//		var titleIcon;
//		var titleName;
//    		$.each(n.children,function(o,p){
//    			menulist += '<li><div><a name="menu_a_" ref="' + p.id + '" href="#" rel="'
//				+ p.attributes.url + '" ><span class="icon ' + ''
//				+ '" >&nbsp;</span><span class="nav">' + p.text
//				+ '</span></a></div></li> ';
//    		});
//        	titleName = n.text;
//        	titleIcon = n.iconCls;
//            menulist += '</ul>';
////     		alert(menulist);
//            $('#nav').accordion('add',{
//      			title : titleName,
//      			animate : true,
//      			content : menulist,
//      			selected : false,
//      			iconCls : 'icon ' + titleIcon
//            });
//    });

	
}
// ��ȡ��ർ����ͼ��
function getIcon(menuid) {
	var icon = 'icon ';
	$.each(_menus.menus, function(i, n) {
		$.each(n.menus, function(j, o) {
			if (o.menuid == menuid) {
				icon += o.icon;
			}
		});
	});

	return icon;
}

function addTab(subtitle, url, icon) {
	if (!$('#tabs').tabs('exists', subtitle)) {
		$('#tabs').tabs('add', {
			title : subtitle,
			content : createFrame(url),
			closable : true,
			icon : icon
		});
	} else {
		$('#tabs').tabs('select', subtitle);
		$('#mm-tabupdate').click();
	}
	tabClose();
}

function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="' + url
			+ '" style="width:100%;height:100%;"></iframe>';
	return s;
}

function tabClose() {
	/* ˫���ر�TABѡ� */
	$(".tabs-inner").dblclick(function() {
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close', subtitle);
	});
	/* Ϊѡ����Ҽ� */
	$(".tabs-inner").bind('contextmenu', function(e) {
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});

		var subtitle = $(this).children(".tabs-closable").text();

		$('#mm').data("currtab", subtitle);
		$('#tabs').tabs('select', subtitle);
		return false;
	});
}
// ���Ҽ��˵��¼�
function tabCloseEven() {
	// ˢ��
	$('#mm-tabupdate').click(function() {
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		$('#tabs').tabs('update', {
			tab : currTab,
			options : {
				content : createFrame(url)
			}
		});
	});
	// �رյ�ǰ;
	$('#mm-tabclose').click(function() {
		var currtab_title = $('#mm').data("currtab");
		$('#tabs').tabs('close', currtab_title);
	});
	// ȫ���ر�
	$('#mm-tabcloseall').click(function() {
		$('.tabs-inner span').each(function(i, n) {
			var t = $(n).text();
			$('#tabs').tabs('close', t);
		});
	});
	// �رճ���ǰ֮���TAB
	$('#mm-tabcloseother').click(function() {
		$('#mm-tabcloseright').click();
		$('#mm-tabcloseleft').click();
	});
	// �رյ�ǰ�Ҳ��TAB
	$('#mm-tabcloseright').click(function() {
		var nextall = $('.tabs-selected').nextAll();
		if (nextall.length == 0) {
			msgShow('ϵͳ��ʾ', '���û����~~', 'error');

			return false;
		}
		nextall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			$('#tabs').tabs('close', t);
		});
		return false;
	});
	// �رյ�ǰ����TAB
	$('#mm-tabcloseleft').click(function() {
		var prevall = $('.tabs-selected').prevAll();
		if (prevall.length == 0) {
			alert('��ͷ�ˣ�ǰ��û����~~');
			return false;
		}
		prevall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			$('#tabs').tabs('close', t);
		});
		return false;
	});

	// �˳�
	$("#mm-exit").click(function() {
		$('#mm').menu('hide');
	});
}

// ������Ϣ���� title:���� msgString:��ʾ��Ϣ msgType:��Ϣ���� [error,info,question,warning]
function msgShow(title, msgString, msgType) {
	$.messager.alert(title, msgString, msgType);
}

// ���õ�¼����
function openPwd() {
	$('#w').window({
		title : '�޸�����',
		width : 300,
		modal : true,
		shadow : true,
		closed : true,
		height : 190,
		resizable : false
	});
}
// �رյ�¼����
function closePwd() {
	$('#w').window('close');
}

// �޸�����
function serverLogin() {
	$.messager.progress('resize');
	$('#updatePwdFm').form('submit', {
		url: '/ht/updateUserPwd.do',
		onSubmit:function(){
			return $(this).form('validate');
		},
		success: function(result){
			$.messager.progress('resize',100);
			$.messager.progress('close');
			$('#w').window('close');
			if (result.errorMsg) {
				$.messager.alert('Error', result.errorMsg);
			} else {
				$.messager.alert('ϵͳ��ʾ', '��ϲ�������޸ĳɹ���');
			}
		}
	});
	$.post('/ajax/editpassword.ashx?newpass=' + $newpass.val(), function(msg) {
		msgShow('ϵͳ��ʾ', '��ϲ�������޸ĳɹ���<br>����������Ϊ��' + msg, 'info');
		$newpass.val('');
		$rePass.val('');
		close();
	});

}

function operateStatus(val,row,index){
	if(val == 0){
		return "ͣ��";
	}else if(val == 1){
		return "����";
	}else{
		return "";
	}
}

function fileRight(url){

	/*$.ajax( {
		url : url,
		type : 'GET',
		dataType : 'html',
		success : function(data) {
			$('#resetWindow').window('open');
		},
		error: function(data){
			$('#resetWindow').window('open');
			alert(data);
		}
	});*/
	$('#resetWindow').window('open');
	$('#resetWindow').window('refresh', url);
}

function logout(url){
	window.location.href = mvcCtx+'/logout';
}

function updateUserPwd(){
	if($('#resetForm').form('validate')){
		$.ajax({
			type : 'POST',
			url : path+'ht/user/updateUserPwd.do',
			data : $('#resetForm').serialize(),// ���formid
			dataType : 'json',
			error : function(request) {
				$.messager.alert('Error', '�����쳣');
			},
			success : function(result) {
				if (result.errorMsg) {
					$.messager.alert('Error', result.errorMsg);
				} else {
					$('#resetWindow').window('close');
					$.messager.alert('Success', '�����ɹ�');
				}
			}
		});
	}
}

function validateForm(){
	$('#password').validatebox({
		required: true, 
		missingMessage:"���벻��Ϊ��"
	});
}

$.ajaxSetup({      
	   contentType:"application/x-www-form-urlencoded;charset=utf-8",      
	   complete:function(XMLHttpRequest,textStatus){   
	       // ͨ��XMLHttpRequestȡ����Ӧͷ��sessionstatus��   
	       try{
		       var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus");   
		       if(sessionstatus!=null&&sessionstatus=="sessionOut"){
		    	   var topWinObj = getTopWin();
		           topWinObj.location.href = path+'/logout.do';
		       }   
		   }catch(e){
			   
	       }
	   }   
});

/**
* ������ϲ��window����
*/
function getTopWin() {
	if(parent) {
	    var tempParent = parent;
	    while(true) {
	        if(tempParent.parent) {
	            if(tempParent.parent == tempParent) {
	                break;
	            }
	            tempParent = tempParent.parent;
	        } else {
	            break;
	        }
	    }
	    return tempParent;
	} else {
	    return window;
	}
}