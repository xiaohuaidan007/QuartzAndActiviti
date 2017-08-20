(function($) {  
    /** 
     * jQuery EasyUI 1.4 --- ������չ 
     *  
     * Copyright (c) 2009-2015 RCM 
     * 
     * ���� validatebox У����� 
     * 
     */  
    $.extend($.fn.validatebox.defaults.rules, {  
        idcard: {  
            validator: function(value, param) {  
                return idCardNoUtil.checkIdCardNo(value);  
            },  
            message: '��������ȷ�����֤����'  
        },  
        checkNum: {  
            validator: function(value, param) {  
                return /^([0-9]+)$/.test(value);  
            },  
            message: '����������'  
        },  
        checkFloat: {  
            validator: function(value, param) {  
                return /^[+|-]?([0-9]+\.[0-9]+)|[0-9]+$/.test(value);  
            },  
            message: '������Ϸ�����'  
        },
        checkProcessKey: {  
            validator: function(value, param) {  
                return /^[a-zA-Z0-9_]+$/.test(value);  
            },  
            message: '���̶���KEYֻ�ܰ�����ĸ�����ֺ��»���'  
        }
    });  
})(jQuery);  