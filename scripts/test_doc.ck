@import "../src/CKTest.ck";

CKDoc ckdoc;
ckdoc.addGroup(["CKTest"], "Testing", "test", "");
ckdoc.outputToDir("../docs", "ChucK Test" );
