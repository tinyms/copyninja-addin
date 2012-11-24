var colNames = [];
var params_ = [];
var pks = [];
var pk_params_ = [];
var index = 0;
var pkIndex = 0;
for(var k=0;k<cn.table.Columns.length;k++){
	var col = cn.table.Columns[k];
	if(col.PrimaryKey){
		pks[pkIndex] = col.Name;
		if(cn.options.Pattern=="None"){
			pk_params_[pkIndex] = cn.options.Placeholder;
		}else if(cn.options.Pattern=="Name"){
			pk_params_[pkIndex] = cn.options.Placeholder+col.Name;
		}else if(cn.options.Pattern=="Number"){
			pk_params_[pkIndex] = cn.options.Placeholder+index;
		}
		pkIndex++;
	}
	if(col.IsExclude){continue;}
	if(col.AutoValue){continue;}
	colNames[index] = col.Name;
	if(cn.options.Pattern=="None"){
		params_[index] = cn.options.Placeholder;
	}else if(cn.options.Pattern=="Name"){
		params_[index] = cn.options.Placeholder+col.Name;
	}else if(cn.options.Pattern=="Number"){
		params_[index] = cn.options.Placeholder+index;
	}
	index++;
}
var set_value_str = [];
for(var k=0;k<colNames.length;k++){
	set_value_str[k] = colNames[k]+"="+params_[k];
}
var where_str = [];
for(var k=0;k<pks.length;k++){
	where_str[k] = pks[k]+"="+pk_params_[k];
}
cn.result = "UPDATE "+cn.table.Name+" SET "+set_value_str.join()+" WHERE "+where_str.join(" AND ");