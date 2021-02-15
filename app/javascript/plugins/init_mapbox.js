import mapboxgl from "mapbox-gl";

const initMapbox = () => {
  const mapElement = document.getElementById("map");

  if (mapElement) {
    console.log("mappymappy");
    // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v10",
    });
  }
};

export { initMapbox };

// import mapboxgl from "mapbox-gl";

// const initMapbox = () => {
//   const mapElement = document.getElementById("map");

//   if (mapElement) {
//     // only build a map if there's a div#map to inject into
//     mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
//     const map = new mapboxgl.Map({
//       container: "map",
//       style: "mapbox://styles/mapbox/streets-v10",
//     });
//   }
// };

// export { initMapbox };
