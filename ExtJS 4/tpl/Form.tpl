Ext.require([
    '*'
]);
Ext.onReady(function() {
    Ext.QuickTips.init();
	/*Copy*/
	var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';
	
	 var panel = Ext.widget({
        xtype: 'form',
		<?if this.opts.Layout!="HBox"?>
        layout: {
		<?if this.opts.Layout=="Form"?>
		type:'form'
		<?elseif this.opts.Layout=="Table"?>
		type:'table',
		columns:${this.opts.Columns}
		<?endif?>
		},
		<?endif?>
        collapsible: true,
        id: 'form',
        url: '',
        frame: true,
        title: 'Form',
		width: ${this.opts.Width},
        bodyPadding: '5 5 0',
        fieldDefaults: {
            msgTarget: 'side',
			labelAlign: '${this.opts.LabelAlign}',
            labelWidth: ${this.opts.LabelWidth}
        },
        defaultType: 'textfield',
		<?if this.opts.Layout!="HBox"?>
        items: [
		<?var count = 0;?>
		<?list this.table.Columns as col?>
		<?if(col.IsExclude){continue;}?>
		<?
		var xtype="";
		if(col.DataType=="date"){
			xtype = ",xtype:'datefield'";
		}else if(col.DataType=="int"||col.DataType=="long"||col.DataType=="double"){
			xtype = ",xtype:'numberfield'";
		}
		var afterLabelTextTpl = "";
		if(!col.AllowBlank){
			afterLabelTextTpl = ",afterLabelTextTpl: required";
		}
		?>
		<?if count!=0?>
	,{name:"${col.Name}",fieldLabel:"${col.Name}",allowBlank: ${col.AllowBlank}${xtype}${afterLabelTextTpl}}
		<?else?>
	{name:"${col.Name}",fieldLabel:"${col.Name}",allowBlank: ${col.AllowBlank}${xtype}${afterLabelTextTpl}}
		<?endif?>
		<?count++;?>
		<?endlist?>
		],
		<?else?>
		items:[{
            xtype: 'container',
            anchor: '100%',
            layout: 'hbox',
			items:[
		<?
		var total = this.table.Columns.length;
		var col_num = this.opts.Columns;
		var row_num = Math.ceil(total/col_num);
		var fields = [];
		for(var r=0;r<row_num;r++){
			fields[r] = [];
			for(var c=0;c<col_num;c++){
				fields[r][c] = {Name:""};
			}
		}
		var row_count = 0;
		var col_count = 0;
		for(var k=0;k<total;k++){
			if(row_count==row_num){break;}
			if(col_count==col_num){
				col_count = 0;
				row_count++;
			}
			fields[row_count][col_count] = this.table.Columns[k];
			col_count++;
		}
		?>
		<?
			for(var c=0;c<col_num;c++){
			var end = "";
			var anchor = "100";
			if(c!=col_num-1){end=",";anchor="95";}
		?>
			{
                xtype: 'container',
                flex: 1,
                layout: 'anchor',
                items: [
		<?	
				for(var r=0;r<row_num;r++){
					var innerEnd = "";
					if(r!=0){innerEnd=",";}
					var col = fields[r][c];
					if(col.Name==""){innerEnd = "";break;}
					var xtype=",xtype:'textfield'";
					if(col.DataType=="date"){
						xtype = ",xtype:'datefield'";
					}else if(col.DataType=="int"||col.DataType=="long"||col.DataType=="double"){
						xtype = ",xtype:'numberfield'";
					}
					var afterLabelTextTpl = "";
					if(!col.AllowBlank){
						afterLabelTextTpl = ",afterLabelTextTpl: required";
					}
		?>
		${innerEnd}{
                    fieldLabel: '${col.Name}',
                    allowBlank: ${col.AllowBlank},
                    name: '${col.Name}',
                    anchor:'${anchor}%'${afterLabelTextTpl}${xtype}
                }
		<?
				}
				?>
				]
            }${end}
				<?
			}
		?>
		]
		}],
		<?endif?>
        buttons: [{
            text: 'Save',
            handler: function() {
                this.up('form').getForm().isValid();
            }
        },{
            text: 'Cancel',
            handler: function() {
                this.up('form').getForm().reset();
            }
        }]
    });

    panel.render(document.body);
	/*End Copy*/
});	