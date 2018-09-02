"use strict"

function checkEs6Compatibility() {
    "use strict";

    try { eval("class CheckEs6CompatibilityTestClass {} class CheckEs6CompatibilityTestClass2 extends CheckEs6CompatibilityTestClass {constructor(){super();}}"); }
    catch (e) { return false; }
    return true;
}

if (!checkEs6Compatibility()) {
    alert('Unfortunately your browser does not support the ES2015 features used to create this encoder/decoder.\n\nThis page is unlikely to work properly in your browser and may generate syntax errors and warnings.');
}