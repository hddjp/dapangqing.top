var submit=document.getElementById("register");
var username=document.getElementsByClassName("name")[1];
var password=document.getElementsByClassName("password")[1];
var email=document.getElementsByClassName("email")[1];
var con=document.getElementsByClassName("confirm")[0];
var check=document.getElementsByClassName("check")[0];
var RegExpmail = /^[a-zA-z0-9]+([-_\.]*[a-zA-z0-9]+)*@([a-zA-z0-9]+[-_\.]?)*[a-zA-z0-9]+\.[a-zA-Z]{2,4}$/;
var strong=document.getElementsByClassName("strong")[0];
var key=document.getElementsByName("key")[0];
var strength;

window.onload=function(){
    strong.innerHTML="密码强度：弱";
    strong.style.color="red";
}

//检测密码强度
password.addEventListener("input",function(){
    strength=0;
    if(/[0-9]+/.test(password.value)){
        strength++;
    }
    if(/[0-9]{3,}/.test(password.value)){
        strength+=2;
    }
    if(/[a-z]+/.test(password.value)){
        strength++;
    }
    if(/[a-z]{3,}/.test(password.value)){
        strength+=2;
    } 
    if(/[A-Z]+/.test(password.value)){
        strength++;
    }
    if(/[A-Z]{3,}/.test(password.value)){
        strength+=2;
    }
    if(/[_|\-|+|=|*|!|@|#|$|%|^|&|(|)]+/.test(password.value)){
        strength+=2;
    }
    if(/[_|\-|+|=|*|!|@|#|$|%|^|&|(|)]{3,}/.test(password.value)){
        strength++;
    }
    if(password.value.length>= 9){
        strength++;
    }
    if(strength<5){
        strong.innerHTML="密码强度：弱";
        strong.style.color="red";
    }else if(strength<9){
        strong.innerHTML="密码强度：中";
        strong.style.color="yellow";
    }else{
        strong.innerHTML="密码强度：强";
        strong.style.color="green";
    }
})

submit.addEventListener("click",function(e){
    if(!username.value){
        alert("请输入您的用户名");
        e.preventDefault();
    }else if(!password.value){
        alert("请输入您的密码");
        e.preventDefault();
    }else if(!email.value){
        alert("请输入您的邮箱");
        e.preventDefault();
    }else if(!con.value){
        alert("请确认您的密码");
        e.preventDefault();
    }else if(!check.value){
        alert("请输入验证码");
        e.preventDefault();
    }else if(!RegExpmail.test(email.value)){
        alert("邮箱格式不正确，请重新输入!");
        e.preventDefault();
    }else if(username.value.length<4||username.value.length>15){
        alert("请输入一个在4-15位之间的用户名！");
        e.preventDefault();
    }else if(password.value.length<6||username.value.length>12){
        alert("请输入一个在6-12位之间的密码！");
        e.preventDefault();
    }else if(password.value!=con.value){
        alert("两次输入密码不一致！");
        e.preventDefault();
    }else if(strength<5){
        alert("密码强度过低，请更换!");
        e.preventDefault();
    }else{
        var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
        var res = "";
        for(var i = 0; i < 16 ; i ++) {
            var id = Math.ceil(Math.random()*35);
            res += chars[id];
        }
           
        key.value=res;
        var pass = CryptoJS.enc.Utf8.parse(password.value);
        var encrypted = CryptoJS.AES.encrypt(pass, CryptoJS.enc.Utf8.parse(res), {mode: CryptoJS.mode.ECB, padding: CryptoJS.pad.Pkcs7});
        var encryptedPwd = encrypted.toString();
        password.value=encryptedPwd;
    }
})