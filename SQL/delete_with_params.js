var pks = [];
var pk_params_ = [];
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
			var placeHolderIndex = pkIndex+1;
			pk_params_[pkIndex] = cn.options.Placeholder+placeHolderIndex;
		}
		pkIndex++;
	}
}

var where_str = [];
for(var k=0;k<pks.length;k++){
	where_str[k] = pks[k]+"="+pk_params_[k];
}
cn.result = "DELETE FROM "+cn.table.Name+" WHERE "+where_str.join(" AND ");