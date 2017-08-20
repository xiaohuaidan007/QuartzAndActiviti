/* Catalan translation for the jQuery Timepicker Addon */
/* Written by Henry Yan */
(function($) {
	if ($.datepicker) {
		$.datepicker.regional['zh-CN'] = {
			closeText: '�ر�',
			prevText: '&#x3C;����',
			nextText: '����&#x3E;',
			currentText: '����',
			monthNames: ['һ��', '����', '����', '����', '����', '����', '����', '����', '����', 'ʮ��', 'ʮһ��', 'ʮ����'],
			monthNamesShort: ['һ', '��', '��', '��', '��', '��', '��', '��', '��', 'ʮ', 'ʮһ', 'ʮ��'],
			dayNames: ['������', '����һ', '���ڶ�', '������', '������', '������', '������'],
			dayNamesShort: ['����', '��һ', '�ܶ�', '����', '����', '����', '����'],
			dayNamesMin: ['��', 'һ', '��', '��', '��', '��', '��'],
			weekHeader: '��',
			dateFormat: 'yy-mm-dd',
			firstDay: 1,
			isRTL: false,
			showMonthAfterYear: true,
			yearSuffix: '��'
		};
		$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
	}
	
	if ($.timepicker) {
		$.timepicker.regional['zh-CN'] = {
			timeOnlyTitle: 'ѡ��ʱ��',
			timeText: 'ʱ��',
			hourText: 'Сʱ',
			minuteText: '����',
			secondText: '��',
			millisecText: '����',
			timezoneText: 'ʱ��',
			currentText: '��ǰ',
			closeText: 'ȷ��',
			timeFormat: 'hh:mm',
			amNames: ['����', 'A'],
			pmNames: ['����', 'P']
		};
		$.timepicker.setDefaults($.timepicker.regional['zh-CN']);
	}
})(jQuery);
