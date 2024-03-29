Ext.require([
    'Ext.form.field.ComboBox',
    'Ext.form.FieldSet',
    'Ext.tip.QuickTipManager',
    'Ext.data.*'
]);

Ext.onReady(function() {
    Ext.tip.QuickTipManager.init();
	/*Copy*/
	Ext.define('${this.table.Name}', {
    extend: 'Ext.data.Model',
    fields: [
	<?
	var count = 0;
	var displayField = "";
	var valueField = "";
	?>
	<?list this.table.Columns as col?>
	<?if(col.IsExclude){continue;}?>
	<?if(col.DisplayField){displayField=col.Name;}?>
	<?if(col.ValueField){valueField=col.Name;}?>
	<?if count!=0?>
	,
	<?endif?>
	{name:"${col.Name}",type:"${(col.DataType=='double'?'float':col.DataType)}"}

	<?count++;?>
	<?endlist?>
    ]
	});

	var store = Ext.create('Ext.data.JsonStore', {
			autoDestroy: true,
			model: '${this.table.Name}',
			data: test_data
		});
    var combobox = Ext.create('Ext.form.field.ComboBox', {
        fieldLabel: "${this.opts.FieldLabel}",
        renderTo: '${this.renderTo}',
        displayField: '${displayField}',
		valueField:'${valueField}',
        width: 320,
        labelWidth: 130,
		editable: ${this.opts.Editable},
        store: store,
        queryMode: 'local',
		
		<?if this.opts.UseTemplate?>
		listConfig: {
            getInnerTpl: function() {
                return '<div>render your data</div>';
            }
        },
		<?endif?>
		
		<?if this.opts.MultiSelect?>
		multiSelect: true,
		<?endif?>
		
		typeAhead: true
    });
	
	<?if this.opts.Event.Select?>
		combobox.on('select',function(combo,records,eopts){});
	<?endif?>
	/*End Copy*/
});