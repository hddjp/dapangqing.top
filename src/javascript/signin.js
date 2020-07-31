var username=document.getElementsByClassName("name")[1];
var pass=document.getElementsByClassName("password")[1];
var check=document.getElementsByClassName("check")[0];
var submit=document.getElementById("signin");
var key=document.getElementsByName("key")[0];

submit.addEventListener("click",function(e){
    if(!username.value){
        alert("请输入您的用户名");
        e.preventDefault();
    }else if(!pass.value){
        alert("请输入您的密码");
        e.preventDefault();
    }else if(!check.value){
        alert("请输入验证码")
        e.preventDefault();
    }else{
        var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
        var res = "";
        for(var i = 0; i < 16 ; i ++) {
            var id = Math.ceil(Math.random()*35);
            res += chars[id];
        }
           
        key.value=res;
        var password = CryptoJS.enc.Utf8.parse(pass.value);
        var encrypted = CryptoJS.AES.encrypt(password, CryptoJS.enc.Utf8.parse(res), {mode: CryptoJS.mode.ECB, padding: CryptoJS.pad.Pkcs7});
        var encryptedPwd = encrypted.toString();
        pass.value=encryptedPwd;
    }
})