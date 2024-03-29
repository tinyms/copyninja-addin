<?
var cols = this.table.Columns;
var id = this.options.RenderTo==""?"grid":this.options.RenderTo;
?>
Ext.require([
 'Ext.grid.property.Grid'
]);
Ext.onReady(function(){
/*Copy*/
var propsGrid = Ext.create('Ext.grid.property.Grid', {
   width: 300,
   renderTo: '${id}',
   propertyNames: {
<?var it = 0;?>
<?list cols as index col?>
<?if(col.IsExclude){continue;}?>
<?if it!=0?>
,
<?endif?>
"${col.Name}":"${col.Name}"
<?it++;?>
<?endlist?>
   },
   source: {
<?it=0;?>   
<? list cols as index col?>
<?if(col.IsExclude){continue;}?>
<?if it!=0?>
,
<?endif?>
<?if col.DataType=="string"?>
"${col.Name}":""
<?elseif col.DataType=="bool"?>
"${col.Name}":false
<?elseif col.DataType=="date"?>
"${col.Name}":Ext.Date.parse('10/15/2006', 'm/d/Y')
<?elseif col.DataType=="long"||col.DataType=="double"||col.DataType=="int"?>
"${col.Name}":0
<?endif?>

<?it++;?>
<?endlist?>
   }
});
/*End Copy*/
});