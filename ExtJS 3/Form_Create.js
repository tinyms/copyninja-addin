var map = {
	opts:cn.options,
	table:cn.table
};
cn.result = cn.render(cn.home+"tpl/Form.tpl",map);
var preview = {
	javascript: cn.result
}
var html = cn.render(cn.home+"tpl/FormPreview.tpl",preview);
cn.write(cn.home+"index.html",html);