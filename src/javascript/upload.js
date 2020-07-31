

window.onload=function(){
    function changepic() {
        var reads = new FileReader();
        f = document.getElementsByClassName('file')[0].files[0];
        reads.readAsDataURL(f);
        reads.onload = function(e) {
        document.getElementsByClassName('uploadimg')[0].src = this.result;
        document.getElementsByClassName('uploadimg')[0].classList.add("after");
        };
    }
    

    document.getElementsByClassName("file")[0].addEventListener("change",function(){
        changepic(this);
    })
    var v=countrySelect.value
    var cities1=document.getElementsByClassName(v);
    for(let city of cities1){
        citySelect.innerHTML+="<option value='"+city.value+"'>"+city.text+"</option>";
    }

}

var cities=document.getElementsByName("city1");

var countrySelect=document.getElementsByName("country")[0];
var citySelect=document.getElementsByName("city")[0];
countrySelect.addEventListener("change",function(){
    citySelect.innerHTML="<option value=''>--</option>";
    var v=countrySelect.value
    var cities1=document.getElementsByClassName(v);
    for(let city of cities1){
        citySelect.innerHTML+="<option value='"+city.value+"'>"+city.text+"</option>";
    }
})

var submit=document.getElementsByClassName('submit')[0];
var pic=document.getElementsByClassName('file')[0];
var title=document.getElementsByName('title')[0];
var description=document.getElementsByClassName('description')[0];
var country=document.getElementsByName('country')[0];
var city=document.getElementsByName('city')[0];
var imgid=document.getElementsByName("id")[0];
var file=document.getElementsByName("file")[0];
submit.addEventListener("click",function(e){
    if(title.value==""||description.value==""||country.value==""||city.value==""){
        alert("有信息没有填入，请补充完整");
        e.preventDefault();
    }else if(imgid==null&&file.value==""){
        alert("请选择上传的图片");
        e.preventDefault();
    }
})