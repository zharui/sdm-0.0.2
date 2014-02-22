/**
 * 点击按钮式下拉菜单时，将下拉菜单中的内容填充到上边
 */
$("ul.selectable > li").click(function(){
    $('span.selectedTxt',$(this).parent().parent().children("button")[0]).text($("a",this).text());
});
/**
 * 新建媒体
 */
$("#createMedia").click(function(){
    window.location = "createPublisher";
});
/**
 * 新建频道
 */
//$("#createChannel").click(function(){
//    window.location = "createChannel";
//});
/**
 * 新建广告主
 */
//$("#createAdvertising").click(function(){
//    window.location = "createAdvertising.html";
//});
/**
 * 新建广告位
 */
//$("#createAdSpace").click(function(){
//    window.location = "createAdSpace.html";
//});
/**
 * 新建网盟
 */
$("#createWebunion").click(function(){
    window.location = "createWebunion.html";
});
/**
 * 模态框--Delete
 */

