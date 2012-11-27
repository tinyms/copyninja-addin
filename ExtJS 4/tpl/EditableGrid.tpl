Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', 'extjs4/ux/');
Ext.require([
    'Ext.grid.*',
    'Ext.data.*',
    'Ext.util.*',
    'Ext.toolbar.Paging',
    'Ext.ux.PreviewPlugin',
    'Ext.ModelManager',
    'Ext.tip.QuickTipManager',
    'Ext.selection.CheckboxModel',
	'Ext.form.*',
    'Ext.ux.CheckColumn'
]);

Ext.onReady(function() {
    Ext.QuickTips.init();
    Ext.state.Manager.setProvider(Ext.create('Ext.state.CookieProvider'));
	/*Copy*/
	Ext.define('${this.table.Name}', {
    extend: 'Ext.data.Model',
    fields: [
	<?var count = 0;?>
	<?list this.table.Columns as col?>
	<?if(col.IsExclude){continue;}?>
	<?if count!=0?>
	,{name:"${col.Name}",type:"${(col.DataType=='double'?'float':col.DataType)}", convert: null, defaultValue: undefined}
	<?else?>
	{name:"${col.Name}",type:"${(col.DataType=='double'?'float':col.DataType)}", convert: null, defaultValue: undefined}
	<?endif?>
	<?count++;?>
	<?endlist?>
    ],
    idProperty: ''
});
<?if this.options.EditMode=="Row"?>
var editMode = Ext.create('Ext.grid.plugin.RowEditing', {
        clicksToMoveEditor: 1,
        autoCancel: false
    });	
<?else?>	
var editMode = Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 1
    });
<?endif?>
	<?list this.table.Columns as col?>
	<?if(col.IsExclude){continue;}?>
	<?if col.Render?>
	function ${col.Name}_render(val,p,record) {
        return '<span style="color:green;">' + val + '</span>';
    }
	<?endif?>
	<?endlist?>
    var store = Ext.create('Ext.data.JsonStore', {
        model: '${this.table.Name}',
        data: test_data
    });
    var grid = Ext.create('Ext.grid.Panel', {
		title: '${this.options.Title}',
        renderTo: '${this.renderTo}',
        store: store,
		<?if this.options.Plugin.WithCheckbox?>
		selModel:Ext.create('Ext.selection.CheckboxModel'),
		<?endif?>
		<?if this.options.ColumnLines?>
		columnLines: true,
		<?endif?>
        stateful: ${this.options.Stateful},
        collapsible: ${this.options.Collapsible},
        multiSelect: ${this.options.MultiSelect},
        columns: [
		<?if this.options.Plugin.WithNumbered?>
		<?if this.table.Columns.length>0?>
		Ext.create('Ext.grid.RowNumberer'),
		<?else?>
		Ext.create('Ext.grid.RowNumberer')
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
		dataIndex: '${col.Name}',
		menuDisabled:${!col.HasMenu},
        flex: 1,
        sortable : ${col.Sortable},
		<?if col.Render?>
		renderer: ${col.Name}_render,
		<?endif?>
		<?if col.Locked?>
		locked: true,
		<?endif?>
		<?if col.DataType=="double"||col.DataType=="int"?>
		editor: {
                xtype: 'numberfield',
                allowBlank: ${col.AllowBlank}
            }
		<?elseif col.DataType=="date"?>
		editor: {
                xtype: 'datefield',
                format: 'm/d/y'
            }
		<?elseif col.DataType=="bool"?>
		xtype: 'checkcolumn'
		<?else?>
		editor:{allowBlank:${col.AllowBlank}}
		<?endif?>
        }
		<?count++;?>
		<?endlist?>
		<?if this.options.GenerateActionColumn?>
        ,{
        menuDisabled: true,
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
		bbar: Ext.create('Ext.PagingToolbar', {
            store: store,
            displayInfo: true,
			<?if this.options.Pager.Style=="Sliding"?>
			plugins: Ext.create('Ext.ux.SlidingPager', {}),
			<?elseif this.options.Pager.Style=="ProgressBar"?>
			plugins: Ext.create('Ext.ux.ProgressBarPager', {}),
			<?endif?>
            items:[]
        }),
		<?endif?>
		plugins:[
		<?if this.options.Plugin.RowExpander?>
		{
            ptype: 'rowexpander',
            rowBodyTpl : [
			<?list this.table.Columns as index col?>
			<?if index!=0?>
			,'<p><b>${col.Name}:</b> {${col.Name}}</p>'
			<?else?>
			'<p><b>${col.Name}:</b> {${col.Name}}</p>'
			<?endif?>
			<?endlist?>
            ]
        }
		<?endif?>
		],
		plugins: [editMode]
    });
	/*End Copy*/
});