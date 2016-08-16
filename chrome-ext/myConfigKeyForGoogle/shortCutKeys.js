document.addEventListener("keydown", (e) => {
  // ctrl + f
  if (e.ctrlKey && e.keyCode === 70) {
    document.getElementById('lst-ib').focus();
  }
  // ctrl + g
  if (e.ctrlKey && e.keyCode === 71) {
    let activeEle = document.activeElement;
    if (activeEle) {
      activeEle.blur();
    }
    document.getElementById('rso').focus();
    window.scrollTo(0,0);
  }
});
