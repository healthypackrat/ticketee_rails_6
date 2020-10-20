window.addEventListener("turbolinks:load", () => {
  const tags = document.getElementsByClassName("tags");
  if (!tags.length) return;
  const removeEls = tags[0].getElementsByClassName("remove");

  for (let removeEl of removeEls) {
    removeEl.addEventListener("ajax:success", () => {
      const parent = removeEl.parentNode;
      parent.parentNode.removeChild(parent);
    });
  }
});
