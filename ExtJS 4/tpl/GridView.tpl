
Ext.require([
    'Ext.grid.*',
    'Ext.data.*',
    'Ext.util.*',
    'Ext.toolbar.Paging',
    'Ext.ux.PreviewPlugin',
    'Ext.ModelManager',
    'Ext.tip.QuickTipManager',
	'Ext.ux.RowExpander',
    'Ext.selection.CheckboxModel'
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
	,
	<?endif?>
	{name:"${col.Name}",type:"${(col.DataType=='double'?'float':col.DataType)}", convert: null, defaultValue: undefined}

	<?count++;?>
	<?endlist?>
    ],
    idProperty: ''
});
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
        store: store,
		stateful: ${this.options.Stateful},
        collapsible: ${this.options.Collapsible},
        multiSelect: ${this.options.MultiSelect},
		
		<?if this.options.Plugin.WithCheckbox?>
		selModel:Ext.create('Ext.selection.CheckboxModel'),
		<?endif?>
		
        <?if this.options.ColumnLines?>
		columnLines: true,
		<?endif?>
		
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
        text: '${col.Name}',
		dataIndex: '${col.Name}',
		menuDisabled:${!col.HasMenu},
        sortable : ${col.Sortable},
		
		<?if col.Render?>
		renderer: ${col.Name}_render,
		<?endif?>
		
		<?if col.Locked?>
		locked: true,
		<?endif?>
		
        flex: 1
        }
		<?count++;?>
		<?endlist?>
		<?if this.options.GenerateActionColumn?>
        ,{
        menuDisabled: true,
        sortable: false,
        xtype: 'actioncolumn',
        width: 50,
        items: [{
            icon:'',
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
			,
			<?endif?>
			'<p><b>${col.Name}:</b> {${col.Name}}</p>'
			<?endlist?>
            ]
        }
		<?endif?>
		],
        title: '${this.options.Title}',
        renderTo: '${this.renderTo}',
        viewConfig: {
            stripeRows: true,
            enableTextSelection: true
        }
    });
	/*End Copy*/
});