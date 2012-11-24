<?if(this.Event.OnSuccess!=""){?>
function ${this.Event.OnSuccess}(data,textStatus,jqXHR){
}
<?}?>
<?if(this.FormID!=""){?>
var data = $("#${this.FormID}").serialize();
<?}else{?>
var data = {};
<?}?>
$.post({
  url: "${this.Url}",
  data: data,
  <?if(this.Event.OnSuccess!=""){?>
  success:${this.Event.OnSuccess},
  <?}else{?>
  function(data,textStatus,jqXHR){
  },
  <?}?>
  dataType: "${this.DataType}"
});