/**
 * ��̬��Javascript�������ȡ��Ԫ�ء���������
 */

/**
 * ��ȡ���ֶ�
 */

function readFormFields(processDefinitionId) {
	var dialog = this;

	// ��նԻ�������
	$('#dynamic-form-content').html("<form id='dynamic-form' method='post'><table class='dynamic-form-table'></table></form>");
	var $form = $('#dynamic-form');
	// ��ȡ����ʱ�ı�
	$.getJSON(activitiCtx + '/form/dynamic/get-form/start/' + processDefinitionId, function(data) {
		$.each(data.form.formProperties, function() {
			var className = '';var data_options='';
			$('.dynamic-form-table').append(createFieldHtml(data, this, className, data_options));
			if(this.type.name=='date'){
				$('#'+this.id).datetimebox({
				    required: true,
				    showSeconds: false
				});
			}else if(this.type.name=='enum'){
				$('#'+this.id).datetimebox({
					valueField:'id',
				    textField:'text'
				});
			}
			if(this.required == true){
				$('#'+this.id).validatebox({
				    required: true
				});
			}
		});
		// ����֤
		$('#dynamic-form').form({
		    url:activitiCtx + '/form/dynamic/start-process/' + processDefinitionId,
		    onSubmit: function(){
		        // do some check
		        // return false to prevent submit;
		    	var s = $(this).form('validate');
		    	if(s){
		    		loadMask();
		    	}
				return s;
		    },
		    success:function(data){
		    	disLoadMask();
		    	var obj = JSON.parse(data);
                if(obj.success){  
                    $.messager.alert('��Ϣ',obj.message);  
                    //$('#flex').datagrid('reload');  
                    $('#dynamic-form').form('clear');  
                }else{  
                    $.messager.alert('��Ϣ',obj.message);  
                }  
		    }
		});
	});
}

/**
 * form��Ӧ��string/date/long/enum/boolean���ͱ����������
 * fp_����˼��form paremeter
 */
var formFieldCreator = {
	string: function(formData, prop, className, data_options) {
		var result = "<tr><td width='120'>" + prop.name + "��</td><td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "'></td></tr>";
		return result;
	},
	date: function(formData, prop, className, data_options) {
		var result = "<tr><td>" + prop.name + "��</td><td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "'></td></tr>";
		return result;
	},
	'enum': function(formData, prop, className, data_options) {
		console.log(prop);
		var result = "<tr><td width='120'>" + prop.name + "��</td>";
		if(prop.writable === true) {
			result += "<td><select id='" + prop.id + "' name='fp_" + prop.id + "' class='easyui-combobox' data_options='"+data_options+"'></td></tr>";
			//result += "<option>" + datas + "</option>";
			
			$.each(formData['enum_' + prop.id], function(k, v) {
				result += "<option value='" + k + "'>" + v + "</option>";
			});
			 
			result += "</select>";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	},
	'users': function(formData, prop, className, data_options) {
		var result = "<tr><td width='120'>" + prop.name + "��</td><td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "' class='easyui-textbox'  data_options='"+data_options+"'></td></tr>";
		return result;
	}
};

/**
 * ����һ��field��html����
 */

function createFieldHtml(formData, prop, className, data_options) {
	return formFieldCreator[prop.type.name](formData, prop, className, data_options);
}

/**
 * ����������������
 */

function sendStartupRequest() {
	$('#dynamic-form').form('submit');
}

function createFieldSimpleHtml(formData, prop, className, data_options, required) {
	return simpleFieldCreator[prop.type.name](formData, prop, className, data_options, required);
}

var simpleFieldCreator = {
	string: function(formData, prop, className, data_options, required) {
		var rflag = (required==true?'<font style="font-weight:bold;color:red;">*</font>':'');
		var result = "<tr><td width='120'><font style='font-weight:bold;'>" + prop.name + "��</font></td><td><font style='font-weight:bold;'>" + prop.id + "</font></td><td>"+rflag+"</td></tr>";
		return result;
	},
	date: function(formData, prop, className, data_options, required) {
		var result = "<tr><td><font style='font-weight:bold;'>" + prop.name + "��</font></td><td><font style='font-weight:bold;'>" + prop.id + "</font></td><td>"+rflag+"</td></tr>";
		return result;
	},
	'enum': function(formData, prop, className, data_options, required) {
		console.log(prop);
		var result = "<tr><td width='120'><font style='font-weight:bold;'>" + prop.name + "��</font></td>";
		if(prop.writable === true) {
			result += "<td>" + prop.id + "&nbsp;&nbsp;<select id='" + prop.id + "' name='fp_" + prop.id + "' class='easyui-combobox' data_options='"+data_options+"'></td><td>"+rflag+"</td></tr>";
			//result += "<option>" + datas + "</option>";
			
			$.each(formData['enum_' + prop.id], function(k, v) {
				result += "<option value='" + k + "'>" + v + "</option>";
			});
			 
			result += "</select>";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	},
	'users': function(formData, prop, className, data_options, required) {
		var result = "<tr><td width='120'><font style='font-weight:bold;'>" + prop.name + "��</font></td><td><font style='font-weight:bold;'>" + prop.id + "</font></td><td>"+rflag+"</td></tr>";
		return result;
	}
};

//$('#submit').click(function() {
//    var d = {};
//    var t = $('form').serializeArray();
//    $.each(t, function() {
//      d[this.name] = this.value;
//    });
//    alert(JSON.stringify(d));
//  });


//$.fn.serializeObject = function()  
//{  
//   var o = {};  
//   var a = this.serializeArray();  
//   $.each(a, function() {  
//       if (o[this.name]) {  
//           if (!o[this.name].push) {  
//               o[this.name] = [o[this.name]];  
//           }  
//           o[this.name].push(this.value || '');  
//       } else {  
//           o[this.name] = this.value || '';  
//       }  
//   });  
//   return o;  
//};
//
//function onClik(){
//	    var jsonuserinfo = $('#form1').serializeObject();
//		alert(JSON.stringify(jsonuserinfo));
//}