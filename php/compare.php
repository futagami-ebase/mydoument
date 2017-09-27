<?php

echo "\n";
echo "base 1\n";
echo "cast int: ";    var_dump((int)     1);
echo "cast string: "; var_dump((string)  1);
echo "cast array: ";  var_dump((array)   1);
echo "cast float: ";  var_dump((float)   1);
echo "cast bool: ";   var_dump((boolean) 1);

echo "\n";
echo "base 0\n";
echo "cast int: ";    var_dump((int)     0);
echo "cast string: "; var_dump((string)  0);
echo "cast array: ";  var_dump((array)   0);
echo "cast float: ";  var_dump((float)   0);
echo "cast bool: ";   var_dump((boolean) 0);

echo "\n";
echo "base true\n";
echo "cast int: ";    var_dump((int)     true);
echo "cast string: "; var_dump((string)  true);
echo "cast array: ";  var_dump((array)   true);
echo "cast float: ";  var_dump((float)   true);
echo "cast bool: ";   var_dump((boolean) true);

echo "\n";
echo "base false\n";
echo "cast int: ";    var_dump((int)     false);
echo "cast string: "; var_dump((string)  false);
echo "cast array: ";  var_dump((array)   false);
echo "cast float: ";  var_dump((float)   false);
echo "cast bool: ";   var_dump((boolean) false);

echo "\n";
echo "base ''\n";
echo "cast int: ";    var_dump((int)     '');
echo "cast string: "; var_dump((string)  '');
echo "cast array: ";  var_dump((array)   '');
echo "cast float: ";  var_dump((float)   '');
echo "cast bool: ";   var_dump((boolean) '');

echo "\n";
echo "base []\n";
echo "cast int: ";    var_dump((int)     []);
echo "cast string: "; var_dump((string)  []);
echo "cast array: ";  var_dump((array)   []);
echo "cast float: ";  var_dump((float)   []);
echo "cast bool: ";   var_dump((boolean) []);

echo "\n";
echo "base null\n";
echo "cast int: ";    var_dump((int)     null);
echo "cast string: "; var_dump((string)  null);
echo "cast array: ";  var_dump((array)   null);
echo "cast float: ";  var_dump((float)   null);
echo "cast bool: ";   var_dump((boolean) null);

echo "\n";
echo "base '0'\n";
echo "cast int: ";    var_dump((int)     '0');
echo "cast string: "; var_dump((string)  '0');
echo "cast array: ";  var_dump((array)   '0');
echo "cast float: ";  var_dump((float)   '0');
echo "cast bool: ";   var_dump((boolean) '0');

echo "\n";
echo "base '1'\n";
echo "cast int: ";    var_dump((int)     '1');
echo "cast string: "; var_dump((string)  '1');
echo "cast array: ";  var_dump((array)   '1');
echo "cast float: ";  var_dump((float)   '1');
echo "cast bool: ";   var_dump((boolean) '1');

