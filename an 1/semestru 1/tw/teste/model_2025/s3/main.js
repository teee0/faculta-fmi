window.onload = function () {
  document.body.addEventListener("keydown", function (event) {
    if (event.key === "s") {
      let paragraphs = document.querySelectorAll("p");
      let combinedText = Array.from(paragraphs)
        .map((p) => p.textContent)
        .join("\n"); // Combine text with newline
      let linesArray = combinedText.split("\n"); // Split into an array by newlines

      console.log(linesArray);
      let paragraf = Array.from(paragrafe).filter(function (para) {
        return para.textContent.split().length > 4;
      }); //parseInt(input.value());
      console.log(paragrafe);
      let input = document.getElementById("numar");
      for (let para of paragrafe) {
        para.remove();
      }
    }
  });
};
