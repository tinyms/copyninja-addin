<?
var cols = this.table.Columns;
var id = this.options.RenderTo==""?"grid":this.options.RenderTo;
?>
Ext.onReady(function(){
/*Copy*/
var propsGrid = new Ext.grid.PropertyGrid({
   width: 300,
   autoHeight: true,
   renderTo: '${id}',
   propertyNames: {
<?var it = 0;?>
<?list cols as index col?>
<?if(col.IsExclude){continue;}?>
<?if it!=0?>
,"${col.Name}":"${col.Name}"
<?else?>
"${col.Name}":"${col.Name}"
<?endif?>
<?it++;?>
<?endlist?>
   },
   source: {
<?it=0;?>   
<? list cols as index col?>
<?if(col.IsExclude){continue;}?>
<?if it!=0?>

<?if col.DataType=="string"?>
,"${col.Name}":""
<?elseif col.DataType=="bool"?>
,"${col.Name}":false
<?elseif col.DataType=="date"?>
,"${col.Name}":new Date()
<?elseif col.DataType=="long"||col.DataType=="double"||col.DataType=="int"?>
,"${col.Name}":0
<?endif?>

<?else?>
<?if col.DataType=="string"?>
"${col.Name}":""
<?elseif col.DataType=="bool"?>
"${col.Name}":false
<?elseif col.DataType=="date"?>
"${col.Name}":new Date()
<?elseif col.DataType=="long"||col.DataType=="double"||col.DataType=="int"?>
"${col.Name}":0
<?endif?>
<?endif?>
<?it++;?>
<?endlist?>
   },
    viewConfig : {
    forceFit: true,
    scrollOffset: 2
    }
});
/*End Copy*/
});