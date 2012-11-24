var map = {
	options:cn.options,
	table:cn.table
};
cn.result = cn.render(cn.home+"tpl/PropertyGrid.tpl",map);
var preview = {
	javascript: cn.result,
	containerId: cn.options.RenderTo==""?"grid":cn.options.RenderTo
}
var html = cn.render(cn.home+"tpl/CommonPreview.tpl",preview);
cn.write(cn.home+"index.html",html);