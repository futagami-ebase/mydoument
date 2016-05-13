<?php
$json = shell_exec('cat ${HOME}/Library/Application\ Support/Google/Chrome/Default/Bookmarks');
$bookmarkInfos = json_decode($json, true);
$paths = array();
foreach($bookmarkInfos['roots'] as $key => $bookmarkInfo) {
  if (isset($bookmarkInfo['children'])) $paths = array_merge(createBookmarkPaths($bookmarkInfo['children'], $key), $paths);
}

foreach($paths as $path) echo $path . "\n";

function createBookmarkPaths($children, $path='')
{
  $paths = array();
  foreach($children as $child) {
    if ($child['type'] === 'folder') {
        $paths = array_merge(createBookmarkPaths($child['children'], $path . '/' . $child['name']), $paths);
    } else if ($child['type'] === 'url') {
        if (mb_strlen($child['name']) >  20) $title = mb_substr($child['name'], 0, 20, 'UTF-8') . '...';
        if (mb_strlen($child['name']) <= 20) $title = $child['name'];
        $paths[] = '/' . $path . '/'. $title . "|" . $child['url'];
    }
  }
  return $paths;
}
?>
