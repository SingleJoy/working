
//打开弹窗
function openDiv(value){
	 $("#"+value).modal();
}

//保留两位小数
function toDecimal(x) { 
   var f = parseFloat(x); 
   if (isNaN(f)) { 
   	return false; 
   } 
   var f = Math.round(x*100)/100; 
   var s = f.toString(); 
   var rs = s.indexOf('.'); 
   if (rs < 0) { 
	   rs = s.length; 
	   s += '.'; 
   } 
   while (s.length <= rs + 2) { 
  	 s += '0'; 
   } 
   return s; 
}


//阿拉伯数字转换中文数字
var N = [
	"零", "一", "二", "三", "四", "五", "六", "七", "八", "九"
];
function convertToChinese(num){
	var str = num.toString();
	var len = num.toString().length;
	var C_Num = [];
	for(var i = 0; i < len; i++){
		C_Num.push(N[str.charAt(i)]);
	}
	return C_Num.join('');
}
