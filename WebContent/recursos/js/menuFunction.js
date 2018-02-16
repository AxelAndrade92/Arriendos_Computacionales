$(document).ready(function() {
});
function index(id) {
	if (id != null) {
		$("#accordian ul li").removeClass('active');
		$("#accordian ul #l"+id).addClass("active");
	}
}
function color(id) {
	$(".active ul li").removeClass("colorSelected");
	$(".active ul #a"+id).addClass("colorSelected");
}
function PopupCenter(pageURL, title, w, h) {
	var left = (screen.width / 2) - (w / 2);
	var top = (screen.height / 2) - (h / 2);
	var targetWin = window.open(pageURL, title,
			'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=yes, copyhistory=no, width=' + w
					+ ', height=' + h + ', top=' + top + ', left=' + left);
}
