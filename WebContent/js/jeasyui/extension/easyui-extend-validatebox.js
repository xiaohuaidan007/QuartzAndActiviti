(function($) {  
    /** 
     * jQuery EasyUI 1.4 --- 功能扩展 
     *  
     * Copyright (c) 2009-2015 RCM 
     * 
     * 新增 validatebox 校验规则 
     * 
     */  
    $.extend($.fn.validatebox.defaults.rules, {  
        idcard: {  
            validator: function(value, param) {  
                return idCardNoUtil.checkIdCardNo(value);  
            },  
            message: '请输入正确的身份证号码'  
        },  
        checkNum: {  
            validator: function(value, param) {  
                return /^([0-9]+)$/.test(value);  
            },  
            message: '请输入整数'  
        },  
        checkFloat: {  
            validator: function(value, param) {  
                return /^[+|-]?([0-9]+\.[0-9]+)|[0-9]+$/.test(value);  
            },  
            message: '请输入合法数字'  
        },
        checkProcessKey: {  
            validator: function(value, param) {  
                return /^[a-zA-Z0-9_]+$/.test(value);  
            },  
            message: '流程定义KEY只能包含字母、数字和下划线'  
        }
    });  
})(jQuery);  