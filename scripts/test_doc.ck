@import "../src/test.ck";

CKDoc ckdoc;
ckdoc.addGroup(["Test"], "Testing", "test", "");
ckdoc.outputToDir("../docs", "ChucK Test" );
