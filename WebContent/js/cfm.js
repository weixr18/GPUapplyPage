var submit=false;
var row = -1;
var col = -1;

//页面初始化
$(function(){
	var show_num = [];
	draw(show_num);
	
	//更改验证码
	$("#canvas").on('click',function(){
		draw(show_num);
	})
	
	//点击提交
	$(".btn").on('click',function(){
		var val = $(".input-cfm").val().toLowerCase();
		var num = show_num.join("");
		var id = $("#id").val();
		var name = $("#username").val()
		var reg = /20\d{8}/;
		
		var j = jQuery.parseJSON($('#isBooked').val());
		var isB = j.isBooked;
		
		var j2 = jQuery.parseJSON($('#names').val());
		var names = j.names;
		
		var j3 = jQuery.parseJSON($('#ids').val());
		var ids = j.ids;
		
		
		if(name==''){
			alert('请输入姓名！');
		}else if(id==''){
			alert('请输入学号！');
		}else if(id.search(reg) == -1){
			alert('学号格式错误！');
		}else if(col == -1 || row == -1){
			alert('尚未选取申请时段！');
		}else if(isB[row-1][col-1]){
			alert('该时段已被占据！');
		}else if(names.indexOf(name) > -1){
			alert('您尚有一预约时段未使用！');
		}else if(ids.indexOf(parseInt(id)) > -1){
			alert('您尚有一预约时段未使用！');
		}else if(val==''){
			alert('请输入验证码！');
		}else if(val == num){
			$(".input-cfm").val('');
			$("#id").val('');
			$("#username").val('');
			Submit(name, id, row, col);
		}else{
			alert('验证码错误！请重新输入！');
			draw(show_num);
			$(".input-cfm").val('');
		}
	})
})

/**********验证码***********/

//生成并渲染出验证码图形
function draw(show_num) {
	var canvas_width=$('#canvas').width();
	var canvas_height=$('#canvas').height();
	var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
	var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
	canvas.width = canvas_width;
	canvas.height = canvas_height;
	var sCode = "a,b,c,d,e,f,g,h,i,j,k,m,n,p,q,r,s,t,u,v,w,x,y,z,A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
	var aCode = sCode.split(",");
	var aLength = aCode.length;//获取到数组的长度
	for (var i = 0; i < 4; i++) { //这里的for循环可以控制验证码位数（如果想显示6位数，4改成6即可）
		var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
		var deg = Math.random() - 0.5; //产生一个随机弧度
		var txt = aCode[j];//得到随机的一个内容
		show_num[i] = txt.toLowerCase();
		var x = 10 + i * 20;//文字在canvas上的x坐标
		var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
		context.font = "bold 23px 微软雅黑";
		context.translate(x, y);
		context.rotate(deg);
		context.fillStyle = randomColor();
		context.fillText(txt, 0, 0);
		context.rotate(-deg);
		context.translate(-x, -y);
	}
	for (var i = 0; i <= 5; i++) { //验证码上显示线条
		context.strokeStyle = randomColor();
		context.beginPath();
		context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
		context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
		context.stroke();
	}
	for (var i = 0; i <= 30; i++) { //验证码上显示小点
		context.strokeStyle = randomColor();
		context.beginPath();
		var x = Math.random() * canvas_width;
		var y = Math.random() * canvas_height;
		context.moveTo(x, y);
		context.lineTo(x + 1, y + 1);
		context.stroke();
	}
}

//得到随机的颜色值
function randomColor() {
	var r = Math.floor(Math.random() * 256);
	var g = Math.floor(Math.random() * 256);
	var b = Math.floor(Math.random() * 256);
	return "rgb(" + r + "," + g + "," + b + ")";
}


/***************表格处理****************/
var td;
var orgcolor;
var time = 0;


function TabClick()
{
	if(time>0){
		td.style.background = orgcolor;
	}
		
	td = event.srcElement; // 通过event.srcElement 获取激活事件的对象 td
	
	row = td.parentElement.rowIndex;
	col = td.cellIndex;
	
	if(row >= 1 && row <= 8 &&
			col >= 1 && col <= 8){
		orgcolor = td.style.background;
		td.style.background = "#dcf0b4";
		time++;
	}
}




/***************申请提交****************/

//提交申请
function Submit(name, id, row, col)
{
	console.log("进入ajax提交请求环节");
	var nowDate = new Date();
	var ta = document.getElementById("ta");
	var aptDate = ta.rows[0].cells[col].innerHTML;
	var aptPeriod = row;
	
	$.ajax({
        type: "POST",
        traditional: true,
        url: "./ApplyServlet", 
        data: {
        	"name":name,
        	"id":id,
        	"apply_time":nowDate,
        	"appointment_date":aptDate,
        	"appointment_period":aptPeriod,
        },
        dataType: "json",
        
        success: function(data) {
        	str = "提交成功\n" + "您的用户名是："+data.username+"\n"+"您的密码是："+data.password+"\n"+"请您在预定的时间登陆服务器进行使用"
			alert(str);
			
			console.log("insertdate="+data.insertstate);
			location.reload();
		},
		error: function(xhr, type, errorThrown) {
			alert("提交失败，请重新操作\n" + data);
		}
        });
}

