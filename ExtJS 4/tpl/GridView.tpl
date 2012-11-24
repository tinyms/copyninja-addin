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
	,{name:"${col.Name}",type:"${(col.DataType=='double'?'float':col.DataType)}", convert: null, defaultValue: undefined}
	<?else?>
	{name:"${col.Name}",type:"${(col.DataType=='double'?'float':col.DataType)}", convert: null, defaultValue: undefined}
	<?endif?>
	<?count++;?>
	<?endlist?>
    ],
    idProperty: 'company'
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
		<?if this.options.Plugin.WithCheckbox?>
		selModel:Ext.create('Ext.selection.CheckboxModel'),
		<?endif?>
        stateful: ${this.options.Stateful},
        collapsible: ${this.options.Collapsible},
        multiSelect: ${this.options.MultiSelect},
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
		,{
        text: '${col.Name}',
        flex: 1,
        sortable : ${col.Sortable},
		<?if col.Render?>
		renderer: ${col.Name}_render,
		<?endif?>
		<?if col.Locked?>
		locked: true,
		<?endif?>
        dataIndex: '${col.Name}'
        }
		<?else?>
		{
        text     : '${col.Name}',
        flex     : 1,
        sortable : ${col.Sortable},
		<?if col.Render?>
		renderer: ${col.Name}_render,
		<?endif?>
		<?if col.Locked?>
		locked: true,
		<?endif?>
        dataIndex: '${col.Name}'
        }
		<?endif?>
		<?count++;?>
		<?endlist?>
		<?if this.options.GenerateActionColumn?>
        ,{
        menuDisabled: true,
        sortable: false,
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
        title: '${this.options.Title}',
        renderTo: '${this.renderTo}',
        viewConfig: {
            stripeRows: true,
            enableTextSelection: true
        }
    });
	/*End Copy*/
});