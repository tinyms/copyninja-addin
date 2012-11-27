Ext.onReady(function() {
    Ext.QuickTips.init();
	/*Copy*/
	Ext.form.Field.prototype.msgTarget = 'side';
	var col_width_scale = 1/${this.opts.Columns}
	 var panel = new Ext.FormPanel({ 
        id: 'form',
		collapsible: true,
        url: '',
		labelAlign: '${this.opts.LabelAlign}',
		labelWidth: ${this.opts.LabelWidth},
        frame: true,
        title: 'Form',
		width: ${this.opts.Width},
		<?if this.opts.Layout!="HBox"?>
		bodyStyle:'padding:5px 5px 0',
		defaultType: 'textfield',
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
		?>
		<?if count!=0?>
		,
		<?endif?>
		{name:"${col.Name}",fieldLabel:"${col.Name}",allowBlank: ${col.AllowBlank}${xtype}}

		<?count++;?>
		<?endlist?>
		],
		<?else?>
		items:[{
            layout: 'column',
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
			if(this.table.Columns[k].IsExclude){
				continue;
			}
			fields[row_count][col_count] = this.table.Columns[k];
			col_count++;
		}
		?>
		<?
			for(var c=0;c<col_num;c++){
			var end = "";
			var anchor = "95";
			if(c!=col_num-1){end=",";anchor="95";}
		?>
			{
                layout: 'form',
				columnWidth:col_width_scale,
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
		?>
		${innerEnd}{
                    fieldLabel: '${col.Name}',
                    allowBlank: ${col.AllowBlank},
                    name: '${col.Name}',
                    anchor:'${anchor}%'${xtype}
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
                Ext.getCmp('form').isValid();
            }
        },{
            text: 'Cancel',
            handler: function() {
                Ext.getCmp('form').reset();
            }
        }]
    });

    panel.render(document.body);
	/*End Copy*/
});	