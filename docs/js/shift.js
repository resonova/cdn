function bodyShiftA() {
    document.body.innerHTML = "<div class=\"header\"><div class=\"container\"><h3 class=\"display-4\">shift.js<\/h3><p class=\"header-desc\">Switch between HTML pages with pure JavaScript<\/p><\/div><\/div><div class=\"content\"><div class=\"container\"><div class=\"card animated fadeInUp\"><div class=\"card-body\"><div class=\"card-title\"><h3>[ 2 ]<\/h3><\/div><div class=\"card-text\"><hr><p>The secondary HTML page<\/p><button class=\"button btn\" onclick=\"bodyShiftB()\">SHIFT<\/button><\/div><\/div><\/div><\/div><\/div>";
}
function bodyShiftB() {
	document.body.innerHTML = "<div class=\"header\"><div class=\"container\"><h3 class=\"display-4\">shift.js<\/h3><p class=\"header-desc\">Switch between HTML pages with pure JavaScript<\/p><\/div><\/div><div class=\"content\"><div class=\"container\"><div class=\"card animated fadeInUp\"><div class=\"card-body\"><div class=\"card-title\"><h3>[ 1 ]<\/h3><\/div><div class=\"card-text\"><hr><p>The initial HTML page<\/p><button class=\"button btn\" onclick=\"bodyShiftA()\">SHIFT<\/button><\/div><\/div><\/div><\/div><\/div>";
}
