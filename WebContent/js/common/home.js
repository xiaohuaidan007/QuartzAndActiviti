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

// 初始化左侧
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
//    	dataInfo = {'id':'1','text':'导航','attributes':{'url':''},'children':[
//                     {'id':'2','text':'工作流','attributes':{'url':''},'children':[
//   	                    {'id':'3','text':'运行中流程','attributes':{'url':activitiCtx+'/workflow/processinstance/running'},'children':[]},
//                        {'id':'4','text':'已结束流程','attributes':{'url':activitiCtx+'/workflow/processinstance/end'},'children':[]},
//                        {'id':'5','text':'流程监控','attributes':{'url':activitiCtx+'/monitor/main'},'children':[]},
//                        {'id':'6','text':'节点时间窗口','attributes':{'url':activitiCtx+'/timewindow/manage'},'children':[]},
//                        {'id':'7','text':'流程定义列表','attributes':{'url':activitiCtx+'/form/dynamic/process-list'},'children':[]},
//                        {'id':'8','text':'流程批量操作','attributes':{'url':activitiCtx+'/form/dynamic/batch-process-list'},'children':[]}
//                     ]}
//                  ]};
//    }else{
//    	dataInfo = {'id':'1','text':'导航','attributes':{'url':''},'children':[
//                     {'id':'2','text':'工作流','attributes':{'url':''},'children':[
//   	                    {'id':'3','text':'运行中流程','attributes':{'url':activitiCtx+'/workflow/processinstance/running'},'children':[]},
//                        {'id':'4','text':'已结束流程','attributes':{'url':activitiCtx+'/workflow/processinstance/end'},'children':[]},   
//                        {'id':'5','text':'流程监控','attributes':{'url':activitiCtx+'/monitor/main'},'children':[]},
//                        {'id':'6','text':'节点时间窗口','attributes':{'url':activitiCtx+'/timewindow/manage'},'children':[]},
//                        {'id':'7','text':'流程定义列表','attributes':{'url':activitiCtx+'/form/dynamic/process-list'},'children':[]},
//                        {'id':'8','text':'流程批量操作','attributes':{'url':activitiCtx+'/form/dynamic/batch-process-list'},'children':[]},
//                        {'id':'9','text':'流程部署管理','attributes':{'url':activitiCtx+'/workflow/process-list'},'children':[]},
//                        {'id':'10','text':'流程模型设计区','attributes':{'url':activitiCtx+'/workflow/model/list'},'children':[]},
//                        {'id':'11','text':'用户与组','attributes':{'url':activitiCtx+'/management/identity/user/list'},'children':[]},
//                        {'id':'12','text':'数据同步','attributes':{'url':mvcCtx+'/datasync/monitor/main'},'children':[]}
//                     ]},
//                     {'id':'13','text':'定时任务','attributes':{'url':''},'children':[
//   	                    {'id':'14','text':'任务列表','attributes':{'url':mvcCtx+'/job/initTask'},'children':[]},
//                        {'id':'15','text':'添加任务','attributes':{'url':mvcCtx+'/job/showAddTask'},'children':[]},
//                        {'id':'16','text':'运行中任务','attributes':{'url':mvcCtx+'/job/getAllRunSchedJobs'},'children':[]},
//                        {'id':'17','text':'任务日志','attributes':{'url':mvcCtx+'/job/showHisTask'},'children':[]}
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
// 获取左侧导航的图标
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
	/* 双击关闭TAB选项卡 */
	$(".tabs-inner").dblclick(function() {
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close', subtitle);
	});
	/* 为选项卡绑定右键 */
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
// 绑定右键菜单事件
function tabCloseEven() {
	// 刷新
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
	// 关闭当前;
	$('#mm-tabclose').click(function() {
		var currtab_title = $('#mm').data("currtab");
		$('#tabs').tabs('close', currtab_title);
	});
	// 全部关闭
	$('#mm-tabcloseall').click(function() {
		$('.tabs-inner span').each(function(i, n) {
			var t = $(n).text();
			$('#tabs').tabs('close', t);
		});
	});
	// 关闭除当前之外的TAB
	$('#mm-tabcloseother').click(function() {
		$('#mm-tabcloseright').click();
		$('#mm-tabcloseleft').click();
	});
	// 关闭当前右侧的TAB
	$('#mm-tabcloseright').click(function() {
		var nextall = $('.tabs-selected').nextAll();
		if (nextall.length == 0) {
			msgShow('系统提示', '后边没有啦~~', 'error');

			return false;
		}
		nextall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			$('#tabs').tabs('close', t);
		});
		return false;
	});
	// 关闭当前左侧的TAB
	$('#mm-tabcloseleft').click(function() {
		var prevall = $('.tabs-selected').prevAll();
		if (prevall.length == 0) {
			alert('到头了，前边没有啦~~');
			return false;
		}
		prevall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			$('#tabs').tabs('close', t);
		});
		return false;
	});

	// 退出
	$("#mm-exit").click(function() {
		$('#mm').menu('hide');
	});
}

// 弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
	$.messager.alert(title, msgString, msgType);
}

// 设置登录窗口
function openPwd() {
	$('#w').window({
		title : '修改密码',
		width : 300,
		modal : true,
		shadow : true,
		closed : true,
		height : 190,
		resizable : false
	});
}
// 关闭登录窗口
function closePwd() {
	$('#w').window('close');
}

// 修改密码
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
				$.messager.alert('系统提示', '恭喜，密码修改成功！');
			}
		}
	});
	$.post('/ajax/editpassword.ashx?newpass=' + $newpass.val(), function(msg) {
		msgShow('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + msg, 'info');
		$newpass.val('');
		$rePass.val('');
		close();
	});

}

function operateStatus(val,row,index){
	if(val == 0){
		return "停用";
	}else if(val == 1){
		return "启用";
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
			data : $('#resetForm').serialize(),// 你的formid
			dataType : 'json',
			error : function(request) {
				$.messager.alert('Error', '连接异常');
			},
			success : function(result) {
				if (result.errorMsg) {
					$.messager.alert('Error', result.errorMsg);
				} else {
					$('#resetWindow').window('close');
					$.messager.alert('Success', '操作成功');
				}
			}
		});
	}
}

function validateForm(){
	$('#password').validatebox({
		required: true, 
		missingMessage:"密码不能为空"
	});
}

$.ajaxSetup({      
	   contentType:"application/x-www-form-urlencoded;charset=utf-8",      
	   complete:function(XMLHttpRequest,textStatus){   
	       // 通过XMLHttpRequest取得响应头，sessionstatus，   
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
* 获得最上层的window对象
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