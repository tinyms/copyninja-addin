<?if(this.Event.OnSuccess!=""){?>
function ${this.Event.OnSuccess}(data,textStatus,jqXHR){
}
<?}?>
<?if(this.Event.OnError!=""){?>
function ${this.Event.OnError}(jqXHR,textStatus,errorThrown){
}
<?}?>
<?if(this.Event.OnComplete!=""){?>
function ${this.Event.OnComplete}(jqXHR,textStatus){
}
<?}?>
<?if(this.FormID!=""){?>
var data = $("#${this.FormID}").serialize();
<?}else{?>
var data = {};
<?}?>
$.ajax({
  type:"${this.Type}",
  url: "${this.Url}",
  data: data,
  <?if(!this.Setting.Async){?>
  async:false,
  <?}?>
  <?if(!this.Setting.Cache){?>
  cache:false,
  <?}?>
  <?if(this.Setting.CrossDomain){?>
  crossDomain:true,
  <?}?>
  <?if(this.Event.OnSuccess!=""){?>
  success:${this.Event.OnSuccess},
  <?}else{?>
  success:function(data,textStatus,jqXHR){
  },
  <?}?>
  <?if(this.Event.OnError!=""){?>
  error:${this.Event.OnError},
  <?}?>
  <?if(this.Event.OnComplete!=""){?>
  complete:${this.Event.OnComplete},
  <?}?>
  <?if(this.StatusCode!=""){var codes = this.StatusCode.split(",");var count=0;?>
  statusCode:{
  <?list codes as code?>
   <?if(count>0){?>
   ,
   <?}?>
   ${code}:function(){
   }
   <?count++;?>
  <?endlist?>
  },
  <?}?>
  dataType: "${this.DataType}"
});