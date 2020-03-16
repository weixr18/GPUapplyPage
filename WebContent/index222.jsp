<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <script type="text/javascript">
        function show_alert() {
            alert('第一行\n第二行');
        }
        function show_confirm() {
            var result = confirm('是否删除！');
            if (result) {
                alert('删除成功！');
            } else {
                alert('不删除！');
            }
        }
        function show_prompt() {
            var value = prompt('输入你的名字：', '默认名字');
            if (value == null) {
                alert('你取消了输入！');
            } else if (value == '') {
                alert('姓名输入为空，请重新输入！');
                show_prompt();
            } else {
                alert('你好，' + value);
            }
        }
    </script>

<link rel="stylesheet"  type="text/css"  href="css/linkcss.css"/>

</head>

<body>
    <input id="alert_button" type="button" value="alert" onclick="show_alert()">
    <input id="confirm_button" type="button" value="confirm" onclick="show_confirm()">
    <input id="prompt_button" type="button" value="prompt" onclick="show_prompt()">
<div>
    <input type="text" id="input"/>
    <input type="button" id="codei" onclick="createsuiji()"/>
    <input type="button" value="验证" onclick="valued()"/>
</div>


<script>
var code="";//定义一个空数组 用来存放生成的验证码
    function createsuiji(){//封装一个随机产生数组的函数
        code="";//在产生下一组验证码，清空验证码字符串
        var codelength=6;//验证码长度
        var checkeCode=document.getElementById("codei");//获取验证码框的的class标签
        //定义含有大小写，数字的数组 以供后面随机产生验证码
        var random=new Array (0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I', 'J','K','L','M','N','O','P','Q','R','S','T','W','U','V','Y','Z','W','a','b','c','d','e','f'
                ,'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
        for(var i=0;i<codelength;i++){//每次自动产生一位验证码
            var index=Math.floor(Math.random()*62);//在62位数组元素中随机产生一位
            code+=random[index];//将6位拼接
        }
        checkeCode.value=code;//将产生的验证码显示在验证码显示框中
    }
    function valued(){//封装验证码是否正确的函数
        var inputCode=document.getElementById("input").value;
        if(inputCode.length<=0){
            alert("请输入验证码：")
        }
        else if(inputCode!=code){
            alert("错误");
            createsuiji();//验证失败重新调随机产生验证码的函数
            document.getElementById("input").value="";
        }
        else{
            alert("ok");
        }
    }
</script>



<div class="code">
  <input type="text" value="" placeholder="请输入验证码（不区分大小写）" class="input-val">
  <canvas id="canvas" width="100" height="30"></canvas>
  <button class="btn">提交</button>
 </div>

<script type="text/javascript" src="js/jquery-3.3.1.min.js" ></script>
<script>
 $(function(){
  var show_num = [];
  draw(show_num);
  $("#canvas").on('click',function(){
   draw(show_num);
  })
  $(".btn").on('click',function(){
   var val = $(".input-val").val().toLowerCase();
   var num = show_num.join("");
   if(val==''){
    alert('请输入验证码！');
   }else if(val == num){
    alert('提交成功！');
    $(".input-val").val('');
    // draw(show_num);
   }else{
    alert('验证码错误！请重新输入！');
    $(".input-val").val('');
    // draw(show_num);
   }
  })
 })
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
   // var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
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
</script>

</body>

</html>