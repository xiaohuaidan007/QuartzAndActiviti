
function loadMask(){
	$("<div class=\"datagrid-mask\" style='position:absoulte;z-index:9998;'></div>").css({ display: "block", width: "100%", height: $(window).height()}).appendTo("body");  
    $("<div class=\"datagrid-mask-msg\" style='position:absoulte;z-index:9999;'></div>").html("ÕýÔÚ²Ù×÷£¬ÇëÉÔºò¡£¡£¡£").appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });  
}

function disLoadMask(){
	$(".datagrid-mask").remove();  
    $(".datagrid-mask-msg").remove();  
}


