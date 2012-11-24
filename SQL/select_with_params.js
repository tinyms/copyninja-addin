var colNames = [];
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
			pk_params_[pkIndex] = cn.options.Placeholder+pkIndex;
		}
		pkIndex++;
	}
	if(col.IsExclude){continue;}
	colNames[index] = col.Name;
	index++;
}

var where_str = [];
for(var k=0;k<pks.length;k++){
	where_str[k] = pks[k]+"="+pk_params_[k];
}
cn.result = "SELECT "+colNames.join()+" FROM "+cn.table.Name+" WHERE "+where_str.join(" AND ");