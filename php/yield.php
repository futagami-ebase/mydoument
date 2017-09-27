<?php

$yield = new YieldSample ();

$selectGenerator = $yield->selectYield();
$selectGenerator->send(2);
echo $selectGenerator->current();
$selectGenerator->next();
echo $selectGenerator->current();
$selectGenerator->next();
echo $selectGenerator->current();

/*
$selectGenerator->send(1);
$selectGenerator->send(2);

$out['current1'] = $yield->simpleYield()->current();
$out['next']     = $yield->simpleYield()->next();
$out['current2'] = $yield->simpleYield()->current();

var_dump($out);

echo '------------------' . PHP_EOL;

$simpleGenerator = $yield->simpleYield();
$out['current1'] = $simpleGenerator->current();
$out['next']     = $simpleGenerator->next();
$out['current2'] = $simpleGenerator->current();

var_dump($out);

echo '------------------' . PHP_EOL;

$closureGenerator = function () {
  yield 'a 1 time' . PHP_EOL;
  yield 'a 2 time' . PHP_EOL;
};

$out['current1'] = $closureGenerator()->current();
$out['next']     = $closureGenerator()->next();
$out['current2'] = $closureGenerator()->current();

var_dump($out);

foreach($closureGenerator() as $value) {
  echo $value . PHP_EOL;
}
@@@@*/

class YieldSample
{

  /**
   * yield処理の単純な呼び出し
   * ※呼び出し可能回数は2回
   *
   */
  public function simpleYield ()
  {
    echo 'before 1 time' . PHP_EOL;
    yield '1 time';
    echo 'before 2 time' . PHP_EOL;
    yield '2 time';
  }

  /**
   * yield処理に判定処理を追加して呼び出し
   *
   */
  public function selectYield ()
  {
    echo 'before yield send' . PHP_EOL;
    $kind = yield;

    echo 'send kind value:' . $kind . PHP_EOL;

    if ($kind === 1) {
      yield 'kind:1, 1 time' . PHP_EOL;
      yield 'kind:1, 2 time' . PHP_EOL;

    } else if ($kind === 2) {
      yield 'kind:2, 1 time' . PHP_EOL;
      yield 'kind:2, 2 time' . PHP_EOL;

    } else if ($kind === 3) {
      yield 'kind:3, 1 time' . PHP_EOL;
      yield 'kind:3, 2 time' . PHP_EOL;

    }
  }

}

