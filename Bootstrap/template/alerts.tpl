<?
  var connotation = "infozzz";
  var user={
	name:"OSC-2"
  };
  function addLink(k){
	return "http://www.oschina.net/?p="+k;
  }
?>
<div class="alert alert- alert-block">
<div class="alert alert-${connotation}">
	<button type="button" class="close" data-dismiss="alert">X</button>
	<h4>${connotation}!</h4>Best check yo self, ${user.name} you're not...
</div>

<?for(var k=1;k<10;k++){?>
<span id="id_${k}">${addLink(k)}</span>
<?}?>

<?for(var k=0;k<$.fields.length;k++){?>
<input name="${$.fields[k].Name}" id="${$.fields[k].Name}" type="text">

<?}?>