var store = new Ext.data.JsonStore({
		autoDestroy: true,
		autoLoad: true,
		storeId:'${this.table.Name}',
		method:'GET',
		url:'demo_data.json',
		fields: [
		<?
		var count = 0;
		var displayField = "text";
		var valueField = "value";
		?>
		<?list this.table.Columns as col?>
		<?if(col.IsExclude){continue;}?>
		<?if(col.DisplayField){displayField=col.Name;}?>
		<?if(col.ValueField){valueField=col.Name;}?>
		<?if count!=0?>
		,'${col.Name}'
		<?else?>
		'${col.Name}'
		<?endif?>
		<?count++;?>
		<?endlist?>
		]
	});
Ext.onReady(function() {
    Ext.QuickTips.init();
	
    var combobox = new Ext.form.ComboBox({
        fieldLabel: "${this.opts.FieldLabel}",
        renderTo: '${this.renderTo}',
        displayField: '${displayField}',
		valueField:'${valueField}',
        width: 320,
        labelWidth: 130,
        store: store,
        model: 'local',
		triggerAction:'all',
		editable:false,
		lazyRender:false,
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

});