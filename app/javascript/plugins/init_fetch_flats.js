const initFetchFlats = () => {
  console.log("init fetchflats");
  const fetchButton = document.getElementById("fetch-button");
  fetchButton.addEventListener("click", fetchFlats);
};

function fetchFlats() {
  try {
    fetch("/flats/", {
      headers: {
        Accept: "application/json",
      },
    })
      .then((response) => console.log(response))
      .then((data) => console.log(data));
  } catch (error) {
    console.log(error);
  }
}

function handleClick() {
  console.log("hey");
}

export { initFetchFlats };
