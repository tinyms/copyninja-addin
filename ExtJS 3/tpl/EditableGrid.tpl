Ext.onReady(function() {
    Ext.QuickTips.init();
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
	/*Copy*/
	
	<?list this.table.Columns as col?>
	<?if(col.IsExclude){continue;}?>
	<?if col.Render?>
	function ${col.Name}_render(val,p,record) {
        return '<span style="color:green;">' + val + '</span>';
    }
	<?endif?>
	<?endlist?>
	
	var store = new Ext.data.JsonStore({
		autoDestroy: true,
		storeId: '${this.table.Name}',
        fields: [
        <?var count = 0;?>
		<?list this.table.Columns as col?>
		<?if(col.IsExclude){continue;}?>
		<?if count!=0?>
		,
		<?endif?>
		{name:"${col.Name}",type:"${(col.DataType=='double'?'float':col.DataType)}"}
		<?count++;?>
		<?endlist?>
        ]
    });
	
	store.loadData(test_data);
	
	<?if this.options.EditMode=="Row"?>
	var editor = new Ext.ux.grid.RowEditor({
		saveText: 'Update'
	});
	<?endif?>
	
	<?if this.options.Plugin.WithCheckbox?>
	var sm = new Ext.grid.CheckboxSelectionModel();
	<?endif?>
	
    var grid = new Ext.grid.EditorGridPanel({
        store: store,
		title: '${this.options.Title}',
		autoHeight: true,
		loadMask:true,
		stateful: ${this.options.Stateful},
        collapsible: ${this.options.Collapsible},
        multiSelect: ${this.options.MultiSelect},
		
		<?if this.options.EditMode=="Row"?>
		plugins: [editor],
		<?endif?>
		
		<?if this.options.Plugin.WithCheckbox?>
		sm:sm,
		<?endif?>
        
        <?if this.options.ColumnLines?>
		columnLines: true,
		<?endif?>
		
        columns: [
		
		<?if this.options.Plugin.WithNumbered?>
			<?if this.table.Columns.length>0?>
			new Ext.grid.RowNumberer(),
			<?else?>
			new Ext.grid.RowNumberer()
			<?endif?>
		<?endif?>
		
		<?if this.options.Plugin.WithCheckbox?>
			<?if this.table.Columns.length>0?>
			sm,
			<?else?>
			sm
			<?endif?>
		<?endif?>
		
		<?var count = 0;?>
		<?list this.table.Columns as col?>
		<?if(col.IsExclude){continue;}?>
		
		<?if count!=0?>
		,
		<?endif?>
		{
        header: '${col.Name}',
        flex: 1,
        sortable : ${col.Sortable},
		menuDisabled: ${!col.HasMenu},
		<?if col.DataType=="date"?>
		editor: new Ext.form.DateField(),
		<?elseif col.DataType=="long"||col.DataType=="double"?>
		editor: new Ext.form.NumberField({allowBlank:${col.AllowBlank}}),
		<?elseif col.DataType=="bool"?>
		xtype: 'checkcolumn',
		<?else?>
		editor: new Ext.form.TextField({allowBlank: ${col.AllowBlank}}),
		<?endif?>
		
		<?if col.Locked?>
		locked: true,
		<?endif?>
		
        dataIndex: '${col.Name}'
        }
		<?count++;?>
		<?endlist?>
		<?if this.options.GenerateActionColumn?>
        ,{
        xtype: 'actioncolumn',
        width: 50,
        items: [{
            icon:'',  // Use a URL in the icon config
            tooltip:'',
            handler: function(grid, rowIndex, colIndex) {       
            }
        }]
        }
		<?endif?>
        ],
		<?if this.options.Pager.Enable?>
			bbar: new Ext.PagingToolbar({
			store: store,
			<?if this.options.Pager.Style=="Sliding"?>
				plugins: new Ext.ux.SlidingPager(),
			<?elseif this.options.Pager.Style=="ProgressBar"?>
				plugins: new Ext.ux.ProgressBarPager(),
			<?endif?>
			pageSize: 25
		}),
		<?endif?>
        
        renderTo: '${this.renderTo}'
    });
	/*End Copy*/
});